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
        Topic.createCriteria().list(max: 3) {
            eq('visibility', Topic.Visibility.PUBLIC)
            projections {
                groupProperty('id')
                count('resources', 'resourceCount')
            }
            order('resourceCount', 'desc')
        }?.collect { result ->
            Topic.get(result[0]) // Fetch full Topic by its ID
        }
    }

    def updateTopicName(Long id, String name) {
        def topic = Topic.get(id)
        if(topic) {
            topic.name = name
            topic.save(flush: true, failOnError: true)
        }
        else {
            throw new Exception("Topic not found")
        }
    }

    def deleteTopic(Topic topic) {
        if(!topic) {
            println("Topic not found")
            throw new Exception("Topic not found")
        }

        topic.delete(flush: true, failOnError: true)
    }
}