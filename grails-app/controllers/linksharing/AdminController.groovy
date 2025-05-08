package linksharing

class AdminController {

    AdminService adminService
    ResourceService resourceService

    def users() {

        if(!session.user?.admin) {
            println("Unauthorized access.")
            flash.message = "Unauthorized access."
            redirect(uri: request.getHeader("referer") ?: "/")
            return
        }
        def topicNames = Topic.list()*.name
        def users = User.list()

        [users: users, topicNames: topicNames]
    }

    def toggleUserStatus() {
        //params is user.id
        Long userId = params.id as Long

        def res = adminService.toggleUserStatus(userId)
        if(res) {
            println "User status updated"
        }
        else {
            println "Error updating user status"
        }
        redirect(uri: request.getHeader("referer"))
    }

    def toggleAdminStatus() {
        Long userId = params.id as Long

        def res = adminService.toggleAdminStatus(userId)

        if(res) {
            println "User was made admin."
        }
        else {
            println "Cannot create user as admin."
        }

        redirect(uri: request.getHeader("referer"))
    }

    def topics() {
        if(!session.user?.admin) {
            println("Unauthorized access.")
            flash.message = "Unauthorized access."
            redirect(uri: request.getHeader("referer") ?: "/")
            return
        }

        def topicNames = Topic.list()*.name

        def topics = Topic.list()

        [topics: topics, topicNames: topicNames]
    }

    def resources() {
        if(!session.user?.admin) {
            println("Unauthorized access.")
            flash.message = "Unauthorized access."
            redirect(uri: request.getHeader("referer") ?: "/")
            return
        }
        def resources = Resource.list()

        def topicNames = Topic.list()*.name

        def resourceWithRating = resourceService.getResourcesWithRating()

        [topicNames: topicNames, resources: resourceWithRating]
    }
}




