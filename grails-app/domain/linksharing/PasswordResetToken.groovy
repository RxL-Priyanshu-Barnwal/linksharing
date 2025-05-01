package linksharing

class PasswordResetToken {
    String token
    Date expiryDate
    User user

    static constraints = {
        token nullable: false, unique: true
        expiryDate nullable: false, validator: { it > new Date() }
        user nullable: false
    }

    static mapping = {
        token index: 'hashed_token_idx'
        expiryDate index: 'expiry_date_idx'
    }

}