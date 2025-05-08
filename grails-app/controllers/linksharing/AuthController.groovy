package linksharing

import org.springframework.mail.MailSender
import grails.util.Holders

class AuthController {
    AuthService authService
    SubscribeService subscribeService
    def mailService

    def index() {
        redirect(controller: 'auth', action: 'login')
    }

    def login() {
        def getRecentPosts = authService.getRecentPosts()
        def getTopPosts = authService.getTopPosts()
        render(view: "login", model: [getRecentPosts: getRecentPosts, getTopPosts: getTopPosts])
    }

    def register() {
        def getRecentPosts = authService.getRecentPosts()
        def getTopPosts = authService.getTopPosts()
        def inviteToken = params.inviteToken ?: null
        render(view: "register", model: [getRecentPosts: getRecentPosts, getTopPosts: getTopPosts, inviteToken: inviteToken])
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

        def res = authService.registerUser(params)

        if(res.success) {
            println("Registration Successful")
            if(res.message) {
                flash.message = res.message
            }
            redirect(controller: "auth", action: "login")
        }
        else {
            flash.message = res.message
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
        redirect(controller: 'auth', action: 'login')
    }

    def acceptInvite() {
        InviteToken invitation = InviteToken.findByToken(params.token)

        if(!invitation || (invitation.expiryDate && invitation.expiryDate < new Date()) || invitation.used) {
            flash.message = "Invalid or expired invitation"
            redirect(controller: 'dashboard', action: 'index')
            return
        }

        //If user exists
        User user = User.findByEmail(invitation.invitedEmail)
        if (user) {
            InviteToken.withTransaction { status ->
                try {
                    subscribeService.createSubscription(user, invitation.topic, Subscription.Seriousness.CASUAL)
                    invitation.used = true
                    invitation.save() // Transactional save
                } catch (Exception e) {
                    status.setRollbackOnly()
                    flash.message = "Failed to process invitation: ${e.message}"
                }
            }
            redirect(controller: 'dashboard')
        } else {
            redirect(controller: 'auth', action: 'register', params: [inviteToken: params.token])
        }
    }

    def renderImage(Long id) {
        User user = User.get(id)
        if(user?.photo) {
            response.contentType = 'image/jpeg'
            response.outputStream << user.photo
            response.outputStream.flush()
        }
    }
}