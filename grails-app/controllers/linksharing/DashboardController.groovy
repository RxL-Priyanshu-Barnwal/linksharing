package linksharing

class DashboardController {

    TopicService topicService
    SubscribeService subscribeService

    def index() {
        def currentUser = session.user

        def user = User.get(currentUser?.id)

        def subscribedTopics = Subscription.findAllByUser(session.user, [sort: 'dateCreated', order: 'desc'])

        def readingItems = ReadingItem.createCriteria().list {
            eq("user", currentUser)
            eq("isRead", false)
            resource {
                order("dateCreated", "desc")
            }
        }

//        def readingItems = ReadingItem.findAllByUserAndIsRead(currentUser, false, )

        def trendingTopics = topicService.getTrendingTopics()

        def topicNames = Topic.list()*.name

        def publicTopics = Topic.createCriteria().list {
            eq('visibility', Topic.Visibility.PUBLIC)
            order('name', 'asc')
        }

        def pt = Topic.findAllByVisibility(Topic.Visibility.PUBLIC)

        def createdTopics = Topic.findAllByUser(user, [sort: 'name', order: 'asc'])

        [user: user, subscribedTopics: subscribedTopics, readingItems: readingItems, trendingTopics: trendingTopics, topicNames: topicNames, publicTopics: publicTopics, createdTopics: createdTopics]
    }

    def deleteTopic() {
        Long id = params.id as Long
        Topic topic = Topic.get(id)

        println ("Topic name is: ${topic.name}")

        try {
            println "Trying to delete topic."

            topicService.deleteTopic(topic)

            println "Topic deleted."

            if (request.xhr) {
                render status: 200, text: "Topic Deleted"
            } else {
                flash.message = "Topic deleted successfully"
                redirect(controller: 'dashboard', action: 'index')
            }

        } catch (Exception e) {
            println "Error message:: ${e.message}"
            log.error("Failed to delete topic", e)

            if (request.xhr) {
                render status: 500, text: "Error deleting topic"
            } else {
                flash.message = "Error deleting topic"
                redirect(uri: request.getHeader("referer"))
            }
        }
    }

    def updateVisibility() {
        Long topicId = params.id as Long
        String newVisibility = params.visibility?.toUpperCase()

        try {
            topicService.updateVisibility(topicId, newVisibility)
            flash.message = "Visibility updated successfully."
        }
        catch (Exception e) {
            flash.message = "Error updating visibility: ${e.message}"
        }

        redirect(uri: request.getHeader("referer"))
    }

    def updateSeriousness() {
        println(params)

        String newSeriousness = params.seriousness?.toUpperCase()
        Long topicId = params.id as Long

        try {
            subscribeService.updateSeriousness(topicId, newSeriousness, session.user)
            flash.message = "Seriousness updated successfully."
        }
        catch (Exception e) {
            flash.message = "Error updating seriousness: ${e.message}"
        }

        redirect(uri: request.getHeader("referer"))
    }
}