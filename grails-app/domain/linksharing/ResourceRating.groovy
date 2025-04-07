package linksharing

class ResourceRating {
    Resource resource
    User user
    Boolean isRead = false

    static constraints = {
        resource nullable:false, unique:true
        user nullable:false, unique:true
        isRead nullable:false
    }
}