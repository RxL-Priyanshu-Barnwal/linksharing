package linksharing

import grails.gorm.transactions.Transactional

class ResourceController {

    ResourceService resourceService
    ReadingItemService readingItemService
    TopicService topicService

    def index() {
        Long resourceId = params.id as Long

        def resource = Resource.get(resourceId)

        if(resource?.topic?.visibility?.PRIVATE) {
            // admin, creator, subscriber
            User user = session.user

            boolean isAllowed = user && (user.admin || resource.topic?.subscriptions?.any{it.user.id == user.id })

            if(!isAllowed) {
                println "Not Allowed"
                flash.message = "You don't have permission to view this private topic"

                println(request.getHeader("referer"))

                redirect(uri: request.getHeader("referer"))

                println "Redirected back."

                return
            }
        }

        println("${resource?.user?.username} created this resource in topic: ${resource?.topic?.name}")

        def trendingTopics = topicService.getTrendingTopics()

        def topicNames = Topic.list()*.name

        def userRating = ResourceRating.findByResourceAndUser(resource, session.user)?.score ?: 0

        [trendingTopics: trendingTopics, topicNames: topicNames, resource: resource, userRating: userRating]
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

        Long userId = session.user.id

        def res = resourceService.createDocResource(params, userId)

        if(res.success) {
            flash.message = res.message
            println("Document Resource created successfully.")
        }
        else {
            flash.message = res.message
            flash.showDocModal = true
            println("Document cannot be saved")
            println("${res.message}")
        }
        redirect(uri: request.getHeader("referer"))
    }

    def markAsRead() {
        Long readingItemId = params.long("id")

        if(readingItemService.markAsRead(readingItemId, session.user)) {
            println("Marked as read successfully")
            flash.message = "Marked as read successfully."
        }
        else {
            println("Unable to mark the resource as read.")
            flash.message = "Unable to mark the resource as read."
        }
        redirect(uri: request.getHeader("referer") ?: "/dashboard/index")
    }

    @Transactional
    def deleteResource() {
        Long resourceId = params.id as Long
        def resource = Resource.get(resourceId)

        if (!resource) {
            if (request.xhr) {
                render status: 404, text: "Resource not found"
            } else {
                flash.message = "Resource not found"
                redirect(controller: 'dashboard', action: 'index')
            }
            return
        }

        if (session.user?.id != resource.user?.id && !session.user?.admin) {
            if (request.xhr) {
                render status: 403, text: "Unauthorized to delete this resource"
            } else {
                flash.message = "Unauthorized access"
                redirect(controller: 'dashboard', action: 'index')
            }
            return
        }

        try {
            resource.delete(flush: true, failOnError: true)
            if (request.xhr) {
                render status: 200, text: "Resource deleted successfully"
            } else {
                flash.message = "Resource deleted successfully"
                redirect(controller: 'dashboard', action: 'index')
            }
        } catch (Exception e) {
            if (request.xhr) {
                render status: 500, text: "Error deleting resource: ${e.message}"
            } else {
                flash.message = "Error deleting resource"
                redirect(controller: 'dashboard', action: 'index')
            }
        }
    }

    def editResource() {
        Long resourceId = params.id as Long
        if(session.user?.id != Resource.get(resourceId).user?.id || session.user?.admin) {
            println("Unauthorized edit attempted")
            return
        }

        redirect(uri: request.getHeader("referer"))
    }

    def download(Long id) {
        def downloadInfo = resourceService.prepareDocumentForDownload(id)
        if (!downloadInfo?.fileExists) {
            flash.message = "Requested file not found."
            redirect(controller: 'dashboard', action: 'index')
            return
        }
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", "attachment; filename=${downloadInfo.filename}")
        response.outputStream << downloadInfo.bytes
        response.outputStream.flush()
    }

    def rating() {
        // resourceId, score are expected as request parameters
        Long resourceId = params.resourceId as Long
        Integer score = params.score?.toInteger()
        Long userId = session?.user?.id

        if (score < 1 || score > 5) { // Assuming a 1-5 star rating
            render status: 400, text: "Score must be between 1 and 5."
            return
        }

        try {
            resourceService.rating(resourceId, score, userId)
            render status: 200, text: "Rating submitted successfully."
        } catch (Exception e) {
            log.error "Error saving rating for resource ID ${resourceId} by user ID ${userId}: ${e.message}", e
            render status: 500, text: "Failed to submit rating."
        }
    }
}