<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body {
            background-color: #101214; /* Slightly darker background for contrast */
        }

        /* Custom Card Styles */
        .custom-card {
            background-color: #212529 !important; /* Use !important to override Bootstrap if needed */
            color: #f8f9fa; /* Light text */
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

        /* Add some basic scroll for subscription posts if needed */
        .subscription-body {
            /* max-height: 400px; /* Example fixed height */
            /* overflow-y: auto; /* Enable scroll if max-height is set */
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
</head>
<body>

<div class="navigation-bar">
    <g:render template="/dashboard/navbar"/>
</div>


<div class="container-fluid " style="padding: 4rem;">
    <div class="row gx-5">

        <div class="col-md-5 px-5">

            <div class="card custom-card mb-4">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-3">
                            <img src="your-image-url.jpg" alt="User Profile Picture" class="img-fluid">
                        </div>
                        <div class="col-md-9">
                            <h5 class="card-title">John Doe</h5>
                            <p class="card-text small mb-4" style="color: #808080;">johndoe@example.com</p>
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


            <div class="card custom-card mt-5">
                <div class="card-header">
                    <h5 class="mb-0">Subscriptions</h5>
                </div>
                <div class="card-body subscription-body py-5">

                    <div class="subscription-post">
                        <div class="d-flex align-items-center">
                            <img src="https://via.placeholder.com/150/24f355" alt="Post Author Profile Picture" class="profile-pic me-3">
                            <div class="profile-content">
                                <h6 class="card-subtitle mb-1">Author One</h6>
                                <p class="card-text small text-muted">Posted 2 hours ago</p>
                                <p class="card-text small mb-0">This is the content of the first subscription post. It can be longer.</p>
                            </div>
                        </div>
                    </div>

                    <div class="subscription-post">
                        <div class="d-flex align-items-center">
                            <img src="https://via.placeholder.com/150/d32776" alt="Post Author Profile Picture" class="profile-pic me-3">
                            <div class="profile-content">
                                <h6 class="card-subtitle mb-1">Author Two</h6>
                                <p class="card-text small text-muted">Posted 5 hours ago</p>
                                <p class="card-text small mb-0">Another post from someone the user subscribed to.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div><div class="col-md-7 px-5">

        <div class="card custom-card mb-4">
            <div class="card-header">
                <h5 class="mb-0">Inbox</h5>
            </div>
            <div class="card-body">
                <div class="d-flex align-items-start"> <img src="https://via.placeholder.com/150/b0f7cc" alt="Content Picture" class="profile-pic me-3">
                    <div class="profile-content">
                        <h6 class="card-subtitle mb-2">Item Title</h6>
                        <p class="card-text">This is the main content area (7/12 width). You can place primary dashboard elements, charts, tables, or detailed views here.</p>
                        <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
                        <a href="#" class="btn btn-primary btn-sm">View Details</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="card custom-card mt-5">
            <div class="card-header">
                <h5 class="mb-0">Trending Posts</h5>
            </div>
            <div class="card-body">
                <div class="d-flex align-items-center">
                    <img src="https://via.placeholder.com/150/f66b97" alt="Another Picture" class="profile-pic me-3">
                    <div class="profile-content">
                        <h6 class="card-subtitle mb-1">Another Section</h6>
                        <p class="card-text small">This card doesn't have a header, similar to the User Card, but it's in the right column.</p>
                    </div>
                </div>
            </div>
        </div>

    </div></div></div><script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
