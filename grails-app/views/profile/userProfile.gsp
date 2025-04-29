<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${user.firstName}'s Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <script type="text/javascript" src="${resource(dir: 'assets/javascripts', file: 'modal.js')}"></script>

    <style>
        body {
            background-color: #101214;
            overflow-y: hidden;
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
    <div>
        <g:render template="/navbar"/>
    </div>

    <div class="modals">
        <g:render template="/modals" model="topicNames: topicNames"/>
    </div>

    <div class="container-fluid " style="padding: 3rem;">
        <div class="row gx-5">

            <div class="col-md-5 px-5">
                <div class="user-body">
                    <g:render template="/userCard"/>
                </div>
                <div class="subscription-body">
                    <div class="card custom-card mt-5">
                        <div class="card-header">
                            <h5 class="mb-0">Subscriptions</h5>
                        </div>


                        <div class="card-body subscription-body py-3">

                            <div class="scroll-area" style="max-height: 480px; overflow-y: auto; overflow-x: hidden; padding-right: 10px">


                                <!--        subscribedTopics is List<Subscription> -->
                                <g:if test="${subscribedTopics}">
                                    <g:each in="${subscribedTopics}" var="subscribedTopic">

                                        <div class="row align-items-center">

                                            <!-- Profile Image -->

                                                <div class="col-md-3 mb-3 mb-md-0">
                                                    <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: subscribedTopic.topic.user.id])}" alt="${subscribedTopic.topic.user.firstName}" class="img-fluid">
                                                </div>


                                            <div class="col-md-9">
                                                <h5 class="card-title mb-1">

                                                    <g:link controller="topic" action="index" params="[id: subscribedTopic.topic.id]" style="color: inherit; text-decoration: none;" class="me-2">
                                                        <span class="topic-name-display" data-topic-id="${subscribedTopic.topic.id}">
                                                            ${subscribedTopic.topic.name}
                                                        </span>
                                                    </g:link>
                                                    <input type="text" class="form-control topic-name-input d-none" id="topicNameInput-${subscribedTopic.topic.id}" data-topic-id="${subscribedTopic.topic.id}" value="${subscribedTopic.topic.name}">

                                                </h5>

                                                <g:link controller="profile" action="userProfile" params="[id: subscribedTopic.topic.user.id]" style="color: inherit; text-decoration: none;">
                                                    <p class="text-secondary small mb-3">${subscribedTopic.topic.user.username}</p>
                                                </g:link>

                                                <div class="d-flex justify-content-between mb-3">
                                                    <p class="mb-0 text-secondary">Subscriptions: <span>${subscribedTopic.topic.subscriptions?.size() ?: 0}</span></p>
                                                    <p class="mb-0 text-secondary">Posts: <span>${subscribedTopic.topic.resources?.size() ?: 0}</span></p>
                                                </div>

                                                <!-- Bottom Controls -->
                                                <div class="d-flex align-items-center gap-3 flex-wrap mb-4">

                                                    <!-- Visibility -->
                                                    <g:if test="${session.user?.id == subscribedTopic.topic.user?.id || session.user?.admin}">
                                                        <div class="dropdown">
                                                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                ${subscribedTopic.topic.visibility ?: 'Public'}
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                <li><a class="dropdown-item change-visibility" data-id="${subscribedTopic.topic.id}" data-value="PUBLIC" href="#">PUBLIC</a></li>
                                                                <li><a class="dropdown-item change-visibility" data-id="${subscribedTopic.topic.id}" data-value="PRIVATE" href="#">PRIVATE</a></li>
                                                            </ul>
                                                        </div>

                                                        <!-- Hidden form to send data -->
                                                        <form id="visibilityForm-${subscribedTopic.topic.id}" method="post" action="${createLink(controller: 'dashboard', action: 'updateVisibility')}" style="display: none;">
                                                            <input type="hidden" name="id" class="visibilityTopicId">
                                                            <input type="hidden" name="visibility" class="visibilityValue">
                                                        </form>

                                                    </g:if>

                                                    <!-- Seriousness -->
                                                    <div class="dropdown">
                                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                            ${subscribedTopic.seriousness}
                                                        </button>
                                                        <ul class="dropdown-menu">
                                                            <g:each in="${linksharing.Subscription.Seriousness.values()}" var="seriousness">
                                                                <li><a class="dropdown-item change-seriousness" data-id="${subscribedTopic.topic.id}" data-value="${seriousness}" href="#">${seriousness}</a></li>
                                                            </g:each>
                                                        </ul>
                                                    </div>

                                                    <!-- Hidden form to send data -->
                                                    <form id="seriousnessForm-${subscribedTopic.topic.id}" method="post" action="${createLink(controller: 'dashboard', action: 'updateSeriousness')}" style="display: none;">
                                                        <input type="hidden" name="id" class="seriousnessTopicId">
                                                        <input type="hidden" name="seriousness" class="seriousnessValue">
                                                    </form>


                                                    <!-- Icons -->

                                                    <g:if test="${subscribedTopic.topic.user?.id == session.user?.id || session.user?.admin}">

                                                        <i class="bi bi-pencil-square fs-5 edit-topic-inline-btn" title="Edit" role="button" data-topic-id="${subscribedTopic.topic.id}"></i>
                                                        <i class="bi bi-trash fs-5 text-danger delete-topic" data-id="${subscribedTopic.topic.id}" title="Delete" role="button"></i>

                                                    </g:if>
                                                    <g:if test="${subscribedTopic.topic.user?.id != session.user?.id}">
                                                        <form method="post" action="${createLink(controller: 'topic', action: 'unsubscribe')}" class="mb-0">
                                                            <input type="hidden" name="topicId" value="${subscribedTopic.topic.id}">
                                                            <button type="submit" class="btn btn-sm btn-danger">Unsubscribe</button>
                                                        </form>
                                                    </g:if>
                                                </div>
                                            </div>
                                        </div>
                                    </g:each>
                                </g:if>
                                <g:else>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-7 px-5">

                <div class="posts-body">

                    <div class="card custom-card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0">Posts</h5>
                        </div>
                        <div class="card-body" style="max-height: 260px; overflow-y: auto; overflow-x: hidden; padding-right: 15px">


                            <g:if test="${resources}">

                                <g:each in="${resources}" var="resource">

                                    <!-- Individual Inbox Item -->
                                    <div class="inbox-item d-flex mb-1">
                                        <!-- Profile photo on the left -->
                                        <div class="inbox-item-avatar">

                                            <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: resource.user.id])}" alt="${resource.user.firstName}" class="img-fluid"/>

                                        </div>

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
                    <style>

                        .card-body::-webkit-scrollbar {
                            width: 0px;  /* Slim scrollbar */
                        }

                        .card-body:hover::-webkit-scrollbar {
                            width: 3px;
                        }

                        .card-body::-webkit-scrollbar-track {
                            background: transparent;
                        }

                        .card-body::-webkit-scrollbar-thumb {
                            background-color: #ccc;
                            border-radius: 4px;
                        }

                    </style>
                </div>


                <div class="createdTopics-body">
                    <div class="card custom-card mt-5">
                        <div class="card-header">
                            <h5 class="mb-0">Topics</h5>
                        </div>
                        <div class="card-body scroll-area" style="max-height: 350px; overflow-y: auto; overflow-x: hidden; padding-right: 10px">

                            <g:each in="${topics}" var="topic">

                                <div class="row align-items-center">

                                    <!-- Profile Image -->
                                    <div class="col-md-3 mb-2 mb-md-0">
                                        <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: topic.user.id])}" alt="${topic.user.firstName}" class="img-fluid rounded p-3">
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

                                            <g:if test="${topic.user?.id == session.user?.id || session.user?.admin}">
                                                <!-- Visibility -->
                                                <div class="dropdown">
                                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        ${topic.visibility ?: 'Visibility'}
                                                    </button>
                                                    <ul class="dropdown-menu">
                                                        <li><a class="dropdown-item change-visibility" data-id="${topic.id}" data-value="PUBLIC" href="#">PUBLIC</a></li>
                                                        <li><a class="dropdown-item change-visibility" data-id="${topic.id}" data-value="PRIVATE" href="#">PRIVATE</a></li>
                                                    </ul>
                                                </div>

                                                <!-- Hidden form for visibility -->
                                                <form id="visibilityForm-${topic.id}" method="post" action="${createLink(controller: 'dashboard', action: 'updateVisibility')}" style="display: none;">
                                                    <input type="hidden" name="id" value="${topic.id}" class="visibilityTopicId">
                                                    <input type="hidden" name="visibility" class="visibilityValue">
                                                </form>


                                                <%
                                                // Get the subscription for the current user (if any)
                                                def userSubscription = topic.subscriptions?.find { it.user?.id == session.user?.id }
                                                def seriousnessText = userSubscription ? userSubscription.seriousness.toString() : 'CASUAL'

                                                %>

                                                <!-- Seriousness -->
                                                <div class="dropdown">

                                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        ${seriousnessText}
                                                    </button>
                                                    <ul class="dropdown-menu">
                                                        <li><a class="dropdown-item change-seriousness" data-id="${topic.id}" data-value="CASUAL" href="#">CASUAL</a></li>
                                                        <li><a class="dropdown-item change-seriousness" data-id="${topic.id}" data-value="SERIOUS" href="#">SERIOUS</a></li>
                                                        <li><a class="dropdown-item change-seriousness" data-id="${topic.id}" data-value="VERY_SERIOUS" href="#">VERY_SERIOUS</a></li>
                                                    </ul>

                                                </div>

                                                <!-- Hidden form for seriousness -->
                                                <form id="seriousnessForm-${topic.id}" method="post" action="${createLink(controller: 'dashboard', action: 'updateSeriousness')}" style="display: none;">
                                                    <input type="hidden" name="id" value="${topic.id}" class="seriousnessTopicId">
                                                    <input type="hidden" name="seriousness" class="seriousnessValue">
                                                </form>


                                                <i class="bi bi-pencil-square fs-5 edit-trending-topic-btn" title="Edit" role="button" data-trending-topic-id="${topic.id}"></i>
                                                <i class="bi bi-trash fs-5 text-danger delete-topic" data-id="${topic.id}" title="Delete" role="button"></i>
                                            </g:if>


                                            <g:if test="${!topic.subscriptions?.any { it.user?.id == session.user?.id }}">

                                                <form method="post" action="${createLink(controller: 'topic', action: 'subscribe')}" class="mb-0">
                                                    <input type="hidden" name="topicId" value="${topic.id}">
                                                    <button type="submit" class="btn btn-sm btn-primary">Subscribe</button>
                                                </form>

                                            </g:if>

                                            <g:else>
                                                <!--                            <i class="bi bi-envelope fs-5" title="Invite" role="button" data-bs-toggle="modal" data-bs-target="#sendInvite"></i>-->
                                                <!-- Show Unsubscribe Button if User is Subscribed and not the creator -->
                                                <g:if test="${topic.user?.id != session.user?.id}">

                                                    <g:if test="${!session.user?.admin}">
                                                        <%
                                                        // Get the subscription for the current user (if any)
                                                        def userSubscription = topic.subscriptions?.find { it.user?.id == session.user?.id }
                                                        def seriousnessText = userSubscription ? userSubscription.seriousness.toString() : 'CASUAL'

                                                        %>

                                                        <!-- Seriousness -->
                                                        <div class="dropdown">

                                                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                ${seriousnessText}
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                <li><a class="dropdown-item change-seriousness" data-id="${topic.id}" data-value="CASUAL" href="#">CASUAL</a></li>
                                                                <li><a class="dropdown-item change-seriousness" data-id="${topic.id}" data-value="SERIOUS" href="#">SERIOUS</a></li>
                                                                <li><a class="dropdown-item change-seriousness" data-id="${topic.id}" data-value="VERY_SERIOUS" href="#">VERY_SERIOUS</a></li>
                                                            </ul>
                                                        </div>
                                                    </g:if>
                                                    <form method="post" action="${createLink(controller: 'topic', action: 'unsubscribe')}" class="mb-0">
                                                        <input type="hidden" name="topicId" value="${topic.id}">
                                                        <button type="submit" class="btn btn-sm btn-danger">Unsubscribe</button>
                                                    </form>
                                                </g:if>
                                            </g:else>
                                        </div>
                                    </div>
                                </div>
                            </g:each>
                        </div>
                    </div>

                    <script>

                        $(document).ready(function() {

                            let currentlyEditingTrendingTopicId = null; // To track which trending topic is being edited

                            $('body').on('click', '.edit-trending-topic-btn', function() {
                                const topicId = $(this).data('trending-topic-id');
                                currentlyEditingTrendingTopicId = topicId; // Set the ID of the trending topic being edited
                                const $trendingCard = $(this).closest('.row.align-items-center');
                                const $display = $trendingCard.find('.trending-topic-name-display[data-trending-topic-id="' + topicId + '"]');
                                const $input = $trendingCard.find('.trending-topic-name-input[data-trending-topic-id="' + topicId + '"]');

                                $display.addClass('d-none');
                                $input.removeClass('d-none').focus().select();
                            });

                            // Save when clicking outside the input field OR when Enter is pressed for trending topics
                            $(document).on('click keypress', function(event) {
                                if (currentlyEditingTrendingTopicId !== null) {
                                    const $target = $(event.target);
                                    const $editInput = $('.trending-topic-name-input[data-trending-topic-id="' + currentlyEditingTrendingTopicId + '"]');

                                    const isOutsideClick = !$target.is($editInput) && !$target.closest('.edit-trending-topic-btn[data-trending-topic-id="' + currentlyEditingTrendingTopicId + '"]').length;
                                    const isEnterKey = event.type === 'keypress' && event.which === 13; // Check for Enter key

                                    if (isOutsideClick || isEnterKey) {
                                        const topicId = currentlyEditingTrendingTopicId;
                                        const newName = $editInput.val();

                                        // Reset the currently editing ID
                                        currentlyEditingTrendingTopicId = null;

                                        $.ajax({
                                            url: '/topic/updateName', // Assuming the same endpoint
                                            type: 'POST',
                                            data: { id: topicId, topicName: newName },
                                            success: function(response) {
                                                location.reload();
                                            },
                                            error: function() {
                                                alert('Something went wrong while updating the topic.');
                                            }
                                        });
                                    }
                                }
                            });

                            // Prevent immediate blur when clicking the edit button itself for trending topics
                            $('body').on('mousedown', '.edit-trending-topic-btn', function(event) {
                                event.preventDefault(); // Prevent the document click from firing immediately
                            });

                        });

                    </script>

                </div>

                <div class="mt-3 me-1 d-flex justify-content-end">
                    <g:if test="${user.id == session.user.id && user.username != 'adminuser'}">
                        <g:link controller="profile" action="editProfile" class="btn btn-sm btn-primary" style="font-size: 1.5em;">
                            Edit
                        </g:link>
                    </g:if>
                </div>
            </div>

        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

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

