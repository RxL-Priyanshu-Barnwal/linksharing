<table class="table table-bordered table-hover text-light custom-table" id="topicTable">
    <thead class="table-dark">
    <tr style="font-size: 1.3em; text-transform: uppercase; background-color: #1C1F24">

        <th onclick="sortTable(0)" style="cursor:pointer;">
            ID <i class="bi bi-arrow-down-up ms-1"></i>
        </th>

        <th onclick="sortTable(1)" style="cursor:pointer;">
            Topic Name <i class="bi bi-arrow-down-up"></i>
        </th>

        <th onclick="sortTable(2)" style="cursor:pointer;">
            Created By <i class="bi bi-arrow-down-up"></i>
        </th>

        <th onclick="sortTable(3)" style="cursor:pointer;">
            Visibility <i class="bi bi-arrow-down-up"></i>
        </th>

        <th onclick="sortTable(4)" style="cursor:pointer;">
            Resources <i class="bi bi-arrow-down-up"></i>
        </th>
        <th onclick="sortTable(5)" style="cursor:pointer;">
            Subscriptions <i class="bi bi-arrow-down-up"></i>
        </th>

    </tr>
    </thead>

    <tbody class="table-dark">
    <g:if test="${topics}">
        <g:each in="${topics}" var="topic">
            <tr style="font-size: 1em">

                <td>${topic.id}</td>

                <td>
                    <div class="list-group-item">
                        <span class="topic-name-display" data-topic-id="${topic.id}">
                        <g:link controller="topic" action="index" params="[id: topic.id]" style="color: inherit; text-decoration: none;">
                            ${topic?.name}
                        </g:link>
                        </span>
                        <input type="text" class="form-control topic-name-input d-none" data-topic-id="${topic.id}" value="${topic?.name}" />
                    </div>
                </td>

                <td>
                    <g:link controller="topic" action="index" params="[id: topic.user.id]" style="color: inherit; text-decoration: none;">
                        ${topic.user.firstName} ${topic.user.lastName}
                    </g:link>
                </td>

                <td>
<!--                    Visibility Dropdown -->
                    <div class="dropdown">
                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            ${topic.visibility ?: 'Visibility'}
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item change-visibility" data-id="${topic.id}" data-value="PUBLIC" href="#">PUBLIC</a></li>
                            <li><a class="dropdown-item change-visibility" data-id="${topic.id}" data-value="PRIVATE" href="#">PRIVATE</a></li>
                        </ul>
                    </div>

                    <!-- Hidden form for visibility -->
                    <form id="visibilityForm-${topic.id}" method="post" action="${createLink(controller: 'dashboard', action: 'updateVisibility')}" style="display: none;">
                        <input type="hidden" name="id" value="${topic.id}" id="visibilityTopicId-${topic.id}">
                        <input type="hidden" name="visibility" class="visibility-value" id="visibilityValue-${topic.id}">
                    </form>

                </td>

                <td>${topic.resources.size()}</td>

                <td>${topic.subscriptions.size()}</td>

                <td>
                    <i class="bi bi-pencil-square fs-5 ms-3 edit-topic-inline-btn" title="Edit" role="button" data-topic-id="${topic.id}"></i>
                    <i class="bi bi-trash fs-5 text-danger delete-topic ms-3" data-id="${topic.id}" title="Delete" role="button"></i>
                </td>

            </tr>
        </g:each>
    </g:if>
    </tbody>
</table>

<style>

    /* Custom table styling */
    .custom-table {
        background-color: #212529 !important; /* Force background color */
        overflow: hidden;
    }

    /* Table header styles */
    .custom-table thead {
        background-color: #1C1F24;
        color: #f8f9fa;
    }

    /* Table header and cell borders */
    .custom-table th,
    .custom-table td {
        border-color: #343a40 !important;
        vertical-align: middle;
        padding: 20px 8px; /* Increase padding for row height */
    }

    /* Increase row height */
    .custom-table tbody tr {
        height: 40px; /* Adjust this value as needed */
    }

    /* Button styling for activate/deactivate buttons */
    .custom-table .btn-danger,
    .custom-table .btn-success {
        padding: 4px 12px;
    }

    th[onclick] {
        user-select: none;
    }
    th.active-sort-asc i {
        color: #0d6efd;
        transform: rotate(180deg);
    }
    th.active-sort-desc i {
        color: #0d6efd;
    }

