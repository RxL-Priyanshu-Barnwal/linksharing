<!-- createTopic Modal -->
<div class="modal fade" id="createTopic" tabindex="-1" aria-labelledby="createTopicLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <g:form controller="topic" action="createTopic">

                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="createTopicLabel">Create Topic</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">

                    <div class="mb-3">
                        <label for="topicName" class="form-label">Name:</label>
                        <input type="text" class="form-control" id="topicName" name="name" placeholder="Enter topic name" required maxlength="40">
                        <g:if test="${flash.topicMessage}">
                            <p style="color: red;">${flash.topicMessage}</p>
                        </g:if>
                    </div>
                    <div class="mb-3">
                        <label for="topicVisibility" class="form-label">Visibility:</label>
                        <select class="form-select" id="topicVisibility" name="visibility">
                            <option value="public">Public</option>
                            <option value="private">Private</option>
                        </select>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>

            </g:form>
        </div>
    </div>
</div>
<g:if test="${flash.showTopicModal}">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Initialize the modal using Bootstrap's JavaScript API
            var createTopicModal = new bootstrap.Modal(document.getElementById('createTopic'));
            createTopicModal.show();  // This will open the modal if the condition is true
        });
    </script>
</g:if>

<!-- sendInvite Modal -->
<div class="modal fade" id="sendInvite" tabindex="-1" aria-labelledby="sendInviteLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <g:form controller="topic" action="sendInvite">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="sendInviteLabel">Send Invitation</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Email Field -->
                    <div class="mb-3">
                        <label for="emailInput" class="form-label">Email:</label>
                        <input type="email" class="form-control" id="emailInput" name="invitedEmail" placeholder="Enter email address" required maxlength="50">
                    </div>
                    <!-- Topic Dropdown -->
                    <div class="mb-3">
                        <label for="topicSelectInvite" class="form-label">Topic:</label>
                        <select class="form-select" id="topicSelectInvite" name="topic" required>
                            <option selected disabled>Select a topic</option>


                            <g:if test="${session.user?.admin}">
                                <!-- If the user is an admin, show all topics -->
                                <g:each in="${topicNames}" var="topicName">
                                    <option value="${topicName}">${topicName}</option>
                                </g:each>
                            </g:if>

                            <g:else>
                                <!-- If the user is not an admin, show only subscribed topics -->
                                <g:each in="${subscribedTopics}" var="subscription">
                                    <option value="${subscription.topic.name}">${subscription.topic.name}</option>
                                </g:each>
                            </g:else>


                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Send Invite</button>
                </div>
            </g:form>
        </div>
    </div>
</div>

<!-- createLinkResource Modal-->
<div class="modal fade" id="createLinkResource" tabindex="-1" aria-labelledby="createLinkResourceLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <g:form controller="resource" action="createLinkResource">

                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="createLinkResourceLabel">Create Link Resource</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">

                    <g:if test="${flash.linkResourceMessage}">
                        <p style="color: red;">${flash.linkResourceMessage}</p>
                    </g:if>

                    <!-- Link Field -->
                    <div class="mb-3">
                        <label for="linkInput" class="form-label">Link:</label>
                        <input type="text" class="form-control" id="linkInput" name="url" placeholder="Enter URL" required maxlength="300">
                    </div>

                    <!-- Description Field -->
                    <div class="mb-3">
                        <label for="descriptionInput" class="form-label">Description:</label>
                        <textarea class="form-control" id="descriptionInput" name="description" rows="4" placeholder="Enter description" required maxlength="300"></textarea>
                    </div>

                    <!-- Topic Dropdown -->
                    <div class="mb-3">
                        <label for="topicSelectLink" class="form-label">Topic:</label>
                        <select class="form-select" id="topicSelectLink" name="topic" required>
                            <option selected disabled>Select a topic</option>


                            <g:if test="${session.user?.admin}">
                                <!-- If the user is an admin, show all topics -->
                                <g:each in="${topicNames}" var="topicName">
                                    <option value="${topicName}">${topicName}</option>
                                </g:each>
                            </g:if>

                            <g:else>
                                <!-- If the user is not an admin, show only subscribed topics -->
                                <g:each in="${subscribedTopics}" var="subscription">
                                    <option value="${subscription.topic.name}">${subscription.topic.name}</option>
                                </g:each>
                            </g:else>


                        </select>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>

            </g:form>

        </div>
    </div>
