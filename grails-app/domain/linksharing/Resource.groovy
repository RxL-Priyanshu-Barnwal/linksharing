package linksharing

class Resource {
    String description
    User user
    Topic topic
    Date dateCreated
    Date lastUpdated

    static belongsTo = [user: User, topic: Topic]
    static hasMany = [ratings: ResourceRating]

    static constraints = {
        description blank: false, maxSize: 1000, unique: 'topic'
        user nullable: false
        topic nullable: false
        dateCreated nullable: false
        lastUpdated nullable: false
    }

    static mapping = {
        autoTimestamp true
    }

    // define methods to update descriptions
}