</style>

<script>
    // Now 7 columns, with 6 sortable (0 to 5)
    let sortDirections = [true, true, true, true, true, true, true];

    function sortTable(n) {
        const table = document.getElementById("topicTable");
        const tbody = table.tBodies[0];
        const rows = Array.from(tbody.rows);

        // Columns 0, 4, 5 are numeric (ID, Resources, Subscriptions)
        const numericColumns = [0, 4, 5];
        const isNumeric = numericColumns.includes(n);

        // Toggle sort direction
        sortDirections[n] = !sortDirections[n];
        const direction = sortDirections[n] ? 1 : -1;

        // Remove active sort classes from all headers
        const ths = table.tHead.rows[0].cells;
        for (let i = 0; i < ths.length; i++) {
            ths[i].classList.remove('active-sort-asc', 'active-sort-desc');
        }
        ths[n].classList.add(sortDirections[n] ? 'active-sort-asc' : 'active-sort-desc');

        rows.sort((a, b) => {
            let x = a.cells[n].innerText.trim();
            let y = b.cells[n].innerText.trim();
            if (isNumeric) {
                x = parseInt(x, 10);
                y = parseInt(y, 10);
                if (isNaN(x)) x = 0;
                if (isNaN(y)) y = 0;
                return (x - y) * direction;
            } else {
                return x.localeCompare(y) * direction;
            }
        });

        // Re-append sorted rows
        rows.forEach(row => tbody.appendChild(row));
    }

    $(document).ready(function() {
        $('body').on('click', '.change-visibility', function (e) {
            e.preventDefault();

            var topicId = $(this).data('id');
            var newVisibility = $(this).data('value');

            if (confirm('Are you sure you want to change visibility to ' + newVisibility + '?')) {
                // Set values in the hidden form
                $('#visibilityTopicId-' + topicId).val(topicId);
                $('#visibilityValue-' + topicId).val(newVisibility);

                // Submit the form
                $('#visibilityForm-' + topicId)[0].submit();
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

        // Replace existing .edit-topic-inline-btn click handler with this:
        let currentlyEditingTopicId = null; // To track which topic is being edited

        // Start editing when edit button is clicked
        $('#topicTable').on('click', '.edit-topic-inline-btn', function() {
            const topicId = $(this).data('topic-id');
            currentlyEditingTopicId = topicId; // Set the ID of the topic being edited
            const $row = $(this).closest('tr');
            const $display = $row.find('.topic-name-display[data-topic-id="' + topicId + '"]');
            const $input = $row.find('.topic-name-input[data-topic-id="' + topicId + '"]');

            $display.addClass('d-none');
            $input.removeClass('d-none').focus().select();
        });

        // Save when clicking outside the input field OR when Enter is pressed
        $(document).on('click keypress', function(event) {
            if (currentlyEditingTopicId !== null) {
                const $target = $(event.target);
                const $editInput = $('.topic-name-input[data-topic-id="' + currentlyEditingTopicId + '"]');

                const isOutsideClick = !$target.is($editInput) && !$target.closest('.edit-topic-inline-btn[data-topic-id="' + currentlyEditingTopicId + '"]').length;
                const isEnterKey = event.type === 'keypress' && event.which === 13; // Enter key

                if (isOutsideClick || isEnterKey) {
                    const topicId = currentlyEditingTopicId;
                    const newName = $editInput.val();

                    // Reset the currently editing ID
                    currentlyEditingTopicId = null;

                    $.ajax({
                        url: '/topic/updateName',
                        type: 'POST',
                        data: { id: topicId, topicName: newName },
                        success: function(response) {
                            location.reload();
                        },
                        error: function() {
                            alert('Something went wrong while updating the topic.');
                        }
                    });
                }
            }
        });

        // Prevent immediate blur when clicking the edit button itself
        $('#topicTable').on('mousedown', '.edit-topic-inline-btn', function(event) {
            event.preventDefault(); // Prevent the document click from firing immediately
        });


    });

</script>
