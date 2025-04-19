package linksharing

class TopicController {
    TopicService topicService
    SubscribeService subscribeService
    //bean injection: bean is a application specific instance of service

    def index() {
        Topic topic = Topic.get(params.id)

        List<User> subscribedUsers = topic.subscriptions*.user.unique()

        def resources = topic.resources?.toList() ?: []

        [topic: topic, subscribedUsers: subscribedUsers, resources: resources]

    }

    def createTopic() {
        println(params)

        def res = topicService.createTopic(params, session.user)

        if (res instanceof Topic) {
            println("Topic '${params.name}' created successfully")
        }
        else {
            flash.topicMessage = res
            flash.showTopicModal = true
        }
        redirect(controller: 'dashboard', action: 'index')
    }

    def subscribe() {
        User user = session.user
        if (!user) {
            flash.message = "Please login to subscribe."
            redirect(controller: 'login', action: 'index')
            return
        }

        Long topicId = params.long("topicId")
        Topic topic = Topic.get(topicId)

        if (!topic) {
            flash.message = "Topic not found."
            redirect(controller: 'dashboard', action: 'index')
            return
        }

        subscribeService.createSubscription(user, topic, Subscription.Seriousness.CASUAL)

        flash.message = "Successfully subscribed to ${topic.name}."
        redirect(controller: 'dashboard', action: 'index')
    }

    def unsubscribe() {
        User user = session.user
        Long topicId = params.long('topicId')

        if(!topicId) {
            flash.message = "Topic ID is missing"
            println("Topic ID is missing")
            redirect(uri: request.getHeader("referer"))
            return
        }

        try {
            subscribeService.removeSubscription(topicId, session.user.id)
            flash.message = "Unsubscribed successfully"
            println("Unsubscribed successfully")
        }
        catch (Exception e) {
            flash.message = "Error while unsubscribing"
        }

        redirect(uri: request.getHeader("referer"))
    }
}