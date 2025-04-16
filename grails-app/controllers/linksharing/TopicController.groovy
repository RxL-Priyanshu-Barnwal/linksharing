package linksharing

class TopicController {
    TopicService topicService
    //bean injection: bean is a application specific instance of service

    def createTopic() {
        println(params)

        def res = topicService.createTopic(params, session.user)

        if (res instanceof Topic) {
            println("Topic '${params.name}' created successfully")
        }
        else {
            flash.topicMessage = res
            flash.showTopicModal = true
        }
        redirect(controller: 'dashboard', action: 'index')
    }
}