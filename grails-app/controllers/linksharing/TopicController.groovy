package linksharing

import grails.converters.JSON

class TopicController {
    TopicService topicService
    SubscribeService subscribeService
    //bean injection: bean is a application specific instance of service

    def index() {
        Topic topic = Topic.get(params.id)

        if (!topic) {
            flash.error = "Topic not found"
            redirect(controller: 'dashboard', action: 'index')
            return
        }

        List<User> subscribedUsers = topic.subscriptions*.user.unique()

        def resources = topic.resources?.toList() ?: []

        def topicNames = Topic.list()*.name

        [topic: topic, subscribedUsers: subscribedUsers, resources: resources, topicNames: topicNames]

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
        redirect(uri: request.getHeader("referer"))
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
//        redirect(controller: 'dashboard', action: 'index')

        redirect(uri: request.getHeader("referer"))
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

    def updateName() {
        try {
            def result = topicService.updateName(
                    params.long('id'),
                    params.topicName?.toString()
            )

            render([success: result.success, message: result.message] as JSON)
        } catch (Exception e) {
            log.error("Error in updateName", e)
            render([success: false, message: "Server error occurred"] as JSON)
        }
    }
}