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
                        <input type="text" class="form-control" id="topicName" name="name" placeholder="Enter topic name">
                        <g:if test="${flash.message}">
                            <p style="color: red;">${flash.message}</p>
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


<g:if test="${flash.showCreateModal}">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Initialize the modal using Bootstrap's JavaScript API
            var myModal = new bootstrap.Modal(document.getElementById('createTopic'));
            myModal.show();  // This will open the modal if the condition is true
        });
    </script>
</g:if>


<!-- sendInvite Modal -->
<div class="modal fade" id="sendInvite" tabindex="-1" aria-labelledby="sendInviteLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="sendInviteLabel">Send Invitation</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">

                <div class="modal-body">
                    <!-- Email Field -->
                    <div class="mb-3">
                        <label for="emailInput" class="form-label">Email:</label>
                        <input type="email" class="form-control" id="emailInput" placeholder="Enter email address">
                    </div>

                    <!-- Topic Dropdown -->
                    <div class="mb-3">
                        <label for="topicSelectInvite" class="form-label">Topic:</label>
                        <select class="form-select" id="topicSelectInvite">
                            <option selected disabled>Select a topic</option>
                            <!-- Dynamic topic options should go here -->
                        </select>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Save</button>
            </div>
        </div>
    </div>
</div>



<!-- createLinkResource Modal-->
<div class="modal fade" id="createLinkResource" tabindex="-1" aria-labelledby="createLinkResourceLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="createLinkResourceLabel">Create Link Resource</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <!-- Link Field -->
                <div class="mb-3">
                    <label for="linkInput" class="form-label">Link:</label>
                    <input type="url" class="form-control" id="linkInput" placeholder="Enter URL">
                </div>

                <!-- Description Field -->
                <div class="mb-3">
                    <label for="descriptionInput" class="form-label">Description:</label>
                    <textarea class="form-control" id="descriptionInput" rows="4" placeholder="Enter description"></textarea>
                </div>

                <!-- Topic Dropdown -->
                <div class="mb-3">
                    <label for="topicSelectLink" class="form-label">Topic:</label>
                    <select class="form-select" id="topicSelectLink">
                        <option selected disabled>Select a topic</option>
                        <!-- Dynamic topic options should go here -->
                    </select>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Save</button>
            </div>
        </div>
    </div>
</div>



<!-- createDocResource Modal -->
<div class="modal fade" id="createDocResource" tabindex="-1" aria-labelledby="createDocResourceLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="createDocResourceLabel">Create Document Resource</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <!-- Document Upload Field -->
                <div class="mb-3">
                    <label for="documentInput" class="form-label">Document:</label>
                    <input type="file" class="form-control" id="documentInput" name="document" accept=".pdf,.doc,.docx,.txt,.rtf,.odt">
                </div>

                <!-- Description Field -->
                <div class="mb-3">
                    <label for="descriptionInputDoc" class="form-label">Description:</label>
                    <textarea class="form-control" id="descriptionInputDoc" rows="4" name="description" placeholder="Enter description"></textarea>
                </div>

                <!-- Topic Dropdown -->
                <div class="mb-3">
                    <label for="topicSelectDoc" class="form-label">Topic:</label>
                    <select class="form-select" id="topicSelectDoc" name="topicId">
                        <option selected disabled>Select a topic</option>
                        <!-- Dynamic topic options should go here -->
                    </select>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Save</button>
            </div>
        </div>
    </div>
</div>
