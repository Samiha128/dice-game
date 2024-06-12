<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
#container {
  position: fixed;
  touch-action: none;
}

#description {
  background: #FFF;
  // font-size: 20px;
  left: 50%;
  margin: 150px 0 0 0;
  padding: 0 20px;
  position: absolute;
  top: 50%;
  transform: translate(-50%, -50%);
  width: 300px;
  z-index: 2;
  
}
</style>
</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/88/three.min.js"></script>
<script id="vertexShader" type="x-shader/x-vertex">
    void main() {
        gl_Position = vec4( position, 1.0 );
    }
</script>
<script id="fragmentShader" type="x-shader/x-fragment">
  uniform vec2 u_resolution;
  uniform vec2 u_mouse;
  uniform float u_time;
  uniform sampler2D u_noise;
  uniform sampler2D u_500;
  
  #define PI 3.141592653589793
  #define TAU 6.283185307179586
  #define pow2(x) (x * x)
  
  // blur constants
  const int samples = 4;
  const float sigma = float(samples) * 0.25;

  float gaussian(vec2 i) {
    return 1.0 / (2.0 * PI * pow2(sigma)) * exp(-((pow2(i.x) + pow2(i.y)) / (2.0 * pow2(sigma))));
  }

  vec3 blur(sampler2D sp, vec2 uv, vec2 scale) {
    vec3 col = vec3(0.0);
    float accum = 0.0;
    float weight;
    vec2 offset;

    for (int x = -samples / 2; x < samples / 2; ++x) {
        for (int y = -samples / 2; y < samples / 2; ++y) {
            offset = vec2(x, y);
            weight = gaussian(offset);
            col += texture2D(sp, uv + scale * offset).rgb * weight;
            accum += weight;
        }
    }

    return col / accum;
  }

  vec2 hash2(vec2 p)
  {
    vec2 o = texture2D( u_noise, (p+0.5)/256.0, -100.0 ).xy;
    return o;
  }
  
  vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix( vec3(1.0), rgb, c.y);
  }
  
  vec3 domain(vec2 z){
    return vec3(hsb2rgb(vec3(atan(z.y,z.x)/TAU,1.,1.)));
  }
  vec3 colour(vec2 z) {
      return domain(z);
  }
  
  const int layers = 9;
  const float zoomSpeed = -4.;

  void main() {
    vec2 uv = (gl_FragCoord.xy - 0.5 * u_resolution.xy) / min(u_resolution.y, u_resolution.x);
    
    vec3 fragcolour = vec3(0.);
    float opacity = 0.;
    
    for(int i = 0; i < layers; i++) {
      float layer = float(i);
      // float scale = mod(u_time / float(layers) * layer, 1.);
      float factor = (u_time + zoomSpeed / float(layers) * float(layer)) / zoomSpeed;
      float scale = mod(factor, 1.);
      float s = sin(scale*2.-.3);
      float c = cos(scale*2.);
      vec2 _uv = uv * 4. * scale * mat2(c, -s, s, c) * (1. + cos(uv.y*5.)*.1) * (1. + sin(uv.x*.5)*.1);
      // endOpacity = smoothstep(0., 0.2, scale * -1.);
      float _opacity = (1. - scale) * smoothstep(0., 0.3, scale);
      opacity += _opacity;
      // float mask = (1. - texture2D(u_500, _uv - .5).r) * _opacity;
      float mask = (1. - blur(u_500, _uv - .5, vec2(max(0., 0.01 * (.5-scale)))).r) * _opacity;
      fragcolour += mask*mask*4.;
    }
    
    fragcolour /= opacity;

    gl_FragColor = vec4(fragcolour,1.0);
  }
</script>


<div id="container" touch-action="none"></div>
<div id="description">
  <p>Oops. Looks like it's broken. While we go down this rabbit hole, please go outside and enjoy the sunshine.</p>
  <p>If you continue to see this error, please contact Samiha and Loubna </p>
