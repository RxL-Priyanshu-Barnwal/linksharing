package linksharing

class ProfileController {

    def editProfile() {
        def currentUser = session.user

        def user = User.get(currentUser?.id)

        def subscribedTopics = Subscription.findAllByUser(currentUser, [sort: 'dateCreated', order: 'desc'])

        def topicNames = Topic.list()*.name

        List<Topic> topics = user.topics?.toList() ?: []

        [user: user, subscribedTopics: subscribedTopics, topicNames: topicNames, topics: topics]
    }

    def userProfile() {
        //show all subscriptions of all users
        //show private topics and private topic resources only if session.user is viewing own profile or session.user.admin
        def user = User.get(params.id as Long)

        def topicNames = Topic.list()*.name

        List<Resource> resources = user.resources?.toList() ?: []

        List<Topic> topics = user.topics?.toList() ?: []

        def subscribedTopics = Subscription.findAllByUser(user, [sort: 'dateCreated', order: 'desc'])

        [user: user, topicNames: topicNames, resources: resources, topics: topics, subscribedTopics: subscribedTopics]
    }

    def renderImage(Long id) {
        User user = User.get(id)
        if(user?.photo) {
            response.contentType = 'image/jpeg'
            response.outputStream << user.photo
            response.outputStream.flush()
        }
    }
}