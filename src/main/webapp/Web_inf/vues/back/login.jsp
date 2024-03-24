<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <title>login page</title>
</head>

<body>

    <div class="container" id="container">
        <div class="form-container sign-up">
            <form method="POST" action="${pageContext.request.contextPath}/SignUpServlet">
                <h1>Create Account</h1>
                <div class="social-icons">
                    <a href="https://www.google.com" class="icon"><i class="fa-brands fa-google-plus-g"></i></a>
                    
                    <a href="https://www.facebook.com" class="icon"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="https://github.com" class="icon"><i class="fa-brands fa-github"></i></a>
                    <a href="https://www.linkedin.com" class="icon"><i class="fa-brands fa-linkedin-in"></i></a>
                </div>
                <span>or use your email for registeration</span>
                <input type="text" name="name" placeholder="Name">
                <input type="email" name="email" placeholder="Email">
                <input type="password" name="password" placeholder="Password">
                <button type="submit" name="action" value="signup">Sign Up</button>
            </form>
        </div>
        <div class="form-container sign-in">
            <form method="POST" action="${pageContext.request.contextPath}/kogintest">
                <h1>Sign In</h1>
                <div class="social-icons">
                    <a href="https://www.google.com" class="icon"><i class="fa-brands fa-google-plus-g"></i></a>
                    <a href="https://www.facebook.com" class="icon"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="https://github.com" class="icon"><i class="fa-brands fa-github"></i></a>
                    <a href="https://www.linkedin.com" class="icon"><i class="fa-brands fa-linkedin-in"></i></a>
                </div>
                <span>or use your email password</span>
                <input type="email" name="email" placeholder="Email">
                <input type="password" name="password" placeholder="Password">
                <a href="#">Forget Your Password?</a>
                <button type="submit">Sign In</button>
            </form>
        </div>
        <div class="toggle-container">
            <div class="toggle">
                <div class="toggle-panel toggle-left">
                    <h1>Welcome Back!</h1>
                    <p>Enter your personal details to use all of site features</p>
                    <button class="hidden" id="login" type="submit">Sign In</button>
                </div>
                <div class="toggle-panel toggle-right">
                    
                    <h1>Welcome to our game!</h1>
                    <p>Register with your personal details to use all of site features</p>
                    <button class="hidden" id="register" type="submit">Sign Up</button>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js_file/script.js"></script>
</body>

</html>