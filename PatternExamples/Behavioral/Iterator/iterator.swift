import Foundation


// MARK: - Theory
/*
 Итератор — это поведенческий паттерн проектирования, который даёт возможность последовательно обходить элементы составных объектов, не раскрывая их внутреннего представления.Когда применять Итератор?
 ● Необходимо скрыть детали сложной структуры.
 ● Нужен способ обхода сложной структуры.
 Как применять Итератор?
 1. Создать класс для Итератора.
 2. Инициализировать Итератор.
 3. Применить Итератор.
 Итератор упрощает классы хранения данных, предоставляет возможность обхода сложной структуры данных, позволяет перемещаться по структуре в разных направлениях.
 
 */
// MARK: - Test

class Iterator {

    static func testExampleCarHistory() {
        
        let car = Car()
        
        print("car is sequence go to use 'for in' ")
        for driver in car {
            print(driver.name)
        }
        
        print("use badDriver iterator")
        printDriverArray(arr: car.badDriveriterator.allDriver())
        print("use goodDriver iterator")
        printDriverArray(arr: car.goodDriveriterator.allDriver())
        
    }
    private static func printDriverArray(arr: [Driver]) {
        for elem in arr {
            print(elem.name)
        }
    }

}

// MARK: - Example №1 -

/*
 есть авто с историей владения, все водители делятся на "хороших" и "плохих" используем паттерн Итератор для описания логики перебора масива владельцев
 
 */

// MARK: classes
fileprivate class Driver {
    let name: String
    let isGood: Bool
    
    init(name: String, isGood: Bool) {
        self.name = name
        self.isGood = isGood
    }
}
fileprivate class Car {
    
    var goodDriveriterator: GoodDriverIterator {
        return GoodDriverIterator(drivers: drivers)
    }
    var badDriveriterator: BadDriverIterator {
        return BadDriverIterator(drivers: drivers)
    }
    
    private let drivers = [Driver(name: "Tema", isGood: true),
                           Driver(name: "Diman", isGood: false),
                           Driver(name: "Dimich", isGood: true),
                           Driver(name: "Nastya", isGood: false),
                           Driver(name: "Tanya", isGood: false),
                           Driver(name: "Pedobir", isGood: true)]
    
}
extension Car: Sequence {
    func makeIterator() -> DriverIterator {
        return DriverIterator(drivers: drivers)
    }
}

fileprivate class DriverIterator: IteratorProtocol {
    typealias Element = Driver
    
    private let drivers: [Driver]
    private var current = 0
    
    init(drivers: [Driver]) {
        self.drivers = drivers
    }
    
    func next() -> Driver? {
        defer { current+=1 }// вызывается в конце области видимости
        return drivers.count > current ? drivers[current] : nil
    }
    func allDriver() -> [Driver] {
        return drivers
    }
}

fileprivate class GoodDriverIterator: DriverIterator {
    override init(drivers: [Driver]) {
        super.init(drivers: drivers.filter{ $0.isGood })
    }
}

fileprivate class BadDriverIterator: DriverIterator {
    override init(drivers: [Driver]) {
        super.init(drivers: drivers.filter{ $0.isGood == false })
    }
}
