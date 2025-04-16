package linksharing
import grails.gorm.transactions.Transactional

@Transactional
class ResourceService {

    def createLinkResource(params, User user) {
        //params: url, description, topic, session.user
        if(!params.url || !params.description || !params.topic) {
            println("All Fields are necessary.")
            return "All Fields are necessary."
        }

        def topicInstance = Topic.findByName(params.topic)

        def linkResource = new LinkResource(url: params.url, description: params.description, topic: topicInstance, user: user)

        if(linkResource.save(flush: true)) {
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
        if(!params.filePath || !params.description || !params.topic) {
            println("All Fields are necessary.")
            return "All Fields are necessary."
        }

        def topicInstance = Topic.findByName(params.topic)

        def docResource = new DocumentResource(filePath: params.filePath, description: params.description, topic: topicInstance, user: user)

        if(docResource.save(flush: true)) {
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
}