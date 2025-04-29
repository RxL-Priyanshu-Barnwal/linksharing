<div class="container my-4" style="width: 80%;">


    <div class="mb-5 shadow-lg me-5" style="background-color: #212529; border-radius: 10px;">
        <h2 class="text-white p-3" style="background-color: #1C1F24; border-top-left-radius: 10px; border-top-right-radius: 10px">Top Posts</h2>
        <div class="row p-3">
            <g:if test="${getTopPosts}">
                <g:each in="${getTopPosts}" var="post">
                    <div class="col-12 d-flex align-items-center" style="background-color: #212529; border-radius: 8px; padding: 15px;">
                        <div style="width: 80px; height: 80px; overflow: hidden; margin-right: 15px; flex-shrink: 0;">
                            <g:if test="${post.user?.photo}">
                                <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: post.user.id])}" alt="${post.user.firstName}" style="width: 100%; height: 100%; object-fit: cover;">
                            </g:if>
                        </div>

                        <div style="flex: 1; min-width: 0">
                            <div class="d-flex align-items-baseline">
                                <h6 class="text-white">${post?.user?.firstName} ${post?.user?.lastName}</h6>
                                <span class="text-muted">  @ ${post?.user?.username}</span>
                                <span class="badge bg-warning ml-auto text-dark">${post?.topic?.name}</span>
                            </div>
                            <p class="text-white-50 mb-0" style="display: -webkit-box; -webkit-box-orient: vertical; -webkit-line-clamp: 3; overflow: hidden;">${post?.description}</p>
                        </div>
                    </div>
                </g:each>
            </g:if>
        </div>
    </div>

    <div class="shadow-lg" style="background-color: #212529; border-radius: 10px;">
        <h2 class="text-white p-3" style="background-color: #1C1F24; border-top-left-radius: 10px; border-top-right-radius: 10px">Recent Posts</h2>
        <div class="row p-3">
            <g:if test="${getRecentPosts}">
                <g:each in="${getRecentPosts}" var="post">
                    <div class="col-12 d-flex align-items-center" style="background-color: #212529; border-radius: 8px; padding: 15px;">
                        <div style="width: 80px; height: 80px; overflow: hidden; margin-right: 15px; flex-shrink: 0;">
                            <g:if test="${post.user?.photo}">
                                <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: post.user.id])}" alt="${post.user.firstName}" style="width: 100%; height: 100%; object-fit: cover;">
                            </g:if>
                        </div>
                        <div style="flex: 1; min-width: 0;">
                            <div class="d-flex align-items-baseline">
                                <h6 class="text-white">${post?.user?.firstName} ${post?.user?.lastName}</h6>
                                <span class="text-muted">  @ ${post?.user?.username}</span>
                                <span class="badge bg-warning ml-auto text-dark">${post?.topic?.name}</span>
                            </div>
                            <p class="text-white-50 mb-0 " style="display: -webkit-box; -webkit-box-orient: vertical; -webkit-line-clamp: 3; overflow: hidden;">${post?.description}</p>
                        </div>
                    </div>
                </g:each>
            </g:if>
        </div>
    </div>

</div>