package linksharing

class ResourceRating {
    Resource resource
    User user
    Integer score

    static belongsTo = [resource: Resource, user: User]

    static constraints = {
        resource nullable:false
        user nullable:false
        score nullable:false, size: 1..5
        unique: ['user', 'resource']
    }
}
