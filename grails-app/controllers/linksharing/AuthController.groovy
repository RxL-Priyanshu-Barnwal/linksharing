package linksharing

class AuthController {
    AuthService authService

    def login() {
        def getRecentPosts = authService.getRecentPosts()
        render(view: "login", model: [getRecentPosts: getRecentPosts])
    }

    def register() {
        def getRecentPosts = authService.getRecentPosts()
        render(view: "register", model: [getRecentPosts: getRecentPosts])
    }

    def forgotPassword() { }

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

    def logout() {
        session.invalidate()
        println("Logged out successfully")
        redirect(controller:"auth", action:"login")
    }
}