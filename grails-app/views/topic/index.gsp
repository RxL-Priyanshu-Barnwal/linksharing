<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Topic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body {
            background-color: #101214;
            overflow-y: auto
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

        /* Profile Picture Styling */
        .profile-pic {
            width: 50px;
            height: 50px;
            object-fit: cover; /* Ensures the image covers the area without distortion */
            border-radius: 50%; /* Makes it circular */
            flex-shrink: 0; /* Prevents image from shrinking */
        }

        /* Ensure content next to profile pic takes remaining space */
        .profile-content {
            flex-grow: 1;
            min-width: 0; /* Prevents content overflow issues in flex item */
        }


        /* Style for individual posts within subscription card */
        .subscription-post {
            border-bottom: 1px solid #343a40; /* Separator line */
            padding-bottom: 1rem;
            margin-bottom: 1rem;
        }
        .subscription-post:last-child {
            border-bottom: none; /* Remove border for the last item */
            margin-bottom: 0;
            padding-bottom: 0;
        }

    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>

<!-- Navbar -->

<div class="navigation-bar">
    <g:render template="/navbar"/>
</div>

<div class="modals">
    <g:render template="/modals"/>
</div>

<div class="container-fluid " style="padding: 3rem;">

    <div class="row gx-5">

        <div class="col-md-5 px-5">

            <div class="user-body">
                <g:render template="/userCard"/>
            </div>



<!--            Users Subscribed to the topic-->

            <div class="card custom-card mt-5">
                <div class="card-header">
                    <h5 class="mb-0">Users</h5>
                </div>

                <div class="card-body users-body py-3">


                    <div class="row align-items-center">
                        <div class="col-md-3">
                            <img src="" alt="User Profile Picture" class="img-fluid">
                        </div>
                        <div class="col-md-9">
                            <div>
                                <strong style="font-size:1.4em;">User's Name</strong>
                                <small class="text-secondary ms-2">@User's Username</small>
                            </div>
                            <p class="card-text small mb-4" style="color: #808080;">email@email.com</p>
                            <div class="d-flex justify-content-between">
                                <div>
                                    <p class="mb-0" style="color: #808080;">Subscription: <span>12</span></p>
                                </div>
                                <div>
                                    <p class="mb-0" style="color: #808080;">Topic: <span>5</span></p>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>


        </div>


        <!--            Subscribed users sections ends -->


        <div class="col-md-7 px-5">


            <div class="card custom-card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">Inbox</h5>
                </div>
                <div class="card-body" style="max-height: 260px; overflow-y: auto; overflow-x: hidden; padding-right: 15px">
                            <!-- Individual Inbox Item -->
                            <div class="inbox-item d-flex mb-2">
                                <!-- Profile photo on the left -->
                                <div class="inbox-item-avatar">
                                    <img src="" alt="Creator's Photo" class="rounded-circle" width="50" height="50"/>
                                </div>

                                <!-- Inbox item content on the right -->
                                <div class="inbox-item-content ms-3 w-100">
                                    <!-- Header: Creator's Name, Username, Topic Name -->
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <strong style="font-size:1.4em;">User's Name</strong>
                                            <small class="text-secondary ms-2">@User's Username</small>
                                        </div>
                                        <div>
                                            <span class="text-secondary">Topic: </span>
                                            <span class="fw-bold">Topic Name of resource</span>
                                        </div>
                                    </div>
                                    <!-- Description -->
                                    <p class="mt-2">Description</p>
                                    <!-- Action Buttons -->
                                    <div class="d-flex gap-2 mt-3 justify-content-end">
                                            <button type="submit" class="btn btn-sm btn-outline-primary">Download</button>
                                            <button type="submit" class="btn btn-sm btn-outline-secondary">View Full Site</button>
                                            <button type="submit" class="btn btn-sm btn-outline-success">Mark as Read</button>
                                        <button class="btn btn-sm btn-outline-info">View Post</button>
                                    </div>
                                </div>
                            </div>

                </div>
            </div>



        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>
