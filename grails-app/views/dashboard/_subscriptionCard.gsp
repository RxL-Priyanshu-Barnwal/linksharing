<div class="card custom-card mt-5">
    <div class="card-header">
        <h5 class="mb-0">Subscriptions</h5>
    </div>


    <div class="card-body subscription-body py-3">

        <div class="subscription-scroll-area" style="max-height: 480px; overflow-y: auto; overflow-x: hidden; padding-right: 10px">

            <g:if test="${subscribedTopics}">
                <g:each in="${subscribedTopics}" var="subscribedTopic">

                    <div class="row align-items-center">

                        <!-- Profile Image -->
                        <div class="col-md-3 mb-3 mb-md-0">
                            <img src="${subscribedTopic.topic.user.photo}" alt="Profile Picture" class="img-fluid rounded">
                        </div>

                        <div class="col-md-9">
                            <h5 class="card-title mb-1">

                                <g:link controller="topic" action="index" params="[id: subscribedTopic.topic.id]" style="color: inherit; text-decoration: none;">
                                    <span id="topicName-${subscribedTopic.topic.id}">${subscribedTopic.topic.name}</span>
                                </g:link>
                                <input type="text" id="topicNameInput-${subscribedTopic.topic.id}" value="${subscribedTopic.topic.name}" style="display: none;">

                            </h5>

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
                                            <li><a class="dropdown-item change-seriousness" data-id="${subscribedTopic.topic.id}" data-value="${seriousness}" href="#">${seriousness}</a></li>
                                        </g:each>
                                    </ul>
                                </div>

                                <!-- Hidden form to send data -->
                                <form id="seriousnessForm" method="post" action="${createLink(controller: 'dashboard', action: 'updateSeriousness')}" style="display: none;">
                                    <input type="hidden" name="id" id="seriousnessTopicId">
                                    <input type="hidden" name="seriousness" id="seriousnessValue">
                                </form>

                                <!-- Visibility -->
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        ${subscribedTopic.topic.visibility ?: 'Public'}
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item change-visibility" data-id="${subscribedTopic.topic.id}" data-value="PUBLIC" href="#">PUBLIC</a></li>
                                        <li><a class="dropdown-item change-visibility" data-id="${subscribedTopic.topic.id}" data-value="PRIVATE" href="#">PRIVATE</a></li>
                                    </ul>
                                </div>

                                <!-- Hidden form to send data -->
                                <form id="visibilityForm" method="post" action="${createLink(controller: 'dashboard', action: 'updateVisibility')}" style="display: none;">
                                    <input type="hidden" name="id" id="visibilityTopicId">
                                    <input type="hidden" name="visibility" id="visibilityValue">
                                </form>

                                <!-- Icons -->
                                <i class="bi bi-envelope fs-5" title="Invite" role="button" data-bs-toggle="modal" data-bs-target="#sendInvite"></i>

                                <i class="bi bi-pencil-square fs-5" title="Edit" role="button"></i>

                                <i class="bi bi-trash fs-5 text-danger delete-topic" data-id="${subscribedTopic.topic.id}" title="Delete" role="button"></i>


                            </div>
                        </div>
                    </div>

                </g:each>
            </g:if>

            <g:else>

            </g:else>

        </div>

    </div>
</div>

<style>

    .subscription-scroll-area::-webkit-scrollbar {
        width: 0px;  /* Slim scrollbar */
    }

    .subscription-scroll-area:hover::-webkit-scrollbar {
        width: 3px;
    }

    .subscription-scroll-area::-webkit-scrollbar-track {
        background: transparent;
    }

    .subscription-scroll-area::-webkit-scrollbar-thumb {
        background-color: #ccc;
        border-radius: 4px;
    }

</style>


<script>

    $(document).ready(function() {
        $('body').on('click', '.delete-topic', function() {
            var topicId = $(this).data('id');

            console.log("topicID from Javascript: " + topicId);

            if (confirm('Are you sure you want to delete this topic?')) {
                $.ajax({
                    url: '/dashboard/deleteTopic',
                    type: 'POST',
                    data: { id: topicId },
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    success: function(response) {
                        alert(response);
                        location.reload();
                    },
                    error: function(xhr) {
                        alert('Error deleting topic: ' + xhr.responseText);
                    }
                });
            }
        });

        $('body').on('click', '.change-visibility', function (e) {
            e.preventDefault();

            var topicId = $(this).data('id');
            var newVisibility = $(this).data('value');

            if (confirm('Are you sure you want to change visibility to ' + newVisibility + '?')) {
                // Set values in the hidden form
                $('#visibilityTopicId').val(topicId);
                $('#visibilityValue').val(newVisibility);

                // Submit the form
                $('#visibilityForm')[0].submit();
            }
        });

        $('body').on('click', '.change-seriousness', function (e) {
            e.preventDefault();

            var topicId = $(this).data('id');
            var newSeriousness = $(this).data('value');

            if (confirm('Are you sure you want to change visibility to ' + newSeriousness + '?')) {
                // Set values in the hidden form
                $('#seriousnessTopicId').val(topicId);
                $('#seriousnessValue').val(newSeriousness);

                // Submit the form
                $('#seriousnessForm')[0].submit();
            }
        });


    });



</script>
