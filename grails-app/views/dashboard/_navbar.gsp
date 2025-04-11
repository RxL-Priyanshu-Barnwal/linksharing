
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <g:link uri="/dashboard" class="navbar-brand p-3" style="font-size: 2rem">Link Sharing</g:link>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">

            <div class="navbar-nav ms-auto align-items-center d-flex" style="gap: 1.5rem;">
                <!--                <div class="nav-item col-4">-->
                <form class="d-flex" style="flex-grow: 1; max-width: 400px;">
                    <input class="form-control rounded-pill bg-secondary text-white border-0" type="search" placeholder="Search" aria-label="Search" style="width: 400px;">
                </form>

                <!--                </div>-->

                <ul class="icon-container text-white">
                    <li class="nav-item">
                        <a href="#" class="icon-button"><i class="bi bi-pencil-square"></i></a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="icon-button"><i class="bi bi-envelope"></i></a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="icon-button"><i class="bi bi-link-45deg"></i></a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="icon-button"><i class="bi bi-file-earmark-text"></i></a>
                    </li>
                </ul>

                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle profile-name " href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="profile-container">
                            <img src="" alt="Profile" class="profile-pic">
                            John Doe
                        </div>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item text-white" href="#"><i class="bi bi-person"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-people"></i> Users</a></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-tags"></i> Topic</a></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-chat-left-text"></i> Posts</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
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
    }

    .icon-container {
        display: flex;
        justify-content: space-evenly;
        align-items: center;
        width: 60%;
        margin-left: 5rem;
    }

    .icon-button {
        font-size: 1.75rem;
        padding: 10px;
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