<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <script type="text/javascript" src="${resource(dir: 'assets/javascripts', file: 'modal.js')}"></script>

    <style>
        body {
            background-color: #101214;
        }

        /* Card Styles */
        .custom-card {
            background-color: #212529 !important; /* Use !important to override Bootstrap */
            color: #f8f9fa;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
        }

        .custom-card .card-header {
            background-color: #1C1F24 !important;
            color: #f8f9fa;
            border-bottom: 1px solid #343a40;
        }

    </style>
</head>
<body>

    <div>
        <g:render template="/navbar"/>
    </div>

    <div class="modal-body">
        <g:render template="/modals" model="topicNames: topicNames"/>
    </div>


    <div class="container-fluid " style="padding: 4rem;">

        <div class="row gx-5">

            <div class="col-md-5 px-5">

                <div class="user-body">
                    <g:render template="/userCard" model="[user: user]"/>
                </div>

            </div>

            <div class="col-md-7 px-5">

                <div class="profile-update">
                    <div class="card custom-card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0">Edit Profile</h5>
                        </div>

                        <g:if test="${flash.message}">
                            <p class="ms-2" style="color: red;">${flash.message}</p>
                        </g:if>

                        <div class="card-body px-4">
                            <g:uploadForm controller="profile" action="updateDetails" id="editProfileForm">
                                <div class="row mb-3 align-items-center">
                                    <label for="firstName" class="col-sm-3 col-form-label">First Name:</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="firstName" name="firstName" maxLength="12">
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label for="lastName" class="col-sm-3 col-form-label">Last Name:</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="lastName" name="lastName" maxlength="12">
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label for="username" class="col-sm-3 col-form-label">Username:</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="username" name="username" maxlength="16" minlength="6">
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label for="photo" class="col-sm-3 col-form-label">Photo:</label>
                                    <div class="col-sm-9">
                                        <input type="file" class="form-control" id="photo" name="photo">
                                    </div>
                                </div>

                                <div class="d-flex justify-content-end">
                                    <button type="submit" class="btn btn-primary">Update</button>
                                </div>
                            </g:uploadForm>
                        </div>
                    </div>
                </div>

                <div class="edit-password">

                    <div class="card custom-card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0">Change Password</h5>
                        </div>

                            <g:if test="${flash.message1}">
                                <p class="ms-2" style="color: red;">${flash.message1}</p>
                            </g:if>

                        <div class="card-body px-4">
                            <g:form controller="profile" action="updatePassword" id="editPasswordForm">
                                <div class="row mb-3 align-items-center">
                                    <label for="firstName" class="col-sm-3 col-form-label">Password:</label>
                                    <div class="col-sm-9">
                                        <input type="password" class="form-control" id="password" name="password" required minlength="6">
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label for="username" class="col-sm-3 col-form-label">Confirm Password:</label>
                                    <div class="col-sm-9">
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required minlength="6">
                                    </div>
                                </div>


                                <div class="d-flex justify-content-end">
                                    <button type="submit" class="btn btn-primary">Update</button>
                                </div>
                            </g:form>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>

    <style>

        .scroll-area::-webkit-scrollbar {
            width: 0px;  /* Slim scrollbar */
        }

        .scroll-area:hover::-webkit-scrollbar {
            width: 3px;
        }

        .scroll-area::-webkit-scrollbar-track {
            background: transparent;
        }

        .scroll-area::-webkit-scrollbar-thumb {
            background-color: #ccc;
            border-radius: 4px;
        }

    </style>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>
