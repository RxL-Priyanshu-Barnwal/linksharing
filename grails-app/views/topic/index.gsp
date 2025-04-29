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

        <style>

         .scroll-area::-webkit-scrollbar {
             display: none;
         }
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
        <div class="col-md-5 px-5">

            <div class="topic-card card custom-card">

                <g:if test="${topic}">
                    <div class="card-header">
                        <h5 class="mb-0">Topic</h5>
                    </div>
                    <div class="row align-items-center p-3">
                        <!-- Profile Image -->
                        <div class="col-md-3 mb-3 mb-md-0">
                            <g:if test="${topic.user?.photo}">
                                <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: topic.user.id])}" alt="${topic.user.firstName}" class="img-fluid">
                            </g:if>
                        </div>
                        <div class="col-md-9">
                            <g:link controller="topic" action="index" params="[id: topic.id]" style="color: inherit; text-decoration: none;">
                                <span class="card-title mb-1 topic-name-display" data-topic-id="${topic.id}" style="font-size: 1.3em">${topic?.name}</span>
                            </g:link>
                            <input type="text" class="form-control topic-name-input d-none" id="topicNameInput-${topic.id}" data-topic-id="${topic.id}" value="${topic.name}">

                            <g:link controller="profile" action="userProfile" params="[id: topic?.user?.id]" style="color: inherit; text-decoration: none;">
                                <p class="text-secondary small mb-3">@${topic?.user?.username}</p>
                            </g:link>

                            <div class="d-flex justify-content-between mb-3">
                                <p class="mb-0 text-secondary">Subscriptions: <span>${topic?.subscriptions?.size() ?: 0}</span></p>
                                <p class="mb-0 text-secondary">Posts: <span>${topic?.resources?.size() ?: 0}</span></p>
                            </div>
                            <!-- Bottom Controls -->
                            <div class="d-flex align-items-center gap-3 flex-wrap mb-4">
                                <g:if test="${topic.user?.id == session.user?.id || session.user.admin}">
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
                                        <input type="hidden" name="id" value="${topic.id}">
                                        <input type="hidden" name="visibility" class="visibility-value">
                                    </form>

                                    <i class="bi bi-pencil-square fs-5 edit-topic-inline-btn" title="Edit" role="button" data-topic-id="${topic.id}"></i>

                                    <g:form controller="dashboard" action="deleteTopic" method="POST" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this topic?');">
                                        <input type="hidden" name="id" value="${topic.id}" />
                                        <button type="submit" class="btn btn-link p-0 m-0" style="border: none;" title="Delete">
                                            <i class="bi bi-trash fs-5 text-danger"></i>
                                        </button>
                                    </g:form>

                                </g:if>
                                <g:if test="${!topic.subscriptions?.any { it.user?.id == session.user?.id }}">
                                    <form method="post" action="${createLink(controller: 'topic', action: 'subscribe')}" class="mb-0">
                                        <input type="hidden" name="topicId" value="${topic.id}">
                                        <button type="submit" class="btn btn-sm btn-primary">Subscribe</button>
                                    </form>
                                </g:if>
                                <g:else>
                                    <!-- Show Unsubscribe Button if User is Subscribed and not the creator -->
                                    <g:if test="${topic.user?.id != session.user?.id}">
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

                                        <form class="seriousnessForm-${topic.id}" method="post" action="${createLink(controller: 'dashboard', action: 'updateSeriousness')}" style="display: none;">
                                            <input type="hidden" name="id" value="${topic.id}">
                                            <input type="hidden" name="seriousness" class="seriousness-value">
                                        </form>

                                        <form method="post" action="${createLink(controller: 'topic', action: 'unsubscribe')}" class="mb-0">
                                            <input type="hidden" name="topicId" value="${topic.id}">
                                            <button type="submit" class="btn btn-sm btn-danger">Unsubscribe</button>
                                        </form>
                                    </g:if>
                                </g:else>
                            </div>
                        </div>
                    </div>


                </g:if>

            </div>

<!--            Users Subscribed to the topic-->

            <div class="card custom-card mt-5">
                <div class="card-header">
                    <h5 class="mb-1">Users</h5>
                </div>

                <div class="card-body users-body py-3" style="max-height: 480px; overflow-y: auto; overflow-x: hidden; padding-right: 10px;">


                    <g:if test="${subscribedUsers}">
                        <g:each in="${subscribedUsers}" var="user">
                            <div class="row align-items-center mb-3 p-2">
                                <div class="col-md-3">
                                    <g:if test="${user?.photo}">
                                        <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: user.id])}" alt="${user.firstName}" class="img-fluid">
                                    </g:if>
                                </div>
                                <div class="col-md-9">
                                    <div>
                                        <g:link controller="profile" action="userProfile" params="[id: user?.id]" style="color: inherit; text-decoration: none;">
                                            <strong style="font-size:1.4em;">${user?.firstName} ${user?.lastName}</strong>
                                            <small class="text-secondary ms-2">@${user?.username}</small>
                                        </g:link>
                                    </div>
                                    <p class="card-text small mb-4" style="color: #808080;">${user?.email}</p>
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <p class="mb-0" style="color: #808080;">Subscription: <span>${user?.subscriptions?.size() ?: 0}</span></p>
                                        </div>
                                        <div>
                                            <p class="mb-0" style="color: #808080;">Topic: <span>${user?.topics?.size() ?: 0}</span></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </g:each>
                    </g:if>
                </div>
            </div>
        </div>

