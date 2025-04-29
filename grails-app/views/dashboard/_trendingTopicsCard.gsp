<div class="card custom-card mt-5">

    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Trending Topics</h5>
        <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#allPublicTopics">View All</button>
    </div>


    <div class="card-body">

        <g:each in="${trendingTopics}" var="topic">

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
                                    <input type="hidden" name="id" value="${topic.id}">
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