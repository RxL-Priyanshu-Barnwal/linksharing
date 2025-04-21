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

                <div class="card custom-card mt-5">
                    <div class="card-header">
                        <h5 class="mb-0">Topics</h5>
                    </div>

                    <div class="card-body subscription-body py-3">

                        <div class="row align-items-center">

                            <!-- Profile Image -->
                            <div class="col-md-3 mb-3 mb-md-0">
                                <img src="" alt="Profile Picture" class="img-fluid rounded">
                            </div>

                            <div class="col-md-9">
                                <h5 class="card-title mb-1">Topic Name</h5>

                                <p class="text-secondary small mb-3">username</p>

                                <div class="d-flex justify-content-between mb-3">
                                    <p class="mb-0 text-secondary">Subscriptions: <span>12</span></p>
                                    <p class="mb-0 text-secondary">Posts: <span>5</span></p>
                                </div>

                                <!-- Bottom Controls -->
                                <div class="d-flex align-items-center gap-3 flex-wrap mb-4">
                                    <!-- Seriousness -->
                                    <div class="dropdown">
                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">

                                        </button>
                                        <ul class="dropdown-menu">

                                            <li><a class="dropdown-item" href="#"></a></li>

                                        </ul>
                                    </div>

                                    <!-- Visibility -->
                                    <div class="dropdown">
                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                            Visibility
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="#">PUBLIC</a></li>
                                            <li><a class="dropdown-item" href="#">PRIVATE</a></li>
                                        </ul>
                                    </div>

                                    <!-- Icons -->
                                    <i class="bi bi-envelope fs-5" title="Invite" role="button"></i>
                                    <i class="bi bi-pencil-square fs-5" title="Edit" role="button"></i>
                                    <i class="bi bi-trash fs-5 text-danger" title="Delete" role="button"></i>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>

            <div class="col-md-7 px-5">

                <div class="profile-update">
                    <div class="card custom-card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0">Edit Profile</h5>
                        </div>
                        <div class="card-body px-4">
                            <form id="editProfileForm">
                                <div class="row mb-3 align-items-center">
                                    <label for="firstName" class="col-sm-3 col-form-label">First Name:</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="firstName" name="firstName">
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label for="lastName" class="col-sm-3 col-form-label">Last Name:</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="lastName" name="lastName">
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label for="username" class="col-sm-3 col-form-label">Username:</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="username" name="username">
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label for="photo" class="col-sm-3 col-form-label">Photo:</label>
                                    <div class="col-sm-9">
                                        <input type="file" class="form-control" id="photo" name="photo" accept="image/*">
                                    </div>
                                </div>

                                <div class="d-flex justify-content-end">
                                    <button type="submit" class="btn btn-primary">Update</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="edit-password">

                    <div class="card custom-card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0">Change Password</h5>
                        </div>
                        <div class="card-body px-4">
                            <form id="editPasswordForm">
                                <div class="row mb-3 align-items-center">
                                    <label for="firstName" class="col-sm-3 col-form-label">Password:</label>
                                    <div class="col-sm-9">
                                        <input type="password" class="form-control" id="password" name="firstName">
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label for="username" class="col-sm-3 col-form-label">Confirm Password:</label>
                                    <div class="col-sm-9">
                                        <input type="password" class="form-control" id="confirmPassword" name="username" required>
                                    </div>
                                </div>


                                <div class="d-flex justify-content-end">
                                    <button type="submit" class="btn btn-primary">Update</button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>



    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>
