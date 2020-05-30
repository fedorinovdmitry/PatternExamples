import Foundation


// MARK: - Theory
/*
 Паттерн Proxy (прокси, «заместитель») — структурный шаблон проектирования. Представляет собой объект, который контролирует доступ к другому объекту, перехватывая все вызовы. При этом объект-прокси имеет тот же интерфейс, что и настоящий объект.
 Данный паттерн проектирования можно сравнить с фильтром. Смысл Заместителя в том, что он является объектом-посредником между другими объектами, и вся их взаимосвязь осуществляется непосредственно через заместителя. Объект заместителя является оберткой для другого объекта.
 Когда применять Заместителя?
 ● Когда есть необходимость ограничения доступа к объекту.
 ● Необходимо скрыть большую часть логики приложения.
 Как применять Заместителя?
 1. Создать интерфейс, который будет являться общим как для Заместителя, так и для самого объекта.
 2. Реализовать класс, который необходимо замещать.
 3. Реализовать класс Заместителя.
 Заместитель позволяет полноценно контролировать объект незаметно для клиента, он может работать в случаях, когда основной объект еще не создан. В то же время Заместитель увеличивает время отклика от сервиса.
 */
// MARK: - Test

class Proxy {
    
    static func testExampleWithAutheficatedSrver() {
        print("create users:")
        let artem = User(login: "Artem", password: "fuckAndroid")
        let dimich = User(login: "Dimich", password: "loveIOS")
        print(artem)
        print("\(dimich)\n")
        
        print("work with virtual server")
        let virtualProxyServer = VirtualProxy()
        virtualProxyServer.grantedAccess(for: artem)
        virtualProxyServer.deniedAccess(for: dimich)
        print("\n")
        
        print("work with log server")
        let logProxyServer = LogProxy()
        logProxyServer.grantedAccess(for: artem)
        logProxyServer.grantedAccess(for: dimich)
        logProxyServer.deniedAccess(for: artem)
        logProxyServer.printLog()
        print("\n")
        
        print("work with protectded server")
        let protectedProxyServer = ProtectedProxy()
        print("try to grant access for \(artem)")
        protectedProxyServer.grantedAccess(for: artem)
        print("try to sign in")
        protectedProxyServer.singIn(user: artem)
        print("lets to sign up all users")
        protectedProxyServer.sighUp(user: artem)
        protectedProxyServer.sighUp(user: dimich)
        print("now \(artem) sign in")
        protectedProxyServer.singIn(user: artem)
        print("now try to grantAccess from server")
        protectedProxyServer.grantedAccess(for: artem)
        print("now try to deniedAccess from server")
        protectedProxyServer.deniedAccess(for: artem)
        protectedProxyServer.deniedAccess(for: dimich)
        
        
    }

    
    

}

// MARK: - Example №1 -

/*
 в данном примере мы реализуем сервер с аутефикацией и 3 вида заместителя к нему, а именно виртуальный, логирующий и защитный
 
 */


// MARK: protocols
fileprivate protocol Server {
    func grantedAccess(for user: User)
    func deniedAccess(for user: User)
}

// MARK: classes
fileprivate class User {
    var login: String
    var password: String
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}

fileprivate class RealServer: Server {
    func grantedAccess(for user: User) {
        print("give access for \(user.login)")
    }
    
    func deniedAccess(for user: User) {
        print("denied access for \(user.login)")
    }
}

fileprivate class VirtualProxy: Server {
    lazy private var server = RealServer()
    
    func grantedAccess(for user: User) {
        server.grantedAccess(for: user)
    }
    
    func deniedAccess(for user: User) {
        server.grantedAccess(for: user)
    }
}

fileprivate class LogProxy: Server {
    lazy private var server = RealServer()
    private var log = [String]()
    func grantedAccess(for user: User) {
        server.grantedAccess(for: user)
        log.append("user with login-'\(user.login)' was logged in at \(Date())")
    }
    
    func deniedAccess(for user: User) {
        server.deniedAccess(for: user)
        log.append("user with login-'\(user.login)' was logged out at \(Date())")
    }
    
    func printLog() {
        print("printing log:")
        log.forEach { print($0) }
    }
}

fileprivate class ProtectedProxy: Server {
    
    lazy private var server = RealServer()
    ///база данных зарегестрированных пользователей на клиенте
    private var localUserBD = [String: String]()
    ///база данных авторизованных пользователей
    private var signInBD = [String: String]()
    
    func grantedAccess(for user: User) {
        guard
            isAutheficate(in: .signInBD, user: user)
            else {
                print("user must be autheficated first")
                return
        }
        server.grantedAccess(for: user)
    }
    
    func deniedAccess(for user: User) {
        guard isAutheficate(in: .signInBD, user: user) else {
            print("don't have such user")
            return
        }
        signInBD.removeValue(forKey: user.login)
        server.deniedAccess(for: user)
    }
    
    func sighUp(user: User) {
        localUserBD[user.login] = user.password
    }
    
    func singIn(user: User) {
        guard isAutheficate(in: .localBD, user: user)
            else {
                print("don't have such user, you must to sign up first")
                return
        }
        signInBD[user.login] = user.password
    }
    
    private enum BD {
        case localBD
        case signInBD
    }
    private func isAutheficate(in bd: BD, user: User) -> Bool {
        switch bd {
        case .localBD:
            guard
                let password = localUserBD[user.login],
                password == user.password else { return false }
            return true
        case .signInBD:
            guard
                let password = signInBD[user.login],
                password == user.password else { return false }
            return true
        }
    }
}
