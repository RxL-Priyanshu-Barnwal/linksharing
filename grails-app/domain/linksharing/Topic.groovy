package linksharing

class Topic {
    String name
    User user //who created the topic
    Date dateCreated
    Date lastUpdated
    enum Visibility {
        PUBLIC, PRIVATE
    }

    Visibility visibility = Visibility.PUBLIC

    static hasMany = [resources: Resource, subscriptions: Subscription]
    static belongsTo = [user: User]

    static constraints = {
        name nullable: false, blank: false, unique: 'user', maxSize: 40
        user nullable: false, blank: false
        visibility nullable: false
    }

    static mapping = {
        email updateable: false
        username updateable: false
        autoTimestamp true
        resources cascade: 'all-delete-orphan'
        subscriptions cascade: 'all-delete-orphan'
    }

}