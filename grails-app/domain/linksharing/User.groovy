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

    static hasMany = [topics: Topic, resources: Resource, ratings: ResourceRating, subscriptions: Subscription]

    static constraints = {
        email nullable: false, blank: false, unique: true
        username nullable: false, blank: false, unique: true, minSize: 6
        password nullable: false, blank: false, minSize: 6
        firstName nullable: false, blank: false
        lastName nullable: true, blank: true
        photo nullable: true
        admin nullable: false
        active nullable: false
    }

    static mapping = {
        autoTimestamp true
        table 'user_table'
        subscriptions lazy: false
        topics lazy: false
    }

    // define methods to update firstName, lastName, photo
}