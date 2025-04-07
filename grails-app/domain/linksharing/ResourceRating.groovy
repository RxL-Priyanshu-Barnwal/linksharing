package linksharing

class ResourceRating {
    Resource resource
    User user
    Integer score

    static belongsTo = [resource: Resource, user: User]

    static constraints = {
        resource nullable:false, unique:true
        user nullable:false, unique:true
        score nullable:false, size: 1..5
    }

    static mapping = {
        id composite = ['resource', 'user']
    }
}