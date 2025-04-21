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

        def trendingTopics = topicService.getTrendingTopics()

        def topicNames = Topic.list()*.name

        [user: user, subscribedTopics: subscribedTopics, readingItems: readingItems, trendingTopics: trendingTopics, dashboard: true, topicNames: topicNames]
    }


    def deleteTopic() {
        println("Topic delete id is ${params.id}")

        Long id = params.id as Long
        Topic topic = Topic.get(id)

        if(!request.xhr) {
            render status: 400, text: "Bad Request"
            return
        }

        try {
            topicService.deleteTopic(topic)
            render status: 200, text: "Topic Deleted"
        }
        catch (Exception e) {
            println("Failed to delete topic")
            log.error("Failed to delete topic", e)
            render status: 500, text: "Error deleting topic"
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
            flash.error = "Error updating visibility: ${e.message}"
        }

        redirect(action: "index")
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
            flash.error = "Error updating seriousness: ${e.message}"
        }

        redirect(action: "index")
    }


}