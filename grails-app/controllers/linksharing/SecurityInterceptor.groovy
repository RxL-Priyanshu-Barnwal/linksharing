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
            else {
                  response.setHeader('Cache-Control', 'no-store, no-cache, must-revalidate, max-age=0')
                  response.setHeader('Pragma', 'no-cache')
                  response.setDateHeader('Expires', 0)
                  return true
            }
      }

      boolean after() { true }

      void afterView() {
        // no-op
      }

}