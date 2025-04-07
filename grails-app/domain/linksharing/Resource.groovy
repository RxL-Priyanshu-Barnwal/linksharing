package linksharing

class Resource {
    String description
    User user
    Topic topic
    Date dateCreated
    Date lastUpdated

    static constraints = {
        description blank:false, maxSize:1000
        user nullable:false
        topic nullable:false
        dateCreated nullable:false
        lastUpdated nullable:false
    }

    static mapping = {
        autoTimestamp true
    }
}