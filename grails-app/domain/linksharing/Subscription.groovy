package linksharing

class Subscription {
    Topic topic
    User user
    enum Seriousness {
        CASUAL, SERIOUS, VERY_SERIOUS
    }

    Date dateCreated

    Seriousness seriousness = Seriousness.CASUAL

    static belongsTo = [topic: Topic, user: User]

    static constraints = {
        topic nullable: false
        user nullable: false
        seriousness nullable: false
        unique: ['topic', 'user']
    }

    static mapping = {
        autoTimestamp true
//        id composite: ['user', 'topic']
        user column: 'user_id'
        topic column: 'topic_id'
//        dateCreated sort: 'desc'
    }
}

/*
    static mapping = {
        id composite: ['topic', 'user']
    } this way is more explicit and treats user and topic combination as primary key (composite key).


    Alternatively,
    static constraints = {
        ...
        unique: ['topic', 'user']
    } this will enforce uniqueness at an application level
*/