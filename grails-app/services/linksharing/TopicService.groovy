package linksharing
import linksharing.Topic
import grails.gorm.transactions.Transactional

@Transactional
class TopicService {

    SubscribeService subscribeService

    def createTopic(params, User user) {
        if (!params.name) {
            println("Topic name not defined.")
            return "Topic name cannot be blank."
        }

        if (Topic.findByUserAndName(user, params.name)) {
            return "You already have a topic with the name '${params.name}'."
        }

        def visibility = Topic.Visibility.valueOf(params.visibility.toUpperCase())

        def topic = new Topic(name: params.name, visibility: visibility, user: user)

        if (topic.save(flush: true)) {
            subscribeService.createSubscription(user, topic, Subscription.Seriousness.VERY_SERIOUS)
            return topic
        } else {
            topic.errors.allErrors.each {
                println "Validation error: ${it}"
            }
            return topic.errors.allErrors.collect { it.defaultMessage }.join(', ')
        }
    }
}