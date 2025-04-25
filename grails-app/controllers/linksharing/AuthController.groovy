package linksharing

import org.springframework.mail.MailSender
import grails.util.Holders

class AuthController {
    AuthService authService
    def mailService

    def login() {
        def getRecentPosts = authService.getRecentPosts()
        render(view: "login", model: [getRecentPosts: getRecentPosts])
    }

    def register() {
        def getRecentPosts = authService.getRecentPosts()
        render(view: "register", model: [getRecentPosts: getRecentPosts])
    }

    def forgotPassword() { }

    def resetPasswordForm() {
        response.setHeader('Cache-Control', 'no-store, no-cache, must-revalidate, max-age=0')
        response.setHeader('Pragma', 'no-cache')
        response.setDateHeader('Expires', 0)

        if(!params.token) {
            flash.message = "Password reset requires a valid token."
            redirect(controller: 'auth', action: 'login')
            return
        }

        def rawToken = PasswordResetToken.findByToken(params.token)

        if(!rawToken || rawToken.expiryDate < new Date()) {
            flash.message = "Password reset requires a valid token."
            redirect(controller: 'auth', action: 'login')
            return
        }

        [token: params.token]
    }

    def registerUser() {
        println(params)

        def res = authService.registerUser(params)

        if(res.success) {
            println("Registration Successful")
            redirect(controller: "auth", action: "login")
        }
        else {
            flash.error = res.message
            render(view: "register", model: [user: res.user])
        }
    }

    def authenticateUser() {
        println(params)

        def res = authService.authenticateUser(params.username, params.password, session)

        if(res.success) {
            println("Login Successful")
            redirect(controller: "dashboard", action: "index")
        }
        else {
            switch (res.reason) {
                case 'inactive':
                    flash.message = "Your account is inactive."
                    break
                case 'invalid':
                default:
                    flash.message = "Invalid username or password."
                    break
            }
            redirect action: "login"
        }
    }

    def forgotPasswordOnSubmit() {
        if(!params.email) {
            redirect(controller: 'auth', action: 'login')
            return
        }
        User user = User.findByEmail(params.email)
        if(user) {
            PasswordResetToken token = authService.generateResetToken(user)

            //Send token.token to user.email
//            def baseUrl = Holders.grailsApplication.config.grails.app.baseUrl
            def resetLink = "http://localhost:8080/auth/resetPasswordForm?token=${token.token}"

            mailService.sendMail {
                to user.email
                subject "Reset Your Password"
                html """\
                    <p>Hello,</p>
                    <p>We received a request to reset your password. Click the link below to choose a new password:</p>
                    <p><a href="${resetLink}">${resetLink}</a></p>
                    <p>If you did not request this, you can safely ignore this email.</p>
                """
            }
            println "Mail sent."
        }

        render """
                <!DOCTYPE html>
                <html lang="en">
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Password Reset Status</title>
                    <style>
                        body {
                            background-color: #2C3238;
                            color: white; /* Optional: Set text color for better contrast */
                            font-family: sans-serif; /* Optional: Choose a font */
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            min-height: 100vh;
                            margin: 0;
                        }
                        .message-container {
                            background-color: #1C1F24; /* Optional: A slightly lighter background for the message box */
                            padding: 20px;
                            border-radius: 5px;
                            text-align: center;
                        }
                    </style>
                </head>
                <body>
                    <div class="message-container">
                        <h3>If the email exists, a reset link has been sent.</h3>
                    </div>
                </body>
                </html>
            """
    }

    def resetPasswordFormOnSubmit() {
        String rawToken = params.token
        String newPassword = params.newPassword
        String confirmPassword = params.confirmPassword

        if(!rawToken || !newPassword) {
            flash.message = "Token and new password are required"
            redirect(controller: 'auth', action: 'resetPasswordForm', params: [token: rawToken])
            return
        }

        if(newPassword.length() < 6) {
            flash.message = "Password must be at least 6 characters."
            redirect(controller: 'auth', action: 'resetPasswordForm', params: [token: rawToken])
            return
        }

        if(newPassword != confirmPassword) {
            flash.message = "Passwords do not match."
            redirect(controller: 'auth', action: 'resetPasswordForm', params: [token: rawToken])
            return
        }

        def res = authService.resetPassword(rawToken, newPassword)

        if(res) {
            flash.message = "Password reset successful. Login with new password."
            redirect(controller: 'auth', action: 'login')
        }
        else {
            flash.message = "Invalid or expired token. Please request a new reset link."
            redirect(controller: 'auth', action: 'forgotPassword')
        }
    }

    def logout() {
        session.invalidate()
        println("Logged out successfully")
        redirect(controller:"auth", action:"login")
    }
}