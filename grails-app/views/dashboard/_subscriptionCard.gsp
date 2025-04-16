<div class="card custom-card mt-5">
    <div class="card-header">
        <h5 class="mb-0">Subscriptions</h5>
    </div>


    <div class="card-body subscription-body py-3">

        <g:if test="${subscribedTopics}">
            <g:each in="${subscribedTopics}" var="subscribedTopic">

                <div class="row align-items-center">

                    <!-- Profile Image -->
                    <div class="col-md-3 mb-3 mb-md-0">
                        <img src="${subscribedTopic.topic.user.photo ?: '/images/profile.jpeg'}" alt="Profile Picture" class="img-fluid rounded">
                    </div>

                    <div class="col-md-9">
                        <h5 class="card-title mb-1">${subscribedTopic.topic.name}</h5>

                        <p class="text-secondary small mb-3">${subscribedTopic.topic.user.username}</p>

                        <div class="d-flex justify-content-between mb-3">
                            <p class="mb-0 text-secondary">Subscriptions: <span>${subscribedTopic.topic.subscriptions?.size() ?: 0}</span></p>
                            <p class="mb-0 text-secondary">Posts: <span>${subscribedTopic.topic.resources?.size() ?: 0}</span></p>
                        </div>

                        <!-- Bottom Controls -->
                        <div class="d-flex align-items-center gap-3 flex-wrap mb-4">
                            <!-- Seriousness -->
                            <div class="dropdown">
                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    ${subscribedTopic.seriousness}
                                </button>
                                <ul class="dropdown-menu">
                                    <g:each in="${linksharing.Subscription.Seriousness.values()}" var="seriousness">
                                        <li><a class="dropdown-item" href="#">${seriousness}</a></li>
                                    </g:each>
                                </ul>
                            </div>

                            <!-- Visibility -->
                            <div class="dropdown">
                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    ${subscribedTopic.topic.visibility ?: 'Public'}
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#">PUBLIC</a></li>
                                    <li><a class="dropdown-item" href="#">PRIVATE</a></li>
                                </ul>
                            </div>

                            <!-- Icons -->
                            <i class="bi bi-envelope fs-5" title="Invite" role="button"></i>
                            <i class="bi bi-pencil-square fs-5" title="Edit" role="button"></i>
                            <i class="bi bi-trash fs-5 text-danger" title="Delete" role="button"></i>
                        </div>
                    </div>
                </div>

            </g:each>
        </g:if>

        <g:else>

        </g:else>

    </div>
</div>