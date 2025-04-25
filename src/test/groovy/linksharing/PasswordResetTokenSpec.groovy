package linksharing

import grails.testing.gorm.DomainUnitTest
import spock.lang.Specification

class PasswordResetTokenSpec extends Specification implements DomainUnitTest<PasswordResetToken> {

     void "test domain constraints"() {
        when:
        PasswordResetToken domain = new PasswordResetToken()
        //TODO: Set domain props here

        then:
        domain.validate()
     }
}
