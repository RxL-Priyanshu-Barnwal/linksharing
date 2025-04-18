package linksharing

class ProfileController {

    def index() {
        def currentUser = session.user

        def user = User.get(currentUser?.id)

        def subscribedTopics = Subscription.findAllByUser(currentUser, [sort: 'dateCreated', order: 'desc'])

        println("Session user: ${session.user}")
        render(view: "editProfile", model: [user: user, subscribedTopics: subscribedTopics])
    }

    def userProfile() { }
}