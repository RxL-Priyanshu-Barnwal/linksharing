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
                                ${topic.subscriptions.seriousness?.first()?.toString()}
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item change-seriousness" data-id="${topic.id}" data-value="CASUAL" href="#">CASUAL</a></li>
                                <li><a class="dropdown-item change-seriousness" data-id="${topic.id}" data-value="SERIOUS" href="#">SERIOUS</a></li>
                                <li><a class="dropdown-item change-seriousness" data-id="${topic.id}" data-value="VERY_SERIOUS" href="#">VERY_SERIOUS</a></li>
                            </ul>

                        </div>

                        <!-- Visibility -->
                        <div class="dropdown">
                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                ${topic.visibility ?: 'Visibility'}
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item change-visibility" data-id="${topic.id}" data-value="PUBLIC" href="#">PUBLIC</a></li>
                                <li><a class="dropdown-item change-visibility" data-id="${topic.id}" data-value="PRIVATE" href="#">PRIVATE</a></li>
                            </ul>
                        </div>

                        <!-- Unique form per topic for visibility -->
                        <form id="visibilityForm-${topic.id}" method="post" action="${createLink(controller: 'dashboard', action: 'updateVisibility')}" style="display: none;">
                            <input type="hidden" name="id" value="${topic.id}">
                            <input type="hidden" name="visibility" class="visibility-value">
                        </form>

                        <!-- Unique form per topic for seriousness -->
                        <form id="seriousnessForm-${topic.id}" method="post" action="${createLink(controller: 'dashboard', action: 'updateSeriousness')}" style="display: none;">
                            <input type="hidden" name="id" value="${topic.id}">
                            <input type="hidden" name="seriousness" class="seriousness-value">
                        </form>


                        <!-- Icons -->
                        <i class="bi bi-envelope fs-5" title="Invite" role="button"></i>
                        <i class="bi bi-pencil-square fs-5" title="Edit" role="button"></i>
                        <i class="bi bi-trash fs-5 text-danger delete-topic" data-id="${topic.id}" title="Delete" role="button"></i>
                    </div>
                </div>
            </div>

        </g:each>

    </div>

</div>

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
                var form = $('#visibilityForm-' + topicId);
                form.find('.visibility-value').val(newVisibility);
                form[0].submit();
            }
        });

        $('body').on('click', '.change-seriousness', function (e) {
            e.preventDefault();

            var topicId = $(this).data('id');
            var newSeriousness = $(this).data('value');

            if (confirm('Are you sure you want to change seriousness to ' + newSeriousness + '?')) {
                var form = $('#seriousnessForm-' + topicId);
                form.find('.seriousness-value').val(newSeriousness);
                form[0].submit();
            }
        });


    })

</script>