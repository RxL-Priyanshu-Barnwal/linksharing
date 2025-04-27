package linksharing

class User {
    String email
    String username
    String password
    String firstName
    String lastName
    byte[] photo
    Boolean admin = false
    Boolean active = true
    Date dateCreated
    Date lastUpdated

    static hasMany = [topics: Topic, resources: Resource, ratings: ResourceRating, subscriptions: Subscription, readingItems: ReadingItem, passwordResetTokens: PasswordResetToken]

    static constraints = {
        email nullable: false, blank: false, unique: true, maxSize: 50
        username nullable: false, blank: false, unique: true, minSize: 6, maxSize: 16
        password nullable: false, blank: false, minSize: 6
        firstName nullable: false, blank: false, maxSize: 12
        lastName nullable: true, blank: true, maxSize: 12
        photo nullable: true
        admin nullable: false
        active nullable: false
    }

    static mapping = {
        autoTimestamp true
        table 'user_table'
        subscriptions lazy: false
        topics lazy: false

        topics cascade: 'all-delete-orphan'
        resources cascade: 'all-delete-orphan'
        subscriptions cascade: 'all-delete-orphan'
    }

    // define methods to update firstName, lastName, photo
}