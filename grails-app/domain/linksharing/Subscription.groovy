package linksharing

class Subscription {
    Topic topic
    User user
    enum Seriousness {
        CASUAL, SERIOUS, VERY_SERIOUS
    }
    Date dateCreated

    Seriousness seriousness = Seriousness.CASUAL

    static constraints = {
        topic nullable: false
        user nullable: false
        seriousness nullable: false
        dateCreated nullable: false
    }

    static mapping = {
        id composite: ['topic', 'user']
    }

    def beforeInsert() {
        if (!dateCreated) {
            dateCreated = new Date()
        }
    }

}