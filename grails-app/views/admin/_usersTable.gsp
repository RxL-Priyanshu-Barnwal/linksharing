<table class="table table-bordered table-hover text-light custom-table" id="userTable">
    <thead class="table-dark">
    <tr style="font-size: 1.3em; text-transform: uppercase; background-color: #1C1F24">

        <th onclick="sortTable(0)" style="cursor:pointer;">
            ID <i class="bi bi-arrow-down-up ms-1"></i>
        </th>
        <th onclick="sortTable(1)" style="cursor:pointer;">
            Username <i class="bi bi-arrow-down-up"></i>
        </th>
        <th>Email</th>
        <th onclick="sortTable(3)" style="cursor:pointer;">
            First Name <i class="bi bi-arrow-down-up"></i>
        </th>
        <th onclick="sortTable(4)" style="cursor:pointer;">
            Last Name <i class="bi bi-arrow-down-up"></i>
        </th>
        <th>Active</th>
        <th>Manage</th>
        <th>Admin</th>

    </tr>
    </thead>
    <tbody class="table-dark">
    <g:if test="${users}">
        <g:each in="${users}" var="user">
            <tr style="font-size: 1em">
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td>${user.firstName}</td>
                <td>${user.lastName ?: '-'}</td>
                <td>${user.active ? 'Yes' : 'No'}</td>
                <td>
                    <g:form controller="admin" action="toggleUserStatus" method="post">
                        <input type="hidden" name="id" value="${user.id}" />

                        <g:if test="${!user.admin && !(session.user.id == user.id)}">
                            <button type="submit" class="btn btn-sm ${user.active ? 'btn-danger' : 'btn-success'}">
                                ${user.active ? 'Deactivate' : 'Activate'}
                            </button>
                        </g:if>

                    </g:form>
                </td>
                <td>
                    <g:form controller="admin" action="toggleAdminStatus" method="post">
                        <input type="hidden" name="id" value="${user.id}" />
                        <div class="form-check d-flex justify-content-center">
                            <g:checkBox
                                    name="admin"
                                    value="true"
                                    checked="${user.admin}"
                                    onchange="this.form.submit();"
                                    disabled="${(user.username == "adminuser") || (user.id == session.user.id)}" />
                        </div>
                    </g:form>
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
    let sortDirections = [true, true, true, true, true]; // true = asc, false = desc

    function sortTable(n) {
        const table = document.getElementById("userTable");
        const tbody = table.tBodies[0];
        const rows = Array.from(tbody.rows);
        const isNumeric = n === 0; // Only ID column is numeric
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
                return (x - y) * direction;
            } else {
                return x.localeCompare(y) * direction;
            }
        });

        // Re-append sorted rows
        rows.forEach(row => tbody.appendChild(row));
    }
</script>