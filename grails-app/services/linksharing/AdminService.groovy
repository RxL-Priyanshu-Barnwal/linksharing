package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class AdminService {

    def toggleUserStatus(Long userId) {
        User user = User.get(userId)
        user.active = !user.active
        if(user.save(flush: true)) return true
        return false
    }

    def toggleAdminStatus(Long userId) {
        User user = User.get(userId)
        user.admin = !user.admin
        if(user.save(flush:true)) return true
        return false
    }
}