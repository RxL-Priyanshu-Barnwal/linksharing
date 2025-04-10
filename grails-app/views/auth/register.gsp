<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
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

        .left-side {
            flex: 1; /* Takes up available space */
            display: flex;
            justify-content: center; /* Center content horizontally */
            align-items: center; /* Center content vertically */
            padding-right: 20px; /* Space between cards */
        }

        .right-side {
            flex: 1; /* Takes up available space */
            display: flex;
            justify-content: center; /* Center content horizontally */
            align-items: center; /* Center content vertically */
            padding-left: 20px; /* Space between cards */
        }

        .register-container {
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
<div class="left-side">
    <g:render template="/commonCard"/>
</div>
<div class="right-side">
    <div class="register-container">
        <h2 class="text-center mb-4">Register</h2>
        <form>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="firstName">First Name</label>
                    <input type="text" class="form-control" id="firstName" placeholder="Enter first name">
                </div>
                <div class="form-group col-md-6">
                    <label for="lastName">Last Name</label>
                    <input type="text" class="form-control" id="lastName" placeholder="Enter last name">
                </div>
            </div>
            <div class="form-group">
                <label for="email">Email address</label>
                <input type="email" class="form-control" id="email" placeholder="Enter your email">
            </div>
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" class="form-control" id="username" placeholder="Enter a username">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" placeholder="Enter your password">
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" class="form-control" id="confirmPassword" placeholder="Confirm your password">
            </div>
            <div class="form-group">
                <label for="photo">Photo</label>
                <div class="custom-file">
                    <input type="file" class="custom-file-input" id="photo">
                    <label class="custom-file-label" for="photo">Choose file</label>
                </div>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Register</button>
        </form>
        <p class="mt-2 text-center">Already have an account? <g:link uri="/auth/login" style="color: #f8f9fa;">Login</g:link></p>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    // Add the following script to make the file input label dynamic
    $('.custom-file-input').on('change', function() {
        let fileName = $(this).val().split('\\').pop();
        $(this).next('.custom-file-label').addClass("selected").html(fileName);
    });
</script>
</body>
</html>