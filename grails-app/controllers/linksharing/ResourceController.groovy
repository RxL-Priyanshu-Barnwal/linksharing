package linksharing

class ResourceController {

    ResourceService resourceService
    ReadingItemService readingItemService
    TopicService topicService

    def index() {
        Long resourceId = params.id as Long

        def resource = Resource.get(resourceId)

        println("${resource.user.username} created this resource in topic: ${resource.topic.name}")

        def trendingTopics = topicService.getTrendingTopics()

        def topicNames = Topic.list()*.name

        [trendingTopics: trendingTopics, topicNames: topicNames, resource: resource]
    }

    def createLinkResource() {
        println(params)

        def res = resourceService.createLinkResource(params, session.user)

        if(res instanceof LinkResource) {
            println("Link Resource created successfully.")
        }
        else {
            flash.linkResourceMessage = res
            flash.showLinkModal = true
        }

        redirect(uri: request.getHeader("referer"))
        //Redirects to the same page user was on
    }

    def createDocResource() {
        println(params)

        def res = resourceService.createDocResource(params, session.user)

        if(res instanceof DocumentResource) {
            println("Link Resource created successfully.")
        }
        else {
            flash.docResourceMessage = res
            flash.showDocModal = true
        }

        redirect(uri: request.getHeader("referer"))
        //Redirects to the same page user was on

    }

    def markAsRead() {
        Long readingItemId = params.long("id")

        if(readingItemService.markAsRead(readingItemId, session.user)) {
            println("Marked as read successfully")
            flash.message = "Marked as read successfully."
        }
        else {
            println("Unable to mark the resource as read.")
            flash.error = "Unable to mark the resource as read."
        }
        redirect(uri: request.getHeader("referer") ?: "/dashboard/index")
    }

    def deleteResource() {
        Long resourceId = params.id as Long

        try {
            resourceService.deleteResource(resourceId)
        }
        catch(Exception e) {
            println "${e.message}"
        }
        redirect(uri: request.getHeader("referer"))
    }

    def editResource() {

    }
}