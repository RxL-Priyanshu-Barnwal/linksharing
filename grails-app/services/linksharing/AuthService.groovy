package linksharing

import grails.gorm.transactions.Transactional
import grails.validation.ValidationException
import groovy.time.TimeCategory
import org.springframework.web.multipart.MultipartFile

@Transactional
class AuthService {
    // Inject messageSource for i18n
    def messageSource
    SubscribeService subscribeService

    def registerUser(params, String photoPath = null) {
        def user = new User(params)

        if(photoPath) {
            user.photo = photoPath
        }

        if (params.password != params.confirmPassword) {
            user.errors.rejectValue("password", "user.password.mismatch", "Passwords do not match")

            def fieldErrors = [
                    password: [messageSource.getMessage("user.password.mismatch", null, "Passwords do not match", Locale.default)]
            ]
            return [success: false, user: user, fieldErrors: fieldErrors]
        }

        if (!user.validate()) {
            def fieldErrors = [:]

            user.errors.fieldErrors.each { error ->
                def fieldName = error.field
                def message = messageSource.getMessage(error, Locale.default)

                if (!fieldErrors[fieldName]) {
                    fieldErrors[fieldName] = []
                }
                fieldErrors[fieldName] << message
            }

            return [success: false, user: user, fieldErrors: fieldErrors]
        }

        try {
            User.withNewTransaction {
                user.save(flush: true, failOnError: true)
            }

            if(params.inviteToken) {
                InviteToken invitation = InviteToken.findByTokenAndInvitedEmail(params.inviteToken, user.email)
                if(invitation) {
                    subscribeService.createSubscription(user: user, topic: invitation.topic)
                    invitation.used = true
                }
            }

            return [success: true, user: user]
        } catch (Exception e) {
            println("cannot save to db")
            return [success: false, user: user, fieldErrors: [general: ["Unexpected error: ${e.message}"]]]
        }
    }

    def authenticateUser(String username, String password, session) {
        def user = User.findByUsername(username)

        if(!user) {
            return [success: false, reason: 'invalid']
        }
        if(!user.active) {
            return [success: false, reason: 'inactive']
        }

        if(user.password != password) {
            return [success: false, reason: 'invalid']
        }

        session.user = user
        session.userId = user.id
        return [success: true]
    }

    def getRecentPosts(int max = 2) {
        Resource.createCriteria().list(max: max, sort: "dateCreated", order: "desc") {
            topic {
                eq("visibility", Topic.Visibility.PUBLIC)
            }
        }
    }

    def generateResetToken(User user) {
        // Generate secure random token
        String rawToken = UUID.randomUUID().toString() + System.currentTimeMillis()

//        String hashedToken = PasswordResetToken.hashToken(rawToken)

        Date expiryDate
        use(TimeCategory) {
            expiryDate = new Date() + 1.hour
        }

        PasswordResetToken token = new PasswordResetToken(
                token: rawToken,
//                hashedToken: hashedToken,
                expiryDate: expiryDate,
                user: user
        )

        // Invalidate previous tokens
        PasswordResetToken.where { user == token.user }.deleteAll()

        println "Raw Token:: ${rawToken} \n expiryDate:: ${expiryDate}"

        token.save(flush:true, failOnError: true)
        return token
    }

    def resetPassword(String rawToken, String newPassword) {
        def token = PasswordResetToken.findByToken(rawToken)

        if (!token || token.expiryDate < new Date()) {
            return false
        }

        token.user.password = newPassword
        token.user.save(flush: true)
        token.delete(flush: true)
        return true
    }

//    def getTopPosts(int max = 2) {
//        return Resource.executeQuery("""
//        SELECT r
//        FROM Resource r
//        INNER JOIN r.ratings rr
//        WHERE r.topic.visibility = :visibility
//        GROUP BY r
//        ORDER BY AVG(rr.score) DESC
//    """,
//                [visibility: Topic.Visibility.PUBLIC],
//                [max: max])
//    }
}