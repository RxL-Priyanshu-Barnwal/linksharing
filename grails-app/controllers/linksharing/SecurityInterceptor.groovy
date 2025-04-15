package linksharing

class SecurityInterceptor {

      SecurityInterceptor() {
            matchAll()
      }

      boolean before() {
            def allowedControllers = ['auth']

            if (allowedControllers.contains(controllerName)) {
                  return true // allow access
            }
            if(!session.user) {
                  redirect(controller: "auth", action: "login")
                  return false
            }
            return true
      }

      boolean after() { true }

      void afterView() {
        // no-op
      }

}