<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #2C3238; /* Dark background for the body */
            color: #f8f9fa; /* Light text color */
            display: flex;
            min-height: 100vh;
            margin: 0;
            padding: 20px; /* Add some overall padding */
        }

        .right-side {
            flex: 1; /* Takes up available space */
            display: flex;
            justify-content: center; /* Center content horizontally */
            align-items: center; /* Center content vertically */
            padding-left: 20px; /* Space between cards */
        }

        .login-container {
            background-color: #212529; /* Darker background for the container */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
            width: 400px;
            max-width: 90%;
        }

        .form-control {
            background-color: #495057; /* Dark input background */
            color: #f8f9fa; /* Light input text color */
            border: 1px solid #6c757d; /* Darker border */
        }

        .form-control:focus {
            background-color: #495057;
            color: #f8f9fa;
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(128, 183, 255, 0.25);
            outline: 0;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="right-side">
    <div class="login-container">
        <h2 class="text-center mb-4">Trouble Logging in?</h2>

        <g:if test="${flash.message}">
            <p style="color: red;">${flash.message}</p>
        </g:if>

        <g:form controller="auth" action="forgotPasswordOnSubmit">
            <div class="form-group">
                <input type="text" class="form-control" name="email" id="email" placeholder="Enter your email">
            </div>


            <button type="submit" class="btn btn-primary btn-block">Reset Password</button>
        </g:form>
        <p class="mt-2 text-center">Don't have an account? <g:link uri="/auth/register" style="color: #f8f9fa;">Register</g:link></p>
        <p class="mt-2 text-center"><g:link uri="/auth/login" style="color: #f8f9fa;">Back to login</g:link></p>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>