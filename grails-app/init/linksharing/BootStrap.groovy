package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class BootStrap {

    def init = { servletContext ->
        if (!User.findByUsername("adminuser")) {
            println "Creating admin user"

            def admin = new User(
                    email: "admin@linksharing.com",
                    username: "adminuser",
                    password: "admin123",
                    firstName: "Admin",
                    lastName: "User",
                    admin: true,
                    active: true
            )

            // Manually ensuring the save is inside a transaction
            admin.withTransaction {
                if (!admin.save(failOnError: true)) {
                    println "Failed to save admin user"
                    admin.errors.allErrors.each { println it }
                } else {
                    println "Admin user created"
                }
            }
        }
    }

    def destroy = {}
}
