package linksharing
import grails.gorm.transactions.Transactional

@Transactional
class SubscribeService {

    def createSubscription(User user, Topic topic, Subscription.Seriousness seriousness) {

        if(!Subscription.findByUserAndTopic(user, topic)) {
            new Subscription(user: user, topic: topic, seriousness: seriousness).save(flush: true)
        }
    }

    def updateSeriousness(Long topicId, String newSeriousness, User user) {

        try {
            Subscription subscription = Subscription.findByTopicAndUser(Topic.get(topicId), user)
            subscription.seriousness = Subscription.Seriousness.valueOf(newSeriousness)
            subscription.save(flush: true, failOnError: true)
            return subscription
        }
        catch (Exception e) {
            println("Seriousness cannot be changed: $e.message")
        }
    }

    def removeSubscription(User user, Topic topic) {

    }
}