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
            resource.delete(flush: true, failOnError: true)
        }
        catch(Exception e) {
            println "${e.message}"
        }
    }

    def editResource(Long id) {
        Resource resource = Resource.get(id)

    }
}