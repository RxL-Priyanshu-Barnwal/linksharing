package linksharing

class ProfileController {

    ProfileService profileService

    def editProfile() {
        def currentUser = session.user

        def user = User.get(currentUser?.id)

        if(user.username == "adminuser") {
            redirect(controller: 'profile', action: 'userProfile', params: [id: user.id])
        }

        def subscribedTopics = Subscription.findAllByUser(currentUser, [sort: 'dateCreated', order: 'desc'])

        def topicNames = Topic.list()*.name

        List<Topic> topics = user.topics?.toList() ?: []

        [user: user, topicNames: topicNames, topics: topics, subscribedTopics: subscribedTopics]
    }

    def userProfile() {
        //show all subscriptions of all users
        //show private topics and private topic resources only if session.user is viewing own profile or session.user.admin
        def user = User.get(params.id as Long)

        def topicNames = Topic.list()*.name

        List<Resource> resources = user?.resources?.toList() ?: []

        List<Topic> topics = user?.topics?.toList() ?: []

        def subscribedTopics = Subscription.findAllByUser(user, [sort: 'dateCreated', order: 'desc'])

        [user: user, topicNames: topicNames, resources: resources, topics: topics, subscribedTopics: subscribedTopics]
    }

    def updateDetails() {
        Long userId = session.user.id
        def res = profileService.updateDetails(params, userId)

        if(res) {
            flash.message = "Details updated successfully"
        }
        else {
            flash.message = "Cannot update details."
        }

        redirect(controller: 'profile', action: 'editProfile')
    }

    def updatePassword() {
        Long userId = session.user.id

        def res = profileService.updatePassword(params, userId)

        flash.message1 = res.message

        redirect(controller: 'profile', action: 'editProfile')
    }
}