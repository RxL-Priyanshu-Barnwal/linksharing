package linksharing

class ProfileController {

    def index() {
        def currentUser = session.user

        def user = User.get(currentUser?.id)

        println("Session user: ${session.user}")
        render(view: "editProfile", model: [user: user])
    }

    def userProfile() { }
}