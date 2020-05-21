import Foundation


// MARK: - Theory
/*
 Паттерн проектирования Одиночка предоставляет гарантию того, что у класса есть только один экземпляр, а также предоставляет глобальную точку доступа. Да, Одиночка решает сразу несколько проблем проектирования. Очень часто этот паттерн проектирования применяется для классов, которые предоставляют доступ к базам данных, API и др.
 
 Когда применять Одиночку?
 
 ● Если в программе должен быть один экземпляр некоторого класса, доступный всем клиентам.
 ● Если необходим больший контроль над глобальными переменными.
 Как применять Одиночку?
 1. Создать статическую константу, которая будет содержать в себе инициализированный экземпляр класса.
 2. Сделать конструктор приватным.
 Плюсом данного паттерна является то, что он обеспечивает отложенную инициализацию, однако у него большое количество минусов: одиночка нарушает принцип единственной обязанности класса, создает проблемы при работе с мультипоточностью, усложняет проведение юнит-тестирования, может маскировать плохой дизайн.
 */
// MARK: - Test

class Singleton {
    
    static func testExampleSafe() {
        print("putMoneyFromFirstPartOfCode + 99")
        putMoneyFromFirstPartOfCode()
        print("putMoneyFromSecondPartOfCode + 50")
        putMoneyFromSecondPartOfCode()
        
        print("Money in safe \(Safe.sharedInstance.money)")
    }
    
    private static func putMoneyFromFirstPartOfCode() {
        Safe.sharedInstance.money += 99
    }
    private static func putMoneyFromSecondPartOfCode()  {
        Safe.sharedInstance.money += 50
    }
    
}

// MARK: - Example №1 - Safe

/*
 у нас есть сейф с деньгами, нам нужно класть в этот сейф деньги из разных участков программы
 */

// MARK: classes

fileprivate class Safe {
    
    static let sharedInstance = Safe()
    private init() {}
    
    var money = 0
    
}
