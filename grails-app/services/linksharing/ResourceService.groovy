package linksharing
import grails.gorm.transactions.Transactional

@Transactional
class ResourceService {

    ReadingItemService readingItemService

    def createLinkResource(params, User user) {
        def topicInstance = Topic.findByName(params.topic)

        def linkResource = new LinkResource(url: params.url, description: params.description, topic: topicInstance, user: user)

        if(linkResource.save(flush: true)) {
            readingItemService.createReadingItem(linkResource, user)
            return linkResource
        }
        else {
            linkResource.errors.allErrors.each {
                println "Validation error: ${it}"
            }
            return linkResource.errors.allErrors.collect {
                it.defaultMessage
            }.join(', ')
        }
    }

    def createDocResource(params, User user) {

        def topicInstance = Topic.findByName(params.topic)

        def docResource = new DocumentResource(filePath: params.filePath, description: params.description, topic: topicInstance, user: user)

        if(docResource.save(flush: true)) {
            readingItemService.createReadingItem(docResource, user)
            return docResource
        }
        else {
            docResource.errors.allErrors.each {
                println "Validation error: ${it}"
            }
            return docResource.errors.allErrors.collect {
                it.defaultMessage
            }.join(', ')
        }
    }

    def deleteResource(Long id) {
        Resource resource = Resource.get(id)
        try{
            resource.withNewTransaction {
                resource.delete(flush: true, failOnError: true)
            }
        }
        catch(Exception e) {
            println "${e.message}"
        }
    }

    def editResource(Long id) {
        Resource resource = Resource.get(id)
    }

    def rating(Long resourceId, Integer score, Long userId) {
        User user = User.get(userId)
        Resource resource = Resource.get(resourceId)

        ResourceRating existingRating = ResourceRating.findByResourceAndUser(resource, user)

        if (existingRating) {
            // Update the existing rating
            existingRating.score = score
            try {
                existingRating.save(flush: true)
                println "Rating for resource ${resourceId} by user ${userId} updated to ${score} stars."
            } catch (Exception e) {
                println "Couldn't update rating: ${e.message}"
                throw e
            }
        } else {
            // Create a new rating
            ResourceRating newRating = new ResourceRating(resource: resource, user: user, score: score)
            try {
                newRating.save(flush: true)
                println "${score} stars rating stored for resource ${resourceId} by user ${userId}."
            } catch (Exception e) {
                println "Couldn't store new rating: ${e.message}"
                throw e
            }
        }
    }

    def getResourcesWithRating() {
        return Resource.findAll().collect { resource ->
            def averageRating = ResourceRating.withCriteria {
                eq("resource", resource)
                projections {
                    avg("score")
                }
            }.first() ?: 0
            [
                resource: resource,
                averageRating: averageRating,
            ]
        }
    }
}