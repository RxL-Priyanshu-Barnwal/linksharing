package linksharing
import linksharing.Topic
import grails.gorm.transactions.Transactional

@Transactional
class TopicService {

    SubscribeService subscribeService

    def createTopic(params, User user) {

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
            return topic.errors.allErrors.collect {
                it.defaultMessage
            }.join(', ')
        }
    }

    List<Topic> getTrendingTopics() {
        Topic.executeQuery("""
        select t from Topic t
        where t.visibility = :visibility
        order by size(t.resources) desc
    """, [visibility: Topic.Visibility.PUBLIC], [max: 3])
    }

    def deleteTopic(Topic topic) {
        if(!topic) {
            println("Topic not found")
            throw new Exception("Topic not found")
        }

        topic.resources.each {
            ResourceRating.findAllByResource(it)*.delete()
            ReadingItem.findAllByResource(it)*.delete()
        }

        topic.resources*.delete()

        topic.subscriptions*.delete()

        topic.delete(flush: true, failOnError: true)
    }

    def updateVisibility(Long topicId, String newVisibility) {
        try {
            // Find the topic by ID
            Topic topic = Topic.get(topicId)
            println("Topic fetched: ${topicId}")

            if (!topic) {
                throw new Exception("Topic not found")
            }

            // Convert the string value to the enum type (PUBLIC or PRIVATE)
            topic.visibility = Topic.Visibility.valueOf(newVisibility.toUpperCase())
            topic.save(flush: true, failOnError: true)

            return topic
        } catch (Exception e) {
            println("cannot update visibility in service. Error: $e.message")
            throw new RuntimeException("Error updating visibility", e)
        }
    }

    def updateName(Long topicId, String newName) {
        Topic topic = Topic.get(topicId)

        if (!newName?.trim()) {
            return [success: false, message: "Name cannot be blank"]
        }

        if (topic.name == newName) {
            return [success: true] // No change needed
        }

        try {
            topic.name = newName.trim()
            topic.save(flush: true, failOnError: true)
            return [success: true]
        } catch (Exception e) {
            log.error("Failed to update topic name", e)
            return [success: false, message: "Name update failed: ${e.message}"]
        }
    }
}