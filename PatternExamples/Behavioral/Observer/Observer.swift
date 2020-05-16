import Foundation


// MARK: - Theory
/*
 Паттерн Observer (наблюдатель) — поведенческий шаблон проектирования. Он используется, когда одни объекты должны узнавать об изменениях состояния других.
 Паттерн Наблюдатель создает механизм подписки объектов, с помощью которой может в будущем оповещать подписанные объекты о различных изменениях. Этот паттерн можно сравнить с обычной подпиской на газету. Когда выходит новый выпуск, все подписчики его получают.

 Есть четыре основных способа применить этот паттерн:
 - [ ] 1. NotificationCenter.​Это самый простой, но наименее желательный способ реализации. Дело в том, что он нарушает абстракцию, усложняет код для чтения и поддержки. Частично вы с ним должны быть уже знакомы из предыдущих курсов.
 - [ ] 2. KVO (key-value observing). Это механизм для реализации ​observer,​ пришедший из Objective-C.​​KVO использует ​objc-runtime,​поэтому нам нужно помечать классы и свойства маркером ​@objc,​ а классы наследовать от ​NSObject.​ При разработке на чистом ​Swift используется крайне редко (да и на Objective-C, как правило, для специфических задач).
 - [ ] 3. RxSwift. ​Это стороннаяя библиотека (​https://github.com/ReactiveX/RxSwift)​, многими командами она используется в продакшене.
 - [ ] 4. Реализация своей обертки для обсервинга (наблюдения) свойств. ​Если не хочется тянуть библиотеку ​RxSwift или вы с командой разработки решили, что не будете ее использовать (а первые два способа, как правило, не рассматриваются вообще из за их минусов), то это отличный способ реализации паттерна. Рассмотрим именно его и применим в проекте.
 
 Когда применять Наблюдатель?
 ● Если необходимо изменить один объект при изменении другого.
 ● Если объекты должны наблюдать за другими, но только в определенных случаях.

 Как применять Наблюдатель?
 1. Реализовать класс, который будет отправлять уведомления подписчикам.
 2. Создать класс и подписать его на уведомления.
 3. Реализовать метод для обработки полученного уведомления.
 Наблюдатель помогает реализовать принцип открытости/закрытости, издатель не зависит от конкретных классов подписчиков, можно легко изменять подписчиков и их действия в ответ на уведомления. Нужно помнить, что объекты-подписчики уведомляются в случайном порядке.
 */

// MARK: - Test

class Observer {
    
    static func testExample1TeacherPupils() {
        let teacher = Teacher()
        let goodPupil = GoodPupil()
        let badPupil = BadPupil()
        teacher.addObserver(observer: goodPupil)
        teacher.addObserver(observer: badPupil)
        teacher.homeWork = "1+1"
        
    }
}

// MARK: - Example №1 -

/*
 У нас есть учитель, который раздает дз и ученики которые его принимают в момент, когда учитель его сделал и отправил
 */


// MARK: protocols

fileprivate protocol Subject { // за кем наблюдают
    func addObserver(observer: PropertyObserver)
    func remove(observer: PropertyObserver)
    func notify(withString string: String)
}

fileprivate protocol PropertyObserver { // объекты, которые наблюдают
    var homeWork: String { get set }
    func didGet(newTask task: String)
    func doHomeWork(homeWork: String)
}

extension PropertyObserver {
    func didGet(newTask task: String) {
        print("new homework to be done")
        doHomeWork(homeWork: task)
    }
}

// MARK: classes

fileprivate class Teacher: Subject {
    
    var observerCollection = NSMutableSet()
    var homeWork = "" {
        didSet {
            print("teacher generate homework = \(homeWork)")
            notify(withString: homeWork)
        }
    }
    
    func addObserver(observer: PropertyObserver) {
        observerCollection.add(observer)
    }
    
    func remove(observer: PropertyObserver) {
        observerCollection.remove(observer)
    }
    
    func notify(withString string: String) {
        for observer in observerCollection {
            guard let observer = observer as? PropertyObserver else { continue }
            observer.didGet(newTask: string)
        }
    }
    
}

fileprivate class GoodPupil: NSObject, PropertyObserver  {
    
    var homeWork = ""
    
    func doHomeWork(homeWork: String) {
        self.homeWork = homeWork + " is done"
        print("\(GoodPupil.self)'s homework = '\(self.homeWork)'")
    }
    
}

fileprivate class BadPupil: NSObject, PropertyObserver  {
    
    var homeWork = ""
    
    func doHomeWork(homeWork: String) {
        self.homeWork = "fuck do it:" + "" + homeWork
        print("\(BadPupil.self)'s homework = '\(self.homeWork)'")
    }
    
}



