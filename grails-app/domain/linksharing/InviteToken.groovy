package linksharing

class InviteToken {
    String token
    String invitedEmail
    Topic topic
    boolean used = false
    Date expiryDate

    static constraints = {
        token nullabe: false, unique: true
        expiryDate nullable: false, validator: { it > new Date() }
        topic nullable: false
        invitedEmail nullable: false
    }
}