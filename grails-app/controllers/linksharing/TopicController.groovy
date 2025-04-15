package linksharing

class TopicController {
    TopicService topicService
    //bean injection: bean is a application specific instance of service

    def createTopic() {
        println(params)
//
//        if (!params.name?.trim()) {
//            flash.message = "Topic name cannot be blank"
//            flash.showCreateModal = true
//            render(view: '/dashboard/index')
//            return
//        }

        def res = topicService.createTopic(params, session.user)

        if (res instanceof String) {
            flash.message = res
            flash.showCreateModal = true
            render(view: '/dashboard/index')
            return
        }
        else if (res instanceof Topic) {
            println("Topic '${params.name}' created successfully")
        }
        else {
            flash.message = res
            flash.showCreateModal = true
            render(view: '/dashboard/index')
        }
        redirect(controller: 'dashboard', action: 'index')
    }
}