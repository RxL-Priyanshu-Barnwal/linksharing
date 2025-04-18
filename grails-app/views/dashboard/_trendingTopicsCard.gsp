<div class="card custom-card mt-5">

    <div class="card-header">
        <h5 class="mb-0">Trending Topics</h5>
    </div>


    <div class="card-body">

        <g:each in="${trendingTopics}" var="topic">

            <div class="row align-items-center">

                <!-- Profile Image -->
                <div class="col-md-3 mb-3 mb-md-0">
                    <img src="${topic?.user?.photo}" alt="Profile Picture" class="img-fluid rounded">
                </div>

                <div class="col-md-9">
                    <h5 class="card-title mb-1">${topic?.name}</h5>

                    <p class="text-secondary small mb-3">${topic?.user?.username}</p>

                    <div class="d-flex justify-content-between mb-3">
                        <p class="mb-0 text-secondary">Subscriptions: <span>${topic?.subscriptions?.size() ?: 0}</span></p>
                        <p class="mb-0 text-secondary">Posts: <span>${topic?.resources?.size() ?: 0}</span></p>
                    </div>

                    <!-- Bottom Controls -->

                        <div class="d-flex align-items-center gap-3 flex-wrap mb-4">

                            <g:if test="${topic.user?.id == session.user?.id}">
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



                                <!-- Icons -->
                                <i class="bi bi-envelope fs-5" title="Invite" role="button" data-bs-toggle="modal" data-bs-target="#sendInvite"></i>
                                <i class="bi bi-pencil-square fs-5" title="Edit" role="button"></i>
                                <i class="bi bi-trash fs-5 text-danger delete-topic" data-id="${topic.id}" title="Delete" role="button"></i>

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

