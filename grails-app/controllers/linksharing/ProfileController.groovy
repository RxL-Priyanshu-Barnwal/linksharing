package linksharing


class ProfileController {

    def index() {
        render(view: "editProfile", model: [user: session.user])
    }

    def userProfile() { }


}