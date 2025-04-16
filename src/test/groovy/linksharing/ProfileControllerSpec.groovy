package linksharing

import grails.testing.web.controllers.ControllerUnitTest
import spock.lang.Specification

class ProfileControllerSpec extends Specification implements ControllerUnitTest<ProfileController> {

     void "test index action"() {
        when:
        controller.index()

        then:
        status == 200

     }
}