</div>
<script>
/*
Most of the stuff in here is just bootstrapping. Essentially it's just
setting ThreeJS up so that it renders a flat surface upon which to draw 
the shader. The only thing to see here really is the uniforms sent to 
the shader. Apart from that all of the magic happens in the HTML view
under the fragment shader.
*/

let container;
let camera, scene, renderer;
let uniforms;

let loader=new THREE.TextureLoader();
let textures = {
  noise: {
    url: 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/982762/noise.png',
    loaded: false
  },
  500: {
    url: 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/982762/500.png',
    loaded: false
  }
};
let texture;
let map_normal, map_colour, map_roughness;
loader.setCrossOrigin("anonymous");
let loadtex = () => {
  let allLoaded = true;
  for(let i in textures) {
    let tex = textures[i];
    if(tex.loaded === false) {
      allLoaded = false;
      loader.load(tex.url, (texture) => {
        texture.wrapS = THREE.RepeatWrapping;
        texture.wrapT = THREE.RepeatWrapping;
        texture.minFilter = THREE.LinearFilter;
        tex.texture = texture;
        tex.loaded = true;
        loadtex();
      });
      break;
    }
  }
  if(allLoaded === true) {
    init();
    animate();
  }
}
loadtex();

function init() {
  container = document.getElementById( 'container' );

  camera = new THREE.Camera();
  camera.position.z = 1;

  scene = new THREE.Scene();

  var geometry = new THREE.PlaneBufferGeometry( 2, 2 );

  uniforms = {
    u_time: { type: "f", value: 1.0 },
    u_resolution: { type: "v2", value: new THREE.Vector2() },
    u_mouse: { type: "v2", value: new THREE.Vector2() }
  };
  for(let i in textures) {
    uniforms['u_'+i] = { type: "t", value: textures[i].texture }
  }

  var material = new THREE.ShaderMaterial( {
    uniforms: uniforms,
    vertexShader: document.getElementById( 'vertexShader' ).textContent,
    fragmentShader: document.getElementById( 'fragmentShader' ).textContent
  } );
  material.extensions.derivatives = true;

  var mesh = new THREE.Mesh( geometry, material );
  scene.add( mesh );

  renderer = new THREE.WebGLRenderer();
//  renderer.setPixelRatio( window.devicePixelRatio );

  container.appendChild( renderer.domElement );

  onWindowResize();
  window.addEventListener( 'resize', onWindowResize, false );

  document.addEventListener('pointermove', (e)=> {
    let ratio = window.innerHeight / window.innerWidth;
    uniforms.u_mouse.value.x = (e.pageX - window.innerWidth / 2) / window.innerWidth / ratio;
    uniforms.u_mouse.value.y = (e.pageY - window.innerHeight / 2) / window.innerHeight * -1;
    
    e.preventDefault();
  });
}

function onWindowResize( event ) {
  renderer.setSize( window.innerWidth, window.innerHeight );
  uniforms.u_resolution.value.x = renderer.domElement.width;
  uniforms.u_resolution.value.y = renderer.domElement.height;
}

function animate(delta) {
  requestAnimationFrame( animate );
  render(delta);
}






let capturer = new CCapture( { 
  verbose: true, 
  framerate: 60,
  // motionBlurFrames: 4,
  quality: 90,
  format: 'webm',
  workersPath: 'js/'
 } );
let capturing = false;

isCapturing = function(val) {
  if(val === false && window.capturing === true) {
    capturer.stop();
    capturer.save();
  } else if(val === true && window.capturing === false) {
    capturer.start();
  }
  capturing = val;
}
toggleCapture = function() {
  isCapturing(!capturing);
}

window.addEventListener('keyup', function(e) { if(e.keyCode == 68) toggleCapture(); });

let then = 0;
function render(delta) {
  
  uniforms.u_time.value = -10000 + delta * 0.0005;
  renderer.render( scene, camera );
  
  if(capturing) {
    capturer.capture( renderer.domElement );
  }
}
</script>

</body>
</html>