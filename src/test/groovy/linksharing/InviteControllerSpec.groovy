package linksharing

import grails.testing.web.controllers.ControllerUnitTest
import spock.lang.Specification

class InviteControllerSpec extends Specification implements ControllerUnitTest<InviteController> {

     void "test index action"() {
        when:
        controller.index()

        then:
        status == 200

     }
}
