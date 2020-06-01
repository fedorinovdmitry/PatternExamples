import Foundation


// MARK: - Theory
/*
 Данный паттерн позволяет избегать жесткой привязки отправителя запроса к получателю, позволяя нескольким объектам корректно обработать запрос. Обработчики запроса образуют цепочку, и при выполнении запрос перемещается по этой цепочке до того момента, пока он не будет обработан. Объект сам решает, может ли он обработать запрос или необходимо передавать его по цепочке дальше.

 Когда применять Цепочку обязанностей?
 ● В случаях, когда программа имеет несколько объектов способных обрабатывать запрос, однако изначально неизвестно, какой именно поступит запрос и какой обработчик понадобится.
 ● Если есть необходимость в строгом порядке обработки запроса.
 ● Если набор объектов, которые способны обрабатываться запрос, должен изменяться динамически.
 Как применять Цепочку обязанностей?
 1. Создается интерфейс обработчика.
 2. Реализуется способ перехода от предыдущего обработчика к следующему.
 3. Создается конкретный обработчик.
 Цепочка обязанностей позволяет уменьшить зависимость между обработчиком и клиентом, соблюдает принцип единственной обязанности и принцип открытости/закрытости. С другой стороны, имеется вероятность, что запрос останется необработанным никем.
*/
// MARK: - Test

class ChainOfResponsibility {

    static func testExampleWithErrors() {
        let errorHandler: ErrorHandler = LoginErrorHandler()
        
        print("try to request")
        requestData { (error) in
            guard let error = error else { return }
            errorHandler.handleError(error)
        }
        
    }

    private static func requestData(completion: @escaping (Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(GeneralError.sessionInvalid)
        }
    }
}

// MARK: - Example №1 -

/*
  Допустим, в нашем приложении мы ожидаем, что на запрос данных в сеть можем получить одну из ошибок:
 ● связанную с сетью,
 ● связанную с авторизацией,
 ● общую ошибку,
 ● другую (их может быть намного больше).
  
 используем данный паттерн для обработки всех типов ощибки
 */


// MARK: protocols

fileprivate protocol ErrorHandler {
    var next: ErrorHandler? { get set }
    func handleError(_ error: Error)
}

// MARK: classes

fileprivate enum LoginError: Error {
    case loginDoesNotExist
    case wrongPassword
    case smsCodeInvalid
}

fileprivate enum NetworkError: Error {
    case noConnection
    case serverNotResponding
}

fileprivate enum GeneralError: Error {
    case sessionInvalid
    case versionIsNotSupported
    case general
}


fileprivate class LoginErrorHandler: ErrorHandler {
    
    var next: ErrorHandler? = NetworkErrorHandler()
    
    func handleError(_ error: Error) {
        guard let loginError = error as? LoginError else {
            print("error - \(error) is not login error try next")
            self.next?.handleError(error)
            return
        }
        print(loginError)
        // показать подсказку
    }
    
}

fileprivate class NetworkErrorHandler: ErrorHandler {
    
    var next: ErrorHandler? = GeneralErrorHandler()
    
    func handleError(_ error: Error) {
        guard let networkError = error as? NetworkError else {
            print("error - \(error) is not network error try next")
            self.next?.handleError(error)
            return
        }
        print(networkError)
        // показать алерт, попробовать повторить запрос в сеть
    }
    
}

fileprivate class GeneralErrorHandler: ErrorHandler {
    
    var next: ErrorHandler?
    
    func handleError(_ error: Error) {
        guard let generalError = error as? GeneralError else {
            self.next?.handleError(error)
            return
        }
        print("error - \(generalError) is general error")
        
        // показать еррор вью конроллер
        // попробовать повторить запрос
        // записать в лог
    }
    
}

