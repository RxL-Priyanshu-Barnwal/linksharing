<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resource</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body {
            background-color: #101214;
            overflow-y: auto
        }

        /* Card Styles */
        .custom-card {
            background-color: #212529 !important; /* Use !important to override Bootstrap */
            color: #f8f9fa;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
        }

        .custom-card .card-header {
            background-color: #1C1F24 !important;
            color: #f8f9fa;
            border-bottom: 1px solid #343a40;
        }

        /* Profile Picture Styling */
        .profile-pic {
            width: 50px;
            height: 50px;
            object-fit: cover; /* Ensures the image covers the area without distortion */
            border-radius: 50%; /* Makes it circular */
            flex-shrink: 0; /* Prevents image from shrinking */
        }

        /* Ensure content next to profile pic takes remaining space */
        .profile-content {
            flex-grow: 1;
            min-width: 0; /* Prevents content overflow issues in flex item */
        }


        /* Style for individual posts within subscription card */
        .subscription-post {
            border-bottom: 1px solid #343a40; /* Separator line */
            padding-bottom: 1rem;
            margin-bottom: 1rem;
        }
        .subscription-post:last-child {
            border-bottom: none; /* Remove border for the last item */
            margin-bottom: 0;
            padding-bottom: 0;
        }

    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>

<div class="navigation-bar">
    <g:render template="/navbar"/>
</div>

<div class="modals">
    <g:render template="/modals" model="topicNames: topicNames"/>
</div>

<div class="container-fluid " style="padding: 3rem;">
    <div class="row gx-5">

        <div class="col-md-8 px-5">


            <g:if test="resource">

                <div class="card custom-card mt-5">
                    <div class="card-body">
                        <div class="row align-items-center mb-2">
                            <div class="col-auto">
                                <g:if test="${resource?.user?.photo}">
                                    <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: resource.user.id])}" alt="${resource.user.firstName}" class="rounded-circle" style="width: 30px; height: 30px; object-fit: cover;">
                                </g:if>
                            </div>
                            <div class="col">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span class="fw-bold">${resource?.user?.firstName} ${resource?.user?.lastName}</span>
                                    </div>
                                    <div>
                                        <g:link controller="topic" action="index" params="[id: resource?.topic?.id]" style="color: inherit; text-decoration: none;">
                                            <span class="secondary">Topic: ${resource?.topic?.name}</span>
                                        </g:link>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row align-items-center mb-2">
                            <div class="col">
                                <span class="text-secondary">${resource?.user?.username}</span>
                            </div>
                            <div class="col-auto">
                                <span class="text-secondary">${resource?.dateCreated}</span>
                            </div>
                        </div>
                        <div class="m-4">
                            ${resource?.description}
                        </div>
                        <div class="d-flex justify-content-between align-items-center">

                            <div class="star-rating" id="resource-${resource?.id}-rating" data-resource-id="${resource?.id}" data-user-rating="${userRating}">
                                <span class="star" data-value="1">★</span>
                                <span class="star" data-value="2">★</span>
                                <span class="star" data-value="3">★</span>
                                <span class="star" data-value="4">★</span>
                                <span class="star" data-value="5">★</span>
                            </div>


                            <div class="p-1">

                                <g:if test="${resource?.user?.id == session.user?.id || session.user?.admin}">
                                    <g:link controller="resource" action="deleteResource" id="${resource?.id}" class="btn btn-sm btn-outline-danger ms-2" onclick="return confirm('Are you sure you want to delete this resource?')">Delete</g:link>
                                </g:if>

                                <g:if test="${resource instanceof linksharing.DocumentResource}">
                                    <g:link controller="resource" action="download" params="[id: resource.id]" class="btn btn-sm btn-outline-primary ms-2">Download</g:link>
                                </g:if>

                                <g:if test="${resource instanceof linksharing.LinkResource}">
                                    <a href="${resource.url}" target="_blank" class="btn btn-sm btn-outline-secondary ms-2">View Full Site</a>
                                </g:if>

                            </div>
                        </div>
                    </div>
                </div>

            </g:if>


        </div>

    </div>
</div>


