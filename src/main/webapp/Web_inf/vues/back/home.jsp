<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<!--Fontawesome-->
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/desconnect.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/dice.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/Game.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/score.css">
	
	<title>Dice</title>
</head>
<body>
	 <style>
	    * {
	border: 0;
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}
:root {
	--hue: 223;
	--offHue: 3;
	--onHue: 123;
	--bg: hsl(var(--hue),10%,50%);
	--fg: hsl(var(--hue),10%,10%);
	--off1: hsl(var(--offHue),90%,25%);
	--off2: hsl(var(--offHue),90%,40%);
	--off3: hsl(var(--offHue),90%,50%);
	--off4: hsl(var(--offHue),90%,65%);
	--on1: hsl(var(--onHue),90%,15%);
	--on2: hsl(var(--onHue),90%,30%);
	--on3: hsl(var(--onHue),90%,40%);
	--on4: hsl(var(--onHue),90%,55%);
	font-size: calc(60px + (90 - 60) * (100vw - 320px) / (1280 - 320));
}
body, input {
	font: 1em/1.5 sans-serif;
}
body {
	background: var(--bg);
	color: var(--fg);
	height: 100vh;
	display: grid;
	place-items: center;
}
.t {
    position: fixed; /* positionnement fixe */
    right: 60px; /* distance de 20px du bord droit de la fenêtre */
    bottom: 250px; /* distance de 40px du bas de la fenêtre */
    z-index: 2; /* assure que l'élément est au-dessus d'autres éléments */
}
.t__checkbox,
.t__sr,
.t__svg {
	position: absolute;
	top: 0;
	left: 0;
}
.t__checkbox,
.t__svg {
	width: 100%;
	height: 100%;
}
.t__checkbox {
	background-color: var(--off2);
	border-radius: 50%;
	box-shadow:
		0 0 0 0.1em var(--off1) inset,
		0 0 0 0.2em var(--off4) inset,
		-0.3em 0.5em 0 var(--off3) inset,
		0 0.15em 0 hsla(0,0%,0%,0.2);
	filter: brightness(1);
	transition:
		background-color 0.15s linear,
		box-shadow 0.15s linear,
		filter 0.15s linear,
		transform 0.15s linear;
	-webkit-appearance: none;
	appearance: none;
}
.t__checkbox:active {
	box-shadow:
		0 0 0 0.1em var(--off1) inset,
		0 0 0 0.2em var(--off4) inset,
		-0.3em 0.5em 0 var(--off3) inset,
		0 0.05em 0 hsla(0,0%,0%,0.2);
}
.t__checkbox:active,
.t__checkbox:active + .t__svg {
	transform: scale(0.9);
}
.t__checkbox:checked {
	background-color: var(--on2);
	box-shadow:
		0 0 0 0.1em var(--on1) inset,
		0 0 0 0.2em var(--on4) inset,
		-0.3em 0.5em 0 var(--on3) inset,
		0 0.15em 0 hsla(0,0%,0%,0.2);
}
.t__checkbox:checked:active {
	box-shadow:
		0 0 0 0.1em var(--on1) inset,
		0 0 0 0.2em var(--on4) inset,
		-0.3em 0.5em 0 var(--on3) inset,
		0 0.05em 0 hsla(0,0%,0%,0.2);
}
.t__checkbox:focus, .t__checkbox:hover {
	filter: brightness(1.2);
}
.t__checkbox:focus {
	outline: 0;
}
.t__sr {
	clip: rect(1px,1px,1px,1px);
	overflow: hidden;
	width: 1px;
	height: 1px;
}
.t__svg {
	pointer-events: none;
	transition: transform 0.15s linear;
}
.t__svg-bg {
	fill: hsl(var(--hue),90%,100%);
}
.t__svg-ring,
.t__svg-line {
	stroke: hsl(var(--hue),90%,100%);
}
.t__svg-ring {
	stroke-dasharray: 0 5 27.7 5;
	transition:
		stroke 0.15s ease-in-out,
		stroke-dasharray 0.3s 0.25s ease-in-out;
}
.t__checkbox:checked + .t__svg .t__svg-ring {
	stroke-dasharray: 0 0 0 37.7;
	transition-delay: 0s;
}
.t__svg-line {
	stroke-dashoffset: 3;
	transition:
		stroke 0.15s linear,
		stroke-dashoffset 0.3s ease-in-out;
}
.t__svg-line:nth-of-type(1) {
	transition-delay: 0s, 0.25s;
}
.t__checkbox:checked + .t__svg .t__svg-line:nth-of-type(1) {
	stroke-dashoffset: -6;
	transition-delay: 0s;
}
.t__svg-line:nth-of-type(2) {
	stroke-dashoffset: 6;
}
.t__checkbox:checked + .t__svg .t__svg-line:nth-of-type(2) {
	stroke-dashoffset: -3;
	transition-delay: 0s, 0.25s;
}

        body {
            background-image: url('https://cdn.arstechnica.net/wp-content/uploads/2016/08/GenCon19.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }
    </style>
	<!-- FIRST WE MAKE SIMPLE CUBE -->
	
	<div class="container">
		<div class="cube" id="cube">
			<div class="front">
				<span class="fas fa-circle"></span>
			</div>
			<div class="back">
					<!-- i use pre tag to align dots -->
					<pre class="firstPre"><span class="fas fa-circle"></span>    <span class="fas fa-circle"></span>    <span class="fas fa-circle"></span></pre><br>
					<pre class="secondPre"><span class="fas fa-circle"></span>    <span class="fas fa-circle"></span>    <span class="fas fa-circle"></span></pre>
			</div>
			<div class="top">
				<span class="fas fa-circle"></span>
				<span class="fas fa-circle"></span>
			</div>
			<div class="left">
				<span class="fas fa-circle"></span>
				<span class="fas fa-circle"></span>
				<span class="fas fa-circle"></span>

			</div>
			<div class="right">
				<span class="fas fa-circle"></span>
				<span class="fas fa-circle"></span>
				<span class="fas fa-circle"></span>
				<span class="fas fa-circle"></span>
				<span class="fas fa-circle"></span>

			</div>
			<div class="bottom">
				<span class="fas fa-circle"></span>
				<span class="fas fa-circle"></span>
				<span class="fas fa-circle"></span>
				<span class="fas fa-circle"></span>

			</div>
		</div>
	</div>
	<!-- Buttons -->
	<!-- Buttons -->
	<div class="button-container">
    <button class="score-button">Score</button>
    <button class="best-score-button">Best Score</button>
</div>
	
	
	
	
	
	
	
	
	
	
		<a href="chemin_vers_votre_page_jsp" class="t" id="gameButton">
   <svg id="play"  viewBox="0 0 163 163" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px"="0px">
    
    <g fill="none">
        <g  transform="translate(2.000000, 2.000000)" stroke-width="4">
            <path d="M10,80 C10,118.107648 40.8923523,149 79,149 L79,149 C117.107648,149 148,118.107648 148,80 C148,41.8923523 117.107648,11 79,11" id="lineOne" stroke="#A5CB43"></path>
            <path d="M105.9,74.4158594 L67.2,44.2158594 C63.5,41.3158594 58,43.9158594 58,48.7158594 L58,109.015859 C58,113.715859 63.4,116.415859 67.2,113.515859 L105.9,83.3158594 C108.8,81.1158594 108.8,76.6158594 105.9,74.4158594 L105.9,74.4158594 Z" id="triangle" stroke="#A3CD3A"></path>
            <path d="M159,79.5 C159,35.5933624 123.406638,0 79.5,0 C35.5933624,0 0,35.5933624 0,79.5 C0,123.406638 35.5933624,159 79.5,159 L79.5,159" id="lineTwo" stroke="#A5CB43"></path>
        </g>
    </g>
</svg>
    <span class="t__sr">game</span>
</label>
		
	    <label class="t" id="powerButton">
	<input class="t__checkbox" type="checkbox" value="on">
	<svg class="t__svg" width="24px" height="24px" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
		<ellipse class="t__svg-dot" cx="6" cy="6" rx="2" ry="1" fill="#fff" transform="rotate(-45,6,6)" />
		<circle class="t__svg-ring" cx="12" cy="12" r="6" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-dasharray="0 5 27.7 5" stroke-dashoffset="0.01" transform="rotate(-90,12,12)"/>
		<line class="t__svg-line" x1="12" y1="6" x2="12" y2="15" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-dasharray="9 9" stroke-dashoffset="3"/>
		<line class="t__svg-line" x1="12" y1="6" x2="12" y2="12" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-dasharray="6 6" stroke-dashoffset="6"/>
	</svg>
	<span class="t__sr">Power</span>
</a>
	<script>
document.getElementById("powerButton").addEventListener("click", function() {
    // Redirection vers la servlet Deconnect
    window.location.href = "${pageContext.request.contextPath}/Deconnect";
});
</script>
	
	
	
	

	
	<!-- JS CODE -->
	<script type="text/javascript">
		let cube = document.getElementById('cube');

		angleArray = [[0,0,0],[-310,-362,-38],[-400,-320,-2],[135,-217,-88],[-224,-317,5],[-47,-219,-81],[-133,-360,-53]];
		//this array of degree that show the deffrent number 1 2 3 4 5 6 on cube ie
		cube.addEventListener('click',function(e){

			// Définir l'animation pour qu'elle se répète en boucle
			cube.style.animation = 'animate 1.4s linear infinite';

			
			cube.addEventListener('click', function() {
			    const randomAngle = Math.floor(Math.random() * 6) + 1;
			    // Votre code pour faire l'animation du dé ici
			});

			//console.log(randomAngle);
			cube.style.transform = 'rotateX('+angleArray[randomAngle][0]+'deg) rotateY('+angleArray[randomAngle][1]+'deg) rotateZ('+angleArray[randomAngle][2]+'deg)';
			cube.style.transition = '1s linear'

			cube.addEventListener('animationend',function(e){
				cube.style.animation = '';
			});
		});
		
	</script>
</body>
</html>