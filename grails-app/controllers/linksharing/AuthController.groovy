package linksharing

class AuthController {
    AuthService authService

    def login() { }

    def register() { }

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

        if(res) {
            println("Login Successful")
            redirect(controller: "dashboard", action: "index")
        }
        else {
            flash.message = "Invalid username or password"
            redirect action: "login"
        }
    }

    def logout() {
        session.invalidate()
        println("Logged out successfully")
        redirect(controller:"auth", action:"login")
    }
}