<!--            Subscribed users sections ends -->

        <div class="col-md-7 px-5">

            <div class="card custom-card mb-4">

                <div class="card-header d-flex justify-content-between align-items-center">
                    <span class="mb-0" style="font-size: 1.3em">Posts</span>
<!--                    <div class="w-50">-->
<!--                        <input type="text" id="searchBox" placeholder="Search posts..." class="form-control form-control-sm rounded-pill" aria-label="Search" />-->
<!--                    </div>-->
                </div>
                <div class="card-body me-4 scroll-area" style="max-height: 500px; overflow-y: auto; overflow-x: hidden; padding-right: 15px">
                    <g:if test="${resources}">
                        <g:each in="${resources}" var="resource">
                            <!-- Individual Post Item -->
                            <div class="post-item d-flex mb-2">
                                <!-- Profile photo on the left -->
                                <div class="post-item-avatar">
                                    <g:if test="${resource?.user?.photo}">
                                        <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: resource?.user.id])}" alt="${resource?.user.firstName}" class="img-fluid rounded p-3">
                                    </g:if>
                                </div>
                                <!-- post item content on the right -->
                                <div class="post-item-content ms-3 w-100">
                                    <!-- Header: Creator's Name, Username, Topic Name -->
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <g:link controller="profile" action="userProfile" params="[id: resource.user.id]" style="color: inherit; text-decoration: none;">
                                                <strong style="font-size:1.4em;">${resource.user.firstName} ${resource.user.lastName}</strong>
                                                <small class="text-secondary ms-2">@${resource.user.username}</small>
                                            </g:link>
                                        </div>
<!--                                        <div>-->
<!--                                            <span class="text-secondary">Topic: </span>-->
<!--                                            <span class="fw-bold">${resource.topic.name}</span>-->
<!--                                        </div>-->
                                    </div>
                                    <!-- Description -->
                                    <p class="mt-2 me-3 post-description overflow-hidden" >${resource.description}</p>
                                    <!-- Action Buttons -->
                                    <div class="d-flex gap-2 mt-3 justify-content-end">

                                        <g:if test="${resource instanceof linksharing.DocumentResource}">
                                            <g:link controller="resource" action="download" params="[id: resource.id]" class="btn btn-sm btn-outline-primary">Download</g:link>
                                        </g:if>

                                        <g:if test="${resource instanceof linksharing.LinkResource}">
                                            <a href="${resource.url}" target="_blank" class="btn btn-sm btn-outline-secondary">View Full Site</a>
                                        </g:if>

<!--                                        <button type="submit" class="btn btn-sm btn-outline-success">Mark as Read</button>-->
                                        <g:link controller="resource" action="index" params="[id: resource.id]">
                                            <button class="btn btn-sm btn-outline-info me-1">View Post</button>
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


<script>

    $(document).ready(function() {

        $('#searchBox').on('input', function() {
            var query = $(this).val().toLowerCase();

            $('.post-item').each(function() {
                var description = $(this).find('.post-description').text().toLowerCase();

                if(description.indexOf(query) > -1) {
                    console.log('showing')
                    $(this).show();
                } else {
                    console.log('hiding')
                    $(this).hide();
                }
            })
        });

        $('body').on('click', '.change-visibility', function (e) {
            e.preventDefault();

            var topicId = $(this).data('id');
            var newVisibility = $(this).data('value');

            if (confirm('Are you sure you want to change visibility to ' + newVisibility + '?')) {
                var $form = $('#visibilityForm-' + topicId);
                $form.find('input[name="visibility"]').val(newVisibility);
                $form[0].submit();
            }
        });

        $('body').on('click', '.change-seriousness', function (e) {
            e.preventDefault();

            var topicId = $(this).data('id');
            var newSeriousness = $(this).data('value');

            if (confirm('Are you sure you want to change seriousness to ' + newSeriousness + '?')) {
                // Select the form by dynamic ID
                var $form = $('.seriousnessForm-' + topicId);
                // Set input values by name attribute
                $form.find('input[name="seriousness"]').val(newSeriousness);
                // Submit the form
                $form[0].submit();
            }
        });

        let currentlyEditingTopicId = null; // To track which topic is being edited

        $('body').on('click', '.edit-topic-inline-btn', function() {
            const topicId = $(this).data('topic-id');
            currentlyEditingTopicId = topicId; // Set the ID of the topic being edited
            const $col = $(this).closest('.col-md-9');
            const $input = $col.find('.topic-name-input[data-topic-id="' + topicId + '"]');
            const $display = $col.find('.topic-name-display[data-topic-id="' + topicId + '"]');

            $display.addClass('d-none');
            $input.removeClass('d-none').focus().select();
        });

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


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>
