<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <g:link uri="/dashboard" class="navbar-brand p-3" style="font-size: 2rem">Resource Sharing</g:link>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">

            <div class="navbar-nav ms-auto align-items-center d-flex" style="gap: 1.5rem;">

                <g:form controller="search" action="index" class="d-flex" style="flex-grow: 1; max-width: 400px;">
                    <input class="form-control rounded-pill bg-secondary text-white border-0" type="search" name="query" placeholder="Search" aria-label="Search" style="width: 400px;" required>
                </g:form>

                <ul class="icon-container text-white">

                    <li class="nav-item">
                        <button class="icon-button" data-bs-toggle="modal" data-bs-target="#createTopic">
                            <i class="bi bi-patch-plus"></i>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="icon-button" data-bs-toggle="modal" data-bs-target="#sendInvite">
                            <i class="bi bi-envelope"></i>
                        </button>
                    </li>

                    <li class="nav-item">
                        <button class="icon-button" data-bs-toggle="modal" data-bs-target="#createLinkResource">
                            <i class="bi bi-link-45deg"></i>
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="icon-button" data-bs-toggle="modal" data-bs-target="#createDocResource">
                            <i class="bi bi-file-earmark-text"></i>
                        </button>
                    </li>

                </ul>

                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle profile-name " href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="profile-container">
                            <g:if test="${session.user?.photo}">
                                <img src="${createLink(controller: 'auth', action: 'renderImage', params: [id: session.user.id])}" alt="${session.user.firstName}" class="profile-pic">
                            </g:if>
                            ${session.user.firstName} ${session.user.lastName}
                        </div>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li>
                            <g:link controller="profile" action="userProfile" params="[id: session.user.id]" class="dropdown-item text-white">
                                <i class="bi bi-person"></i> Profile
                            </g:link>
                        </li>

                        <g:if test="${session.user?.admin}">

                            <li><g:link class="dropdown-item" controller="admin" action="users"><i class="bi bi-people"></i> Users </g:link></li>
                            <li><g:link class="dropdown-item" controller="admin" action="topics"><i class="bi bi-tags"></i> Topics</g:link></li>
                            <li><g:link class="dropdown-item" controller="admin" action="resources"><i class="bi bi-chat-left-text"></i> Resources</g:link></li>

                        </g:if>

                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <g:link controller="auth" action="logout" class="dropdown-item">
                                <i class="bi bi-box-arrow-right"></i> Logout
                            </g:link>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<style>
    body {
        background-color: #2C3238;
    }
    .navbar {
        display: flex;
        justify-content: space-evenly;
        background-color: #1C1F24;
        color: white;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
    }

    .navbar-brand, .nav-link, .profile-name {
        color: white !important;
    }

    .navbar-brand {
        margin-right: 1rem;
    }

    .profile-pic {
        width: 30px;
        height: 30px;
        border-radius: 50%;
        object-fit: cover;
        margin-right: 8px;
    }

    .dropdown-menu {
        background-color: #343a40;
    }

    .dropdown-item {
        color: white;
    }

    .dropdown-item:hover {
        background-color: #495057;
    }

    .icon-button {
        color: white;
        margin-right: 10px;
        font-size: 1.75rem;
        padding: 10px;
        background: none;
        border: none;
    }

    .icon-container {
        display: flex;
        justify-content: space-evenly;
        align-items: center;
        width: 60%;
        margin-left: 5rem;
    }

    .profile-container{
        display: flex;
        align-items: center;
    }

    ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
    }

</style>