package linksharing

class InviteController {

    def mailService

    def sendInvite() {
        String email = params.email
        String topic = params.topic

        mailService.sendMail {
            to email
            subject "Invitation"
            text "Hello, you are invited to subscribe to ${topic} topic."
        }

        println "Invitation sent to ${email}"
        redirect(uri: request.getHeader("referer") ?: "/")
    }
}