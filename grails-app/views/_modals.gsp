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
                        <input type="text" class="form-control" id="topicName" name="name" placeholder="Enter topic name" required>
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
            <g:form controller="invite" action="sendInvite">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="sendInviteLabel">Send Invitation</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Email Field -->
                    <div class="mb-3">
                        <label for="emailInput" class="form-label">Email:</label>
                        <input type="email" class="form-control" id="emailInput" name="email" placeholder="Enter email address" required>
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
                        <input type="text" class="form-control" id="linkInput" name="url" placeholder="Enter URL" required>
                    </div>

                    <!-- Description Field -->
                    <div class="mb-3">
                        <label for="descriptionInput" class="form-label">Description:</label>
                        <textarea class="form-control" id="descriptionInput" name="description" rows="4" placeholder="Enter description" required></textarea>
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

            <g:form controller="resource" action="createDocResource">

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
                        <input type="file" class="form-control" id="documentInput" name="filePath" accept=".pdf,.doc,.docx,.txt,.rtf,.odt" required>
                    </div>

                    <!-- Description Field -->
                    <div class="mb-3">
                        <label for="descriptionInputDoc" class="form-label">Description:</label>
                        <textarea class="form-control" id="descriptionInputDoc" rows="4" name="description" placeholder="Enter description" required></textarea>
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

            </g:form>

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