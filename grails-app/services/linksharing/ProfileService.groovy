package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class ProfileService {

    def updateDetails(params, Long userId) {
        User user = User.get(userId)

        def firstName = params.firstName
        def lastName = params.lastName
        def username = params.username
        def photoFile = params.photo

        if(firstName && !firstName.empty) {
            user.firstName = firstName
        }
        if(lastName && !lastName.empty) {
            user.lastName = lastName
        }
        if(username && !username.empty) {
            user.username = username
        }
        if(photoFile && !photoFile.empty) {
            user.photo = photoFile.bytes
        }
        if(user.validate()) {
            try {
                user.save(flush: true)
                println "User details updated successfully."
                return true
            }
            catch(Exception e) {
                println "Cannot save to db: ${e.message}."
                return false
            }
        }
        else {
            println "Cannot update user details"
            return false
        }
    }

    def updatePassword(params, Long userId) {
        User user = User.get(userId)

        def password = params.password
        def confirmPassword = params.confirmPassword

        if(password != confirmPassword) {
            return [success: false, message: "Passwords do not match."]
        }

        user.password = password

        if(user.validate()) {
            try {
                user.save(flush: true)
                return [success: true, message: "Password updated successfully."]
            }
            catch(Exception e) {
                return [success: false, message: "Error updating password: ${e.message}."]
            }
        }
        else {
            return [success: false, message: "Invalid password."]
        }
    }
}