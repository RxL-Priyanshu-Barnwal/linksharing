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

        redirect(controller: 'dashboard', action: 'index')
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

        redirect(controller: 'dashboard', action: 'index')

    }
}