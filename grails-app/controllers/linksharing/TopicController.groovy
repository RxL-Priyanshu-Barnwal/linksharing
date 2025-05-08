package linksharing

import grails.converters.JSON
import groovy.time.TimeCategory
import net.bytebuddy.description.modifier.Visibility

class TopicController {
    TopicService topicService
    SubscribeService subscribeService
    def mailService
    //bean injection: bean is a application specific instance of service

    def index() {
        Topic topic = Topic.get(params.id)

        if (!topic) {
            flash.message = "Topic not found"
            redirect(controller: 'dashboard', action: 'index')
            return
        }

        if(topic.visibility.PRIVATE) {
            // admin, creator, subscriber
            User user = session.user

            boolean isAllowed = user && (user.admin || topic.subscriptions.any{it.user.id == user.id })

            if(!isAllowed) {
                flash.message = "You don't have permission to view this private topic"
                println(request.getHeader("referer"))
                redirect(uri: request.getHeader("referer"))
                return
             }
        }

        List<User> subscribedUsers = topic.subscriptions*.user.unique()

        def resources = topic.resources?.toList() ?: []

        def subscribedTopics = Subscription.findAllByUser(session.user, [sort: 'dateCreated', order: 'desc'])

        def topicNames = Topic.list()*.name

        [topic: topic, subscribedUsers: subscribedUsers, resources: resources, topicNames: topicNames, subscribedTopics: subscribedTopics]

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

    def sendInvite() {
        String invitedEmail = params.invitedEmail
        String topicName = params.topic

        if(!invitedEmail || !topicName) {
            flash.message = "Email and topic are required."
            redirect(uri: request.getHeader("referer") ?: "/")
            return
        }

        Topic topic = Topic.findByName(topicName)
        println ("${topic}")

        if(topic) {
            InviteToken invitation = topicService.generateInviteToken(invitedEmail, topic)
            String inviteLink = "http://localhost:8080/auth/acceptInvite?token=${invitation.token}"
            mailService.sendMail {
                to invitation.invitedEmail
                subject "Invitation to subscribe to ${topicName}"
                html """
                    <p>You've been invited to join the topic <strong>${topicName}</strong>.</p>
                    <p>Click the link below to accept the invitation:</p>
                    <p><a href="${inviteLink}">${inviteLink}</a></p>
                    <p>This link is valid for 1 hour.</p>
                """
            }
            println "Invite Mail sent"
            redirect(uri: request.getHeader("referer") ?: "/")
        }
        else {
            flash.message = "Topic does not exist."
            redirect(uri: request.getHeader("referer") ?: "/")
            return
        }
    }
}