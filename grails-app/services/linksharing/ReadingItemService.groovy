package linksharing
import grails.gorm.transactions.Transactional

@Transactional
class ReadingItemService {

    def createReadingItem(Resource resource, User user) { //user will be the creator
        def subscribers = Subscription.findAllByTopic(resource.topic)*.user.findAll { it.id != user.id}

        def readingItems = []

        subscribers.each {
            readingItems << new ReadingItem(resource: resource, user: it, isRead: false)
        }

        ReadingItem.saveAll(readingItems)
    }

    def markAsRead(Long id, User user) {
        ReadingItem item = ReadingItem.findByIdAndUser(id, user)

        if(item && !item.isRead) {
            item.isRead = true
            item.save(flush: true)
            return true
        }

        return false
    }

}