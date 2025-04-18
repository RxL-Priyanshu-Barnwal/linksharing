package linksharing

class ResourceController {

    ResourceService resourceService

    def createLinkResource() {
        println(params)

        def res = resourceService.createLinkResource(params, session.user)

        if(res instanceof LinkResource) {
            println("Link Resource created successfully.")
        }
        else {
            flash.linkResourceMessage = res
            flash.showLinkModal = true
        }

        redirect(uri: request.getHeader("referer"))
        //Redirects to the same page user was on
    }

    def createDocResource() {
        println(params)

        def res = resourceService.createDocResource(params, session.user)

        if(res instanceof DocumentResource) {
            println("Link Resource created successfully.")
        }
        else {
            flash.docResourceMessage = res
            flash.showDocModal = true
        }

        redirect(uri: request.getHeader("referer"))
        //Redirects to the same page user was on

    }
}