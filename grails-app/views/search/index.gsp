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
    <g:render template="/navbar" model="query: query"/>
</div>

<div class="modals">
    <g:render template="/modals" model="topicNames: topicNames"/>
</div>

<div class="container-fluid " style="padding: 3rem;">
    <div class="row gx-5">

        <div class="col-md-5 px-5">
            <div class="topic-search-result">
                <div class="card custom-card mt-5">
                    <div class="card-header">
                        <h5 class="mb-0">Topics</h5>
                    </div>
                    <div class="card-body">
                        <g:each in="${topics}" var="topic">
                            <div class="row align-items-center">
                                <!-- Profile Image -->
                                <div class="col-md-3 mb-3 mb-md-0">
                                    <g:if test="${topic.user?.photo}">
                                        <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: topic.user.id])}" alt="${topic.user.firstName}" class="img-fluid">
                                    </g:if>
                                </div>
                                <div class="col-md-9">
                                    <g:link controller="topic" action="index" params="[id: topic.id]" style="color: inherit; text-decoration: none;">
                                        <span class="card-title mb-1 trending-topic-name-display" data-trending-topic-id="${topic.id}" style="font-size: 1.3em">${topic?.name}</span>
                                    </g:link>
                                    <input type="text" class="form-control trending-topic-name-input d-none" data-trending-topic-id="${topic.id}" value="${topic?.name}">

                                    <g:link controller="profile" action="userProfile" params="[id: topic.user.id]" style="color: inherit; text-decoration: none;">
                                        <p class="text-secondary small mb-3">${topic?.user?.username}</p>
                                    </g:link>

                                    <div class="d-flex justify-content-between mb-3">
                                        <p class="mb-0 text-secondary">Subscriptions: <span>${topic?.subscriptions?.size() ?: 0}</span></p>
                                        <p class="mb-0 text-secondary">Posts: <span>${topic?.resources?.size() ?: 0}</span></p>
                                    </div>
                                    <!-- Bottom Controls -->
                                    <div class="d-flex align-items-center gap-3 flex-wrap mb-4">
                                        <g:if test="${!topic.subscriptions?.any { it.user?.id == session.user?.id }}">
                                            <form method="post" action="${createLink(controller: 'topic', action: 'subscribe')}" class="mb-0">
                                                <input type="hidden" name="topicId" value="${topic.id}">
                                                <button type="submit" class="btn btn-sm btn-primary">Subscribe</button>
                                            </form>
                                        </g:if>
                                    </div>
                                </div>
                            </div>
                        </g:each>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-7 px-5">
            <div class="resource-search-result">



                <div class="card custom-card mt-5 mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Inbox</h5>
                    </div>
                    <div class="card-body">
                        <g:if test="${resources}">
                            <g:each in="${resources}" var="resource">
                                <!-- Individual Inbox Item -->
                                <div class="inbox-item d-flex mb-2 p-3">
                                    <!-- Profile photo on the left -->
                                    <g:if test="${resource?.user?.photo}">
                                        <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: resource?.user?.id])}" alt="${resource?.user?.firstName}" class="img-fluid">
                                    </g:if>
                                    <!-- Inbox item content on the right -->
                                    <div class="inbox-item-content ms-3 w-100">
                                        <!-- Header: Creator's Name, Username, Topic Name -->
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <g:link controller="profile" action="userProfile" params="[id: resource.user.id]" style="color: inherit; text-decoration: none;">
                                                    <strong>${resource.user.firstName} ${resource.user.lastName}</strong>
                                                    <small class="text-secondary ms-2">@${resource.user.username}</small>
                                                </g:link>
                                            </div>
                                            <div>
                                                <span class="text-secondary">Topic: </span>
                                                <g:link controller="topic" action="index" params="[id: resource.topic.id]" style="color: inherit; text-decoration: none;">
                                                    <span class="fw-bold">${resource.topic.name}</span>
                                                </g:link>
                                            </div>
                                        </div>
                                        <!-- Description -->
                                        <p class="mt-2">${resource.description.encodeAsHTML()}</p>
                                        <!-- Action Buttons -->
                                        <div class="d-flex gap-2 mt-3 justify-content-end">
                                            <g:if test="${resource instanceof linksharing.DocumentResource}">
                                                <g:link controller="resource" action="download" params="[id: resource.id]" class="btn btn-sm btn-outline-primary">Download</g:link>
                                            </g:if>
                                            <g:if test="${resource instanceof linksharing.LinkResource}">
                                                <a href="${resource.url}" target="_blank" class="btn btn-sm btn-outline-secondary">View Full Site</a>
                                            </g:if>
                                            <g:form controller="resource" action="markAsRead" method="post" class="d-inline">
                                                <g:hiddenField name="id" value="${resource.id}"/>
                                                <button type="submit" class="btn btn-sm btn-outline-success">Mark as Read</button>
                                            </g:form>
                                            <g:link controller="resource" action="index" params="[id: resource.id]">
                                                <button class="btn btn-sm btn-outline-info">View Post</button>
                                            </g:link>
                                        </div>
                                    </div>
                                </div>
                            </g:each>
                        </g:if>
                    </div>
                </div>




            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>