</div>
<g:if test="${flash.showLinkModal}">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Initialize the modal using Bootstrap's JavaScript API
            var createLinkModal = new bootstrap.Modal(document.getElementById('createLinkResource'));
            createLinkModal.show();  // This will open the modal if the condition is true
        });
    </script>
</g:if>

<!-- createDocResource Modal -->
<div class="modal fade" id="createDocResource" tabindex="-1" aria-labelledby="createDocResourceLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <g:uploadForm controller="resource" action="createDocResource" method="POST">

                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="createDocResourceLabel">Create Document Resource</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">

                    <g:if test="${flash.docResourceMessage}">
                        <p style="color: red;">${flash.docResourceMessage}</p>
                    </g:if>

                    <!-- Document Upload Field -->
                    <div class="mb-3">
                        <label for="documentInput" class="form-label">Document:</label>
                        <input type="file" class="form-control" id="documentInput" name="document" required>
                    </div>

                    <!-- Description Field -->
                    <div class="mb-3">
                        <label for="descriptionInputDoc" class="form-label">Description:</label>
                        <textarea class="form-control" id="descriptionInputDoc" rows="4" name="description" placeholder="Enter description" required maxlength="300"></textarea>
                    </div>

                    <!-- Topic Dropdown -->
                    <div class="mb-3">
                        <label for="topicSelectDoc" class="form-label">Topic:</label>
                        <select class="form-select" id="topicSelectDoc" name="topic" required>
                            <option selected disabled>Select a topic</option>


                            <g:if test="${session.user?.admin}">
                                <!-- If the user is an admin, show all topics -->
                                <g:each in="${topicNames}" var="topicName">
                                    <option value="${topicName}">${topicName}</option>
                                </g:each>
                            </g:if>

                            <g:else>
                                <!-- If the user is not an admin, show only subscribed topics -->
                                <g:each in="${subscribedTopics}" var="subscription">
                                    <option value="${subscription.topic.name}">${subscription.topic.name}</option>
                                </g:each>
                            </g:else>


                        </select>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>

            </g:uploadForm>

        </div>
    </div>
</div>
<g:if test="${flash.showDocModal}">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Initialize the modal using Bootstrap's JavaScript API
            var createDocModal = new bootstrap.Modal(document.getElementById('createDocResource'));
            createDocModal.show();  // This will open the modal if the condition is true
        });
    </script>
</g:if>

<div class="modal fade" id="allPublicTopics" tabindex="-1" aria-labelledby="allPublicTopicsLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h1 class="modal-title fs-5" id="allPublicTopicsLabel">All Public Topics</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body" style="max-height: 500px; overflow-y: auto;">
                <g:each in="${publicTopics}" var="topic">
                    <div class="row align-items-center m-2" style="overflow: hidden">
                        <!-- Profile Image -->
                        <div class="col-md-3 mb-2 mb-md-0">
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
                                <g:if test="${!topic.subscriptions?.any { it.user?.id == session.user?.id }}">
                                    <form method="post" action="${createLink(controller: 'topic', action: 'subscribe')}" class="mb-0">
                                        <input type="hidden" name="topicId" value="${topic.id}">
                                        <button type="submit" class="btn btn-sm btn-primary">Subscribe</button>
                                    </form>
                                </g:if>
                                <g:else>
                                    <g:if test="${topic.user?.id != session.user?.id}">
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
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const form = document.querySelector('#createDocResource form');
        const fileInput = document.getElementById('documentInput');
        const errorMsgId = 'fileSizeErrorMsg';

        form.addEventListener('submit', function (e) {
            // Remove previous error message if present
            const prevError = document.getElementById(errorMsgId);
            if (prevError) prevError.remove();

            const file = fileInput.files[0];
            if (file) {
                const maxSize = 25 * 1024 * 1024; // 25MB in bytes
                if (file.size > maxSize) {
                    e.preventDefault();

                    // Show error message above the file input
                    const errorMsg = document.createElement('p');
                    errorMsg.id = errorMsgId;
                    errorMsg.style.color = 'red';
                    errorMsg.textContent = 'File size must not exceed 25MB.';
                    fileInput.parentNode.insertBefore(errorMsg, fileInput.nextSibling);

                    // Optionally, clear the file input
                    fileInput.value = "";
                }
            }
        });
    });
</script>
