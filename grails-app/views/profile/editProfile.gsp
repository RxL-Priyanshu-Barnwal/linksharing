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

                <div class="createdTopics-body">

                    <div class="card custom-card mt-5">

                        <div class="card-header">
                            <h5 class="mb-0">Topics</h5>
                        </div>


                        <div class="card-body scroll-area" style="max-height: 520px; overflow-y: auto; overflow-x: hidden; padding-right: 10px">

                            <g:each in="${topics}" var="topic">

                                <div class="row align-items-center">

                                    <!-- Profile Image -->
                                    <div class="col-md-3 mb-3 mb-md-0">
                                        <g:if test="${topic.user?.photo}">
                                            <img src="${createLink(controller: 'profile', action: 'renderImage', params: [id: topic.user.id])}" alt="${topic.user.firstName}" class="img-fluid">
                                        </g:if>                                    </div>

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
                                                    <input type="hidden" name="id" value="${topic.id}">
                                                    <input type="hidden" name="visibility" class="visibility-value">
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
                                                    <input type="hidden" name="id" value="${topic.id}">
                                                    <input type="hidden" name="seriousness" class="seriousness-value">
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
