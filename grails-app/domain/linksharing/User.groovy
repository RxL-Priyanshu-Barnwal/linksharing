package linksharing

class User {
    String email
    String username
    String password
    String firstName
    String lastName
    Byte photo
    Boolean admin = false
    Boolean active = true
    Date dateCreated
    Date lastUpdated

    static constraints = {
        email nullable: false, blank: false, unique: true
        username nullable: false, blank: false, unique: true, minSize: 6
        password nullable: false, blank: false, minSize: 6
        firstName nullable: false, blank: false
        lastName nullable: true, blank: true
        photo nullable: false
        admin nullable: false
        active nullable: false
        dateCreated nullable: false, blank: false
        lastUpdated nullable: false, blank: false
    }

    static mapping = {
        autoTimestamp true
    }
}