<div class="card custom-card mb-4">
    <div class="card-body">
        <div class="row align-items-center">
            <div class="col-md-3">
                <g:if test="${user?.photo}">
                    <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: user.id])}" alt="${user.firstName}" class="img-fluid rounded p-3">
                </g:if>
            </div>
            <div class="col-md-9">
                <div>
                    <g:link controller="profile" action="userProfile" params="[id: user.id]" style="color: inherit; text-decoration: none;">
                        <strong style="font-size:1.4em;">${user?.firstName} ${user?.lastName}</strong>
                        <small class="text-secondary ms-2">@${user?.username}</small>
                    </g:link>
                </div>
                <p class="card-text small mb-4" style="color: #808080;">${user?.email}</p>
                <div class="d-flex justify-content-between">
                    <div data-bs-toggle="modal" data-bs-target="#subscribedTopics">
                        <p class="mb-0" style="color: #808080; cursor: pointer;">Subscription: <span>${user?.subscriptions?.size() ?: 0}</span></p>
                    </div>
                    <div data-bs-toggle="modal" data-bs-target="#createdTopics">
                        <p class="mb-0" style="color: #808080; cursor: pointer;">Topic: <span>${user?.topics?.size() ?: 0}</span></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="subscribedTopics" tabindex="-1" aria-labelledby="subscribedTopicsLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h1 class="modal-title fs-5" id="subscribedTopicsLabel">Subscriptions</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body" style="max-height: 500px; overflow-y: auto;">
                <g:each in="${subscribedTopics}" var="subscribedTopic">
                    <div class="row align-items-center">
                        <!-- Profile Image -->
                        <div class="col-md-3 mb-3 mb-md-0">
                            <g:if test="${subscribedTopic.topic.user?.photo}">
                                <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: subscribedTopic.topic.user.id])}" alt="${subscribedTopic.topic.user.firstName}" class="img-fluid">
                            </g:if>
                        </div>
                        <div class="col-md-9">
                            <g:link controller="topic" action="index" params="[id: subscribedTopic.topic.id]" style="color: inherit; text-decoration: none;">
                                <span class="card-title mb-1 trending-topic-name-display" data-trending-topic-id="${subscribedTopic.topic.id}" style="font-size: 1.3em">${subscribedTopic.topic?.name}</span>
                            </g:link>

                            <g:link controller="profile" action="userProfile" params="[id: subscribedTopic.topic.user.id]" style="color: inherit; text-decoration: none;">
                                <p class="text-secondary small mb-3">${subscribedTopic.topic?.user?.username}</p>
                            </g:link>

                            <div class="d-flex justify-content-between mb-3">
                                <p class="mb-0 text-secondary">Subscriptions: <span>${subscribedTopic.topic?.subscriptions?.size() ?: 0}</span></p>
                                <p class="mb-0 text-secondary">Posts: <span>${subscribedTopic.topic?.resources?.size() ?: 0}</span></p>
                            </div>
                            <!-- Bottom Controls -->
                            <div class="d-flex align-items-center gap-3 flex-wrap mb-4">
                                <g:if test="${!subscribedTopic.topic.subscriptions?.any { it.user?.id == session.user?.id }}">
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



<div class="modal fade" id="createdTopics" tabindex="-1" aria-labelledby="createdTopicsLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h1 class="modal-title fs-5" id="createdTopicsLabel">Topics</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body" style="max-height: 500px; overflow-y: auto;">
                <g:each in="${createdTopics}" var="topic">
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


