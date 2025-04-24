package linksharing

import grails.validation.ValidationException

class AuthService {
    // Inject messageSource for i18n
    def messageSource

    def registerUser(params) {
        def user = new User(params)

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
            println("saved successfully")
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
}