<script>

    $(document).ready(function() {
        $('body').on('click', '.delete-topic', function() {
            var topicId = $(this).data('id');

            console.log("topicID from Javascript: " + topicId);

            if (confirm('Are you sure you want to delete this topic?')) {
                $.ajax({
                    url: '/dashboard/deleteTopic',
                    type: 'POST',
                    data: { id: topicId },
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    success: function(response) {
                        alert(response);
                        location.reload();
                    },
                    error: function(xhr) {
                        alert('Error deleting topic: ' + xhr.responseText);
                    }
                });
            }
        });

        $('body').on('click', '.change-visibility', function (e) {
            e.preventDefault();

            var topicId = $(this).data('id');
            var newVisibility = $(this).data('value');

            if (confirm('Are you sure you want to change visibility to ' + newVisibility + '?')) {
                // Set values in the hidden form
                $('.visibilityTopicId').val(topicId);
                $('.visibilityValue').val(newVisibility);

                // Submit the form
                $('#visibilityForm-' + topicId)[0].submit();
            }
        });

        $('body').on('click', '.change-seriousness', function (e) {
            e.preventDefault();

            var topicId = $(this).data('id');
            var newSeriousness = $(this).data('value');

            if (confirm('Are you sure you want to change visibility to ' + newSeriousness + '?')) {
                // Set values in the hidden form
                $('.seriousnessTopicId').val(topicId);
                $('.seriousnessValue').val(newSeriousness);

                // Submit the form
                $('#seriousnessForm-' + topicId)[0].submit();
            }
        });

        let currentlyEditingTopicId = null; // To track which topic is being edited

        $('body').on('click', '.edit-topic-inline-btn', function() {
            const topicId = $(this).data('topic-id');
            currentlyEditingTopicId = topicId; // Set the ID of the topic being edited
            const $row = $(this).closest('.row');
            const $container = $row.find('.card-title');
            const $input = $container.find('.topic-name-input[data-topic-id="' + topicId + '"]');
            const $display = $container.find('.topic-name-display[data-topic-id="' + topicId + '"]');

            $display.addClass('d-none');
            $input.removeClass('d-none').focus().select();
        });f

        // Save when clicking outside the input field OR when Enter is pressed
        $(document).on('click keypress', function(event) {
            if (currentlyEditingTopicId !== null) {
                const $target = $(event.target);
                const $editInput = $('.topic-name-input[data-topic-id="' + currentlyEditingTopicId + '"]');

                const isOutsideClick = !$target.is($editInput) && !$target.closest('.edit-topic-inline-btn[data-topic-id="' + currentlyEditingTopicId + '"]').length;
                const isEnterKey = event.type === 'keypress' && event.which === 13; // Check for Enter key

                if (isOutsideClick || isEnterKey) {
                    const topicId = currentlyEditingTopicId;
                    const newName = $editInput.val();

                    // Reset the currently editing ID
                    currentlyEditingTopicId = null;

                    $.ajax({
                        url: '/topic/updateName',
                        type: 'POST',
                        data: { id: topicId, topicName: newName },
                        success: function(response) {
                            location.reload();
                        },
                        error: function() {
                            alert('Something went wrong while updating the topic.');
                        }
                    });
                }
            }
        });

        // Prevent immediate blur when clicking the edit button itself
        $('body').on('mousedown', '.edit-topic-inline-btn', function(event) {
            event.preventDefault(); // Prevent the document click from firing immediately
        });

    });

</script>


</body>
</html>