<script>
    $(document).ready(function() {

        // Function to initialize the star rating based on existing rating
        $('.star-rating').each(function() {
            var userRating = $(this).data('user-rating');
            if (userRating) {
                $(this).find('.star').each(function() {
                    if ($(this).data('value') <= userRating) {
                        $(this).addClass('selected');
                    }
                });
            }
        });

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
                $('#visibilityTopicId-' + topicId).val(topicId);
                $('.visibilityValue').val(newVisibility);

                // Submit the form
                $('#visibilityForm-' + topicId)[0].submit();
            }
        });

        $('body').on('click', '.change-seriousness', function (e) {
            e.preventDefault();

            var topicId = $(this).data('id');
            var newSeriousness = $(this).data('value');

            if (confirm('Are you sure you want to change visibility to ' + newSeriousness + '?')) {
                // Set values in the hidden form
                $('#seriousnessTopicId-' + topicId).val(topicId);
                $('.seriousnessValue').val(newSeriousness);

                // Submit the form
                $('#seriousnessForm-' + topicId)[0].submit();
            }
        });

        let currentlyEditingTopicId = null; // To track which topic is being edited

        $('body').on('click', '.edit-topic-inline-btn', function() {
            const topicId = $(this).data('topic-id');
            currentlyEditingTopicId = topicId; // Set the ID of the topic being edited
            const $row = $(this).closest('.row');
            const $container = $row.find('.card-title');
            const $input = $container.find('.topic-name-input[data-topic-id="' + topicId + '"]');
            const $display = $container.find('.topic-name-display[data-topic-id="' + topicId + '"]');

            $display.addClass('d-none');
            $input.removeClass('d-none').focus().select();
        });

        // Save when clicking outside the input field
        $(document).on('click', function(event) {
            if (currentlyEditingTopicId !== null) {
                const $target = $(event.target);
                const $editInput = $('.topic-name-input[data-topic-id="' + currentlyEditingTopicId + '"]');

                // Check if the click was outside the input field and the edit button
                if (!$target.is($editInput) && !$target.closest('.edit-topic-inline-btn[data-topic-id="' + currentlyEditingTopicId + '"]').length) {
                    const topicId = currentlyEditingTopicId;
                    const newName = $editInput.val();

                    // Reset the currently editing ID
                    currentlyEditingTopicId = null;

                    $.ajax({
                        url: '/topic/updateName',
                        type: 'POST',
                        data: { id: topicId, topicName: newName },
                        success: function(response) {
                            if (response.success) {
                                $('.topic-name-display[data-topic-id="' + topicId + '"]')
                                    .text(newName)
                                    .removeClass('d-none');
                                $editInput.addClass('d-none');
                                $('.trending-topic-name-display[data-trending-topic-id="' + topicId + '"]')
                                    .text(newName);
                            } else {
                                alert(response.message || 'Update failed.');
                                $('.topic-name-display[data-topic-id="' + topicId + '"]').removeClass('d-none');
                                $editInput.addClass('d-none');
                            }
                        },
                        error: function() {
                            alert('Something went wrong while updating the topic.');
                        }
                    });
                }
            }
        });

        // Prevent immediate blur when clicking the edit button itself
        $('body').on('mousedown', '.edit-topic-inline-btn', function(event) {
            event.preventDefault(); // Prevent the document click from firing immediately
        });


        // --- Hover Handling ---
        $('.star-rating .star').on('mouseenter', function() {
            var ratingContainer = $(this).closest('.star-rating');
            var hoverValue = $(this).data('value');

            // Add 'hovered' class to stars up to the one hovered over
            ratingContainer.find('.star').each(function() {
                if ($(this).data('value') <= hoverValue) {
                    $(this).addClass('hovered');
                } else {
                    $(this).removeClass('hovered'); // Ensure stars after are not hovered
                }
            });
        });

        // Reset hover effect when mouse leaves the rating container
        $('.star-rating').on('mouseleave', function() {
            $(this).find('.star').removeClass('hovered');
        });

        // --- Click Handling ---
        $('.star-rating .star').on('click', function() {
            var ratingContainer = $(this).closest('.star-rating');
            var score = $(this).data('value'); // Get the integer value (1-5) [3]
            var resourceId = ratingContainer.data('resource-id');

            console.log('Clicked star:', score, 'for resource:', resourceId);

            // 1. Update Visual State (Lock the rating)
            ratingContainer.find('.star').removeClass('selected hovered'); // Clear previous selection and hover state
            ratingContainer.find('.star').each(function() {
                if ($(this).data('value') <= score) {
                    $(this).addClass('selected'); // Apply selected class up to the clicked star [4]
                }
            });

            // 2. Prepare data for the controller
            var ratingData = {
                resourceId: resourceId,
                score: score // The integer 1-5 based on the clicked star
                // user.id should be handled server-side via session
            };

            // 3. Send data via AJAX to your Grails Controller
            $.ajax({
                type: 'POST',
                url: '/resource/rating', // *** CHANGE TO YOUR CONTROLLER URL ***
                data: ratingData,
                success: function(response) {
                    console.log('Rating saved successfully:', response);
                    // Add user feedback (e.g., temporary message, disable stars)
                    // ratingContainer.off('mouseenter mouseleave click'); // Optionally disable after rating
                    // ratingContainer.css('cursor', 'default');
                },
                error: function(xhr, status, error) {
                    console.error('Error saving rating:', error);
                    // Add error feedback (e.g., alert, restore previous state)
                    alert('Failed to save rating. Please try again.');
                    // Potentially revert the stars to their previous state here
                }
            });
        });


    });

</script>


<style>

    /* Container for inline stars */
    .star-rating {
        display: inline-block; /* Or flex for more control */
        font-size: 2em; /* Adjust size as needed */
        cursor: pointer;
    }

    /* Individual star styling */
    .star-rating .star {
        color: #ccc; /* Default color (light grey instead of white for visibility) */
        transition: color 0.2s ease-in-out; /* Smooth color transition */
        margin-right: 2px; /* Spacing between stars */
    }

    /* Hover effect: Color the hovered star and all previous stars yellow */
    .star-rating:hover .star {
        color: #ccc; /* Reset all stars first on container hover */
    }
    .star-rating .star:hover,
    .star-rating .star:hover ~ .star {
        /* Stars after the hovered one stay grey */
    }
    .star-rating .star:hover,
        /* Selects the hovered star AND stars before it using JS (simpler than complex CSS selectors) */
    .star-rating .star.hovered {
        color: #ffcc00; /* Yellow color on hover */
    }


    /* Selected state: Keep stars yellow up to the selected one */
    .star-rating .star.selected {
        color: #ffcc00; /* Yellow color for selected stars */
    }



</style>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>