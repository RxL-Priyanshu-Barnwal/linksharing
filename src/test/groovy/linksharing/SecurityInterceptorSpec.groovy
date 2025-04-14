package linksharing

import grails.testing.web.interceptor.InterceptorUnitTest
import spock.lang.Specification

class SecurityInterceptorSpec extends Specification implements InterceptorUnitTest<SecurityInterceptor> {

    void "test interceptor matching"() {
        when:
        withRequest(controller: "security")

        then:
        interceptor.doesMatch()
    }
}
