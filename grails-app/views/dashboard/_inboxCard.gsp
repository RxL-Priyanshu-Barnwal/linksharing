<div class="card custom-card mb-4">
    <div class="card-header">
        <h5 class="mb-0">Inbox</h5>
    </div>
    <div class="card-body" style="max-height: 260px; overflow-y: auto; overflow-x: hidden; padding-right: 15px">


        <g:if test="${readingItems}">

            <g:each in="${readingItems}" var="item">

                <!-- Individual Inbox Item -->
                <div class="inbox-item d-flex mb-2">
                    <!-- Profile photo on the left -->
                    <g:if test="${item.resource?.user?.photo}">
                        <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: item.resource?.user?.id])}" alt="${item.resource?.user?.firstName}" class="img-fluid">
                    </g:if>

                    <!-- Inbox item content on the right -->
                    <div class="inbox-item-content ms-3 w-100">
                        <!-- Header: Creator's Name, Username, Topic Name -->
                        <div class="d-flex justify-content-between">
                            <div>

                                <g:link controller="profile" action="userProfile" params="[id: item.resource.user.id]" style="color: inherit; text-decoration: none;">
                                    <strong>${item.resource.user.firstName} ${item.resource.user.lastName}</strong>
                                    <small class="text-secondary ms-2">@${item.resource.user.username}</small>
                                </g:link>

                            </div>

                            <div>
                                <span class="text-secondary">Topic: </span>

                                <g:link controller="topic" action="index" params="[id: item.resource.topic.id]" style="color: inherit; text-decoration: none;">
                                    <span class="fw-bold">${item.resource.topic.name}</span>
                                </g:link>

                            </div>
                        </div>

                        <!-- Description -->
                        <p class="mt-2">${item.resource.description.encodeAsHTML()}</p>

                        <!-- Action Buttons -->
                        <div class="d-flex gap-2 mt-3 justify-content-end">

                            <g:if test="${item.resource instanceof linksharing.DocumentResource}">
                                <g:link controller="resource" action="download" params="[id: item.resource.id]" class="btn btn-sm btn-outline-primary">Download</g:link>
                            </g:if>

                            <g:if test="${item.resource instanceof linksharing.LinkResource}">
                                <a href="${item.resource.url}" target="_blank" class="btn btn-sm btn-outline-secondary">View Full Site</a>
                            </g:if>

                            <g:form controller="resource" action="markAsRead" method="post" class="d-inline">
                                <g:hiddenField name="id" value="${item.id}"/>
                                <button type="submit" class="btn btn-sm btn-outline-success">Mark as Read</button>
                            </g:form>

                            <g:link controller="resource" action="index" params="[id: item.resource.id]">
                                <button class="btn btn-sm btn-outline-info">View Post</button>
                            </g:link>
                        </div>
                    </div>
                </div>

            </g:each>

        </g:if>


    </div>
</div>


<style>

    .card-body::-webkit-scrollbar {
        width: 0px;  /* Slim scrollbar */
    }

    .card-body:hover::-webkit-scrollbar {
        width: 3px;
    }

    .card-body::-webkit-scrollbar-track {
        background: transparent;
    }

    .card-body::-webkit-scrollbar-thumb {
        background-color: #ccc;
        border-radius: 4px;
    }

</style>
