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
                        <!-- Seriousness -->
                        <div class="dropdown">
                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                ${topic.subscriptions.seriousness ?: 'Seriousness'}
                            </button>
                            <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#">CASUAL</a></li>
                                    <li><a class="dropdown-item" href="#">SERIOUS</a></li>
                                    <li><a class="dropdown-item" href="#">VERY_SERIOUS</a></li>
                            </ul>
                        </div>

                        <!-- Visibility -->
                        <div class="dropdown">
                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                ${topic.visibility ?: 'Visibility'}
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

    </div>


</div>