<div class="container my-4" style="width: 70%;">

    <div class="mb-5 shadow-lg" style="background-color: #212529; border-radius: 10px;">
        <h2 class="text-white p-2" style="background-color: #1C1F24; border-top-left-radius: 10px; border-top-right-radius: 10px">Trending Posts</h2>

        <div class="row p-3"> <div class="col-12 d-flex align-items-center overflow-hidden" style="background-color: #212529; border-radius: 8px; padding: 10px;">
            <div style="width: 80px; height: 80px; border-radius: 50%; overflow: hidden; margin-right: 15px;">
                <img src="" alt="User Photo" style="width: 100%; height: 100%; object-fit: cover;">
            </div>
            <div style="flex-grow: 1;">
                <div class="d-flex justify-content-between align-items-baseline">
                    <h6 class="text-white mb-1">John Doe</h6>
                    <span class="text-muted small">@johndoe</span>
                    <span class="badge bg-info ml-auto">Technology</span>
                </div>
                <p class="text-white-50 mb-0 small">A brief and engaging description of this top post.</p>
            </div>
        </div>

            <div class="col-12 d-flex align-items-center" style="background-color: #212529; border-radius: 8px; padding: 10px;">
                <div style="width: 80px; height: 80px; border-radius: 50%; overflow: hidden; margin-right: 15px;">
                    <img src="" alt="User Photo" style="width: 100%; height: 100%; object-fit: cover;">
                </div>
                <div style="flex-grow: 1;">
                    <div class="d-flex justify-content-between align-items-baseline">
                        <h6 class="text-white mb-1">Jane Smith</h6>
                        <span class="text-muted small">@janesmith</span>
                        <span class="badge bg-success ml-auto">Travel</span>
                    </div>
                    <p class="text-white-50 mb-0 small">An inspiring story or key takeaway from this popular travel post.</p>
                </div>
            </div>
        </div>
    </div>


    <div class="shadow-lg" style="background-color: #212529; border-radius: 10px;">
        <h2 class="text-white p-2" style="background-color: #1C1F24; border-top-left-radius: 10px; border-top-right-radius: 10px">Recent Posts</h2>
        <div class="row p-3">

            <g:each in="${getRecentPosts}" var="post">

                <div class="col-12 d-flex align-items-center" style="background-color: #212529; border-radius: 8px; padding: 15px;">
                    <div style="width: 80px; height: 80px; border-radius: 50%; overflow: hidden; margin-right: 15px;">
                        <img src="${post?.user?.photo?: ''}" alt="User Photo" style="width: 100%; height: 100%; object-fit: cover;">
                    </div>
                    <div style="flex-grow: 1;">
                        <div class="d-flex align-items-baseline">
                            <h6 class="text-white">${post?.user?.firstName} ${post?.user?.lastName}</h6>
                            <span class="text-muted small">  @ ${post?.user?.username}</span>
                            <span class="badge bg-warning ml-auto text-dark">${post?.topic?.name}</span>
                        </div>
                        <p class="text-white-50 mb-0 small">${post?.description}</p>
                    </div>
                </div>

            </g:each>

        </div>
    </div>

</div>