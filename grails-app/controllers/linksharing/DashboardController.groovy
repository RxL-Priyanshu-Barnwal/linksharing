package linksharing

class DashboardController {

    TopicService topicService

    def index() {
        def currentUser = session.user

        def user = User.get(currentUser?.id)

        def subscribedTopics = Subscription.findAllByUser(session.user, [sort: 'dateCreated', order: 'desc'])

        def trendingTopics = topicService.getTrendingTopics()

        println "Trending Topics are: ${trendingTopics}"

        [user: user, subscribedTopics: subscribedTopics, dashboard: true, trendingTopics: trendingTopics]
    }

    def updateTopicName(Long id, String name) {
        if (!request.xhr) {
            render status: 400, text: "Bad Request"
            return
        }

        try {
            topicService.updateTopicName(id, name)
            render status: 200, text: "OK"
        } catch (Exception e) {
            log.error("Error updating topic name", e)
            render status: 500, text: "Internal Server Error"
        }
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

}