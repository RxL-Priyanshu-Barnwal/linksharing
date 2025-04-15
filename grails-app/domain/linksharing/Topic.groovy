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
        name nullable: false, blank: false, unique: 'user'
        user nullable: false, blank: false
        visibility nullable: false
    }

    static mapping = {
        email updateable: false
        username updateable: false
        autoTimestamp true
    }

    // define methods for changing visibility, adding resource,
}