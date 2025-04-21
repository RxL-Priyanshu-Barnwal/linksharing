package linksharing

class ProfileController {

    def index() {
        def currentUser = session.user

        def user = User.get(currentUser?.id)

        def subscribedTopics = Subscription.findAllByUser(currentUser, [sort: 'dateCreated', order: 'desc'])

        def topicNames = Topic.list()*.name

        render(view: "editProfile", model: [user: user, subscribedTopics: subscribedTopics, topicNames: topicNames])
    }

    def userProfile() { }
}