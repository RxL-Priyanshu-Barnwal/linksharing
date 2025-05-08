package linksharing
import grails.gorm.transactions.Transactional

@Transactional
class SubscribeService {

    def createSubscription = { User user, Topic topic, Subscription.Seriousness seriousness ->
        if (!Subscription.findByUserAndTopic(user, topic)) {
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

    def removeSubscription(Long topicId, Long userId) {
        Topic topic = Topic.get(topicId)
        User user = User.get(userId)

        if(!topic || !user) {
            println("Invalid topic or user.")
            throw new IllegalArgumentException("Invalid topic or user.")
        }

        def subscription = Subscription.findByUserAndTopic(user, topic)

        if(subscription) {
            subscription.delete(flush: true)
        }
        else {
            println("Subscription not found.")
            throw new IllegalStateException("Subscription not found")
        }
    }


}