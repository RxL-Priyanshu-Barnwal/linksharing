package linksharing

import grails.testing.gorm.DomainUnitTest
import spock.lang.Specification

class InviteTokenSpec extends Specification implements DomainUnitTest<InviteToken> {

     void "test domain constraints"() {
        when:
        InviteToken domain = new InviteToken()
        //TODO: Set domain props here

        then:
        domain.validate()
     }
}
