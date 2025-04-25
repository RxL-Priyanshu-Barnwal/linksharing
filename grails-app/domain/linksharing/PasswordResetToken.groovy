package linksharing

class PasswordResetToken {
    String token //raw token
//    String hashedToken // SHA-256 hashed token
    Date expiryDate
    User user

//    static transients = ['token']

    static constraints = {
        token nullable: false, unique: true
        expiryDate nullable: false, validator: { it > new Date() }
        user nullable: false
    }

    static mapping = {
        token index: 'hashed_token_idx'
        expiryDate index: 'expiry_date_idx'
    }


//    Validation occurs before the beforeInsert hook is called therefore hashedToken and expiryDate were giving null validation error
//    def beforeInsert() {
//        this.hashedToken = hashToken(this.token)
//        use (TimeCategory) {
//            this.expiryDate = new Date() + 1.hours
//        }
//    }
//
//    static String hashToken(String rawToken) {
//        MessageDigest digest = MessageDigest.getInstance("SHA-256")
//        digest.update(rawToken.getBytes("UTF-8"))
//        new String(digest.digest())
//    }
}