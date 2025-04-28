<div class="card custom-card mb-4">
    <div class="card-body">
        <div class="row align-items-center">
            <div class="col-md-3">
                <g:if test="${user?.photo}">
                    <img src="${createLink(controller: 'profile', action: 'renderImage', params: [id: user.id])}" alt="${user.firstName}" class="img-fluid rounded p-3">
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
                    <div>
                        <p class="mb-0" style="color: #808080;">Subscription: <span>${user?.subscriptions?.size() ?: 0}</span></p>
                    </div>
                    <div>
                        <p class="mb-0" style="color: #808080;">Topic: <span>${user?.topics?.size() ?: 0}</span></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



