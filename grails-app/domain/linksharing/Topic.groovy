package linksharing

class Topic {
    String name
    User user
    Date dateCreated
    Date lastUpdated
    enum Visibility {
        PUBLIC, PRIVATE
    }

    Visibility visibility = Visibility.PUBLIC

    static hasMany = [resources: Resource, subscriptions: Subscription]
    static belongsTo = [user: User]

    static constraints = {
        name nullable: false, blank: false, unique: true
        user nullable: false, blank: false, unique: true
        dateCreated nullable: false
        lastUpdated nullable: false
        visibility nullable: false
    }

    static mapping = {
        autoTimestamp true
    }
}x