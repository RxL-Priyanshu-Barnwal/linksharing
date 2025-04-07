package linksharing

class Topic {
    String name
    User createdBy
    Date dateCreated
    Date lastUpdated
    enum Visibility {
        PUBLIC, PRIVATE
    }

    Visibility visibility = Visibility.PUBLIC

    static constraints = {
        name nullable: false, blank: false, unique: true
        createdBy nullable: false, blank: false, unique: true
        dateCreated nullable: false
        lastUpdated nullable: false
        visibility nullable: false
    }

    def beforeInsert() {
        if (!dateCreated) {
            dateCreated = new Date()
        }
    }

    def beforeUpdate() {
        if (!lastUpdated) {
            lastUpdated = new Date()
        }
    }
}