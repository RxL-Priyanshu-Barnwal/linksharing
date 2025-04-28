<table class="table table-bordered table-hover text-light custom-table" id="resourceTable">
    <thead class="table-dark">
    <tr style="font-size: 1.3em; text-transform: uppercase; background-color: #1C1F24">

        <th onclick="sortTable(0)" style="cursor:pointer;">
            ID <i class="bi bi-arrow-down-up ms-1"></i>
        </th>

        <th>Resource</th>

        <th>Description</th>

        <th onclick="sortTable(3)" style="cursor:pointer;">
            Topic <i class="bi bi-arrow-down-up"></i>
        </th>

        <th onclick="sortTable(4)" style="cursor:pointer;">
            Created By <i class="bi bi-arrow-down-up"></i>
        </th>
        <th onclick="sortTable(5)" style="cursor:pointer;">
            Rating <i class="bi bi-arrow-down-up"></i>
        </th>

    </tr>
    </thead>

    <tbody class="table-dark">
    <g:if test="${resources}">
        <g:each in="${resources}" var="resource">
            <tr style="font-size: 1em">

                <td>
                    <g:link controller="resource" action="index" params="[id: resource.resource.id]" style="color: inherit; cursor: pointer; text-decoration: none;">
                        ${resource.resource.id}
                    </g:link>
                </td>

                <td>
                    <g:link controller="resource" action="index" params="[id: resource.resource.id]" style="color: inherit; cursor: pointer; text-decoration: none">

                        <g:if test="${resource.resource instanceof linksharing.DocumentResource}">
                            ${resource.resource.filePath}
                        </g:if>
                        <g:else>
                                ${resource.resource.url}
                        </g:else>
                    </g:link>
                </td>

                <td>
                    <g:link controller="resource" action="index" params="[id: resource.resource.id]" style="color: inherit; cursor: pointer; text-decoration: none">
                        ${resource.resource.description}
                    </g:link>
                </td>

                <td>
                    <g:link controller="topic" action="index" params="[id: resource.resource.topic.id]" style="color: inherit; text-decoration: none;">
                        ${resource.resource.topic?.name}
                    </g:link>
                </td>

                <td>${resource.resource.user.firstName} ${resource.resource.user.lastName}</td>

                <td>
<!--                Dynamically calculated average rating and number of ratings-->
                    ${resource.averageRating} <i class="bi bi-star-fill ms-2"></i> <span class="text-secondary ms-2">(${resource.resource.ratings.size()})</span>
                </td>

                <td>
<!--                    <i class="bi bi-pencil-square fs-5 ms-3 edit-resource-inline-btn" title="Edit" role="button"></i>-->

                    <i class="bi bi-trash fs-5 text-danger delete-resource ms-3" data-id="${resource.resource.id}" title="Delete" role="button"></i>
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

    // Columns sortable: 0 (ID), 3 (Topic), 4 (Created By), 5 (Rating)
    // Columns 0 and 5 are numeric, others are text

    let sortDirectionsResource = [true, false, false, true, true, true];

    function sortTable(n) {
        const table = document.getElementById("resourceTable");
        const tbody = table.tBodies[0];
        const rows = Array.from(tbody.rows);

        // Numeric columns: ID (0), Rating (5)
        const numericColumns = [0, 5];
        const isNumeric = numericColumns.includes(n);

        // Toggle sort direction
        sortDirectionsResource[n] = !sortDirectionsResource[n];
        const direction = sortDirectionsResource[n] ? 1 : -1;

        // Remove active sort classes from all headers
        const ths = table.tHead.rows[0].cells;
        for (let i = 0; i < ths.length; i++) {
            ths[i].classList.remove('active-sort-asc', 'active-sort-desc');
        }
        ths[n].classList.add(sortDirectionsResource[n] ? 'active-sort-asc' : 'active-sort-desc');

        rows.sort((a, b) => {
            let x = a.cells[n].innerText.trim();
            let y = b.cells[n].innerText.trim();
            if (isNumeric) {
                x = parseFloat(x);
                y = parseFloat(y);
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
        $('body').on('click', '.delete-resource', function () {
            var resourceId = $(this).data('id');

            console.log("resourceID from Javascript: " + resourceId);

            if (confirm('Are you sure you want to delete this resource?')) {
                $.ajax({
                    url: '/resource/deleteResource',
                    type: 'POST',
                    data: {id: resourceId},
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    success: function (response) {
                        alert(response);
                        location.reload();
                    },
                    error: function (xhr) {
                        alert('Error deleting resource: ' + xhr.responseText);
                    }
                });
            }
        });

    });

</script>