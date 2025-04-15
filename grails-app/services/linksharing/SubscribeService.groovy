package linksharing
import grails.gorm.transactions.Transactional

@Transactional
class SubscribeService {

    def createSubscription(User user, Topic topic, Subscription.Seriousness seriousness) {

        if(!Subscription.findByUserAndTopic(user, topic)) {
            new Subscription(user: user, topic: topic, seriousness: seriousness).save(flush: true)
        }
    }
}