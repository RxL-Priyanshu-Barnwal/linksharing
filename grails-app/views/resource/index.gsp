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
    <g:render template="/modals" model="topicNames: topicNames"/>
</div>

<div class="container-fluid " style="padding: 3rem;">
    <div class="row gx-5">

        <div class="col-md-7 px-5">


            <g:if test="resource">

                <div class="card custom-card mt-5">
                    <div class="card-body">
                        <div class="row align-items-center mb-2">
                            <div class="col-auto">
                                <img src="${resource?.user?.photo}" alt="User Photo" class="rounded-circle" style="width: 30px; height: 30px; object-fit: cover;">
                            </div>
                            <div class="col">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span class="fw-bold">${resource?.user?.firstName} ${resource?.user?.lastName}</span>
                                    </div>
                                    <div>
                                        <span class="secondary">Topic: ${resource?.topic?.name}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row align-items-center mb-2">
                            <div class="col">
                                <span class="text-secondary">${resource?.user?.username}</span>
                            </div>
                            <div class="col-auto">
                                <span class="text-muted">${resource?.dateCreated}</span>
                            </div>
                        </div>
                        <div class="m-4">
                            ${resource?.description}
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                ★★★★★
                            </div>
                            <div class="p-1">

                                <g:if test="${resource?.user?.id == session.user?.id || session.user?.admin}">
                                    <g:link controller="resource" action="edit" id="${resource.id}" class="btn btn-sm btn-outline-info">Edit</g:link>
                                    <g:link controller="resource" action="delete" id="${resource.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this resource?')">Delete</g:link>
                                </g:if>

                                <g:if test="${resource instanceof linksharing.DocumentResource}">
                                    <g:link controller="" action="" params="[id: resource.id]" class="btn btn-sm btn-outline-primary">Download</g:link>
                                </g:if>

                                <g:if test="${resource instanceof linksharing.LinkResource}">
                                    <a href="${resource.url}" target="_blank" class="btn btn-sm btn-outline-secondary">View Full Site</a>
                                </g:if>

                            </div>
                        </div>
                    </div>
                </div>

            </g:if>


        </div>

        <div class="col-md-5">

            <div class="trendingTopics-body">
                <g:render template="/dashboard/trendingTopicsCard" model="[trendingTopics: trendingTopics]"/>
            </div>

        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>
