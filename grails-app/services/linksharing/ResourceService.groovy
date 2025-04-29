package linksharing
import grails.gorm.transactions.Transactional
import org.springframework.web.multipart.MultipartFile

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

    def createDocResource(params, Long userId) {
        User user = User.get(userId)
        MultipartFile file = params.document
        String description = params.description
        String topicName = params.topic

        println "Username: ${user.username} \n Description: ${description} \n Topic name: ${topicName}"

        if(!file || file.empty) {
            return [success: false, message: "No file uploaded."]
        }

        String originalFileName = file.originalFilename?.toLowerCase()
        if(!originalFileName) {
            return [success: false, message: "Invalid file name"]
        }

        List<String> allowedExtensions = ['pdf', 'doc', 'docx', 'ppt', 'pptx', 'txt', 'csv', 'xlsx']

        String extension = originalFileName.tokenize('.').last()

        if(!allowedExtensions.contains(extension)) {
            return [success: false, message: "File type .$extension is not allowed"]
        }

        Topic topic = Topic.findByName(topicName)
        if(!topic) {
            return [success: false, message: "Invalid topic selected."]
        }

        String uploadDir = "/home/priyanshubarnwal/Documents/Training/'Link Sharing'/linksharing/grails-app/assets/uploads"

        File dir = new File(uploadDir)
        if(!dir.exists()) {
            dir.mkdirs()
        }

        String filePath = "${uploadDir}/${System.currentTimeMillis()}_${originalFileName}"
        file.transferTo(new File(filePath))

        DocumentResource documentResource = new DocumentResource(
                filePath: filePath,
                description: description,
                topic: topic,
                user: user
        )

        if(documentResource.validate()) {
            documentResource.save(flush: true)
            return [success: true, message: "Document Resources saved successfully."]
        }
        else {
            return [success: false, message: "Validation failed: ${documentResource.errors.allErrors*.defaultMessage.join(', ')}"]
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

    def prepareDocumentForDownload(Long id) {
        DocumentResource documentResource = DocumentResource.get(id)
        if (!documentResource || !new File(documentResource.filePath).exists()) {
            return [fileExists: false]
        }
        File file = new File(documentResource.filePath)
        return [
                fileExists: true,
                filename  : file.name,
                bytes     : file.bytes
        ]
    }

}