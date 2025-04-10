package linksharing
//import org.springframework.security.crypto.password.PasswordEncoder
//import javax.security.sasl.AuthenticationException

class AuthController {
    def login() { }

    def register() { }

    def forgotPassword() { }

//    def authenticate() {
//        def loginIdentifier = params.loginIdentifier // Could be username or email
//        def password = params.password
//
//        if (!loginIdentifier || !password) {
//            flash.error = message(code: 'auth.login.required')
//            redirect action: 'login'
//            return
//        }
//
//        try {
//            // Delegate authentication to your AuthService
//            def user = authService.authenticateUser(loginIdentifier, password)
//
//            if (user) {
//                // Authentication successful
//                // For Spring Security integration, you might need to manually
//                // create an Authentication object and set it in the SecurityContextHolder
//                // based on the authenticated 'user' details.
//
//                // Example using a simple session flag (adjust as needed for Spring Security)
//                session.setAttribute("loggedInUserId", user.id)
//                redirect uri: '/dashboard' // Redirect to a protected area
//                return
//            } else {
//                // Authentication failed
//                flash.error = message(code: 'auth.login.failed')
//                redirect action: 'login'
//                return
//            }
//
//        } catch (AuthenticationException e) {
//            // Handle specific authentication exceptions
//            flash.error = message(code: 'auth.login.failed', args: [e.getMessage()])
//            redirect action: 'login'
//            return
//        }
//    }

}