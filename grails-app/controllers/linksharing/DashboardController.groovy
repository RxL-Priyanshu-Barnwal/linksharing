package linksharing
class DashboardController {

    def index() {

        def currentUser = session.user

        def user = User.get(currentUser?.id)

        def subscribedTopics = Subscription.findAllByUser(session.user, [sort: 'dateCreated', order: 'desc'])

        [user: user, subscribedTopics: subscribedTopics, dashboard: true]
    }

}