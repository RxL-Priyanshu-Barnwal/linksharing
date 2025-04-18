package linksharing

class ReadingItem {
    Resource resource
    User user
    Boolean isRead

    static belongsTo = [user: User, resource: Resource]

    static constraints = {
        resource nullable: false
        user nullable: false
        isRead nullable: false
    }
}