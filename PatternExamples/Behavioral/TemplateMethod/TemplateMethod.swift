
import Foundation


// MARK: - Theory
/*
 Паттерн ​Template method (шаблонный метод) — поведенческий паттерн проектирования. Он в обязательном порядке использует наследование. Базовый класс определяет набор методов, которые могут быть реализованы в наследниках, и определяет порядок их вызовов при работе этого объекта. Наследники могут переопределять методы и добавлять в них свою функциональность.
 Это очень простой и интуитивный паттерн. Проиллюстрируем его на примере из жизни. Чтобы купить мороженое, вам нужно:
 1. Дойти до магазина.
 2. Выбрать мороженое.
 3. Расплатиться.
 Это общие шаги. Именно в таком порядке они вызываются в базовом классе. Базовый класс также определяет все три метода, но не будет содержать никакой реализации.
 Конкретная реализация будет находиться в наследниках этого базового класса. Какой она может быть? Например, сценарий такой: вы находитесь дома. Тогда реализация первого метода (дойти до магазина) будет содержать конкретный супермаркет, который ближе к дому. Реализация второго метода (выбрать мороженое) может состоять в том, что вы выбираете свой любимый пломбир и говорите об этом продавцу. А реализация третьего метода — отдаете рубли. А если вы находитесь в другой стране, то реализация первого метода может также содержать непростой выбор магазина по карте. Реализация второго и третьего метода тоже будет отличаться, так как сказать продавцу о своем выборе нужно на другом языке и отдать деньги в другой валюте.

 В iOS SDK шаблонный метод, наряду с паттернами делегат и синглтон, применяется достаточно часто. Главный пример — UIViewController. У этого класса есть методы, открытые к переопределению наследниками, — они обычно называются методами жизненного цикла вью-контроллера.
 */
// MARK: - Test

class TemplateMethod {

    static func testExampleDriveTransport() {
        let car = Car()
        car.startVehicle()
        let bike = Bycycle()
        bike.startVehicle()
    }

}

// MARK: - Example №1 -

/*
 Шаблонный алгоритм для управления транспортом
 */


// MARK: protocols
fileprivate protocol DriveVehicle {
    func startVehicle()
    func closeTheDoor()
    func haveASeat()
    func useProtection()
    func lookAtTheMirror()
    func turnSignal()
    func driveForward()
}
extension DriveVehicle {
    
    func startVehicle() {
        haveASeat()
        closeTheDoor()
        useProtection()
        lookAtTheMirror()
        turnSignal()
        driveForward()
    }
//    func haveASeat() {
//        preconditionFailure("this method should be overriden")
//    }
    func closeTheDoor() {
        
    }
//    func useProtection() {
//        preconditionFailure("this method should be overriden")
//    }
//    func lookAtTheMirror() {
//        preconditionFailure("this method should be overriden")
//    }
//    func turnSignal() {
//        preconditionFailure("this method should be overriden")
//    }
//    func driveForward() {
//        preconditionFailure("this method should be overriden")
//    }
    
}

// MARK: classes


fileprivate class Bycycle: DriveVehicle {
    
    func haveASeat() {
        print("sit down on a bicycle seat")
    }
    func useProtection() {
        print("wear a helmet")
    }
    func lookAtTheMirror() {
        print("look at the little mirror")
    }
    func turnSignal() {
        print("show a left hand")
    }
    func driveForward() {
        print("pedal")
    }
}
fileprivate class Car: DriveVehicle {
    
    func haveASeat() {
        print("sit down on a car seat")
    }
    func closeTheDoor() {
        print("close drivaer's door")
    }
    func useProtection() {
        print("fasten seat belt")
    }
    func lookAtTheMirror() {
        print("look at the rearview mirror")
    }
    func turnSignal() {
        print("turn on left turnlight")
    }
    func driveForward() {
        print("push pedal")
    }
}


