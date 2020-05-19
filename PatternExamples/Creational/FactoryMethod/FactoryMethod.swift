import Foundation


// MARK: - Theory
/*
 Паттерн проектирования Фабричный метод предоставляет подклассам интерфейс, который позволяет создавать экземпляры другого класса. Применение этого шаблона упрощает процесс создания абстрактных классов.
 Фабричный метод состоит из следующих компонентов:
 1. Общий интерфейс для всех объектов, которые может создать Фабричный метод.
 2. Сами объекты. Они могут отличаться по реализации, но у всех должен быть общий интерфейс.
 3. Фабричный метод. Метод или класс, который отвечает за создание объектов.
 4. Конкретные создатели. Не обязательны для применения, однако могут присутствовать. Они позволяют создавать экземпляр для одного конкретного объекта.

 Фабричный метод упрощает поддержку проекта в будущем, так как число видов создаваемых объектов со временем может увеличиваться. В таком случае необходимо будет создать новые классы для объектов и добавить их в Фабричный метод.

 Когда применять фабричный метод?
 ● Изначально неизвестны все возможные объекты, с которыми будет необходимо работать.
 ● Создается библиотека, и необходимо предоставить другим разработчикам возможность ее дальнейшего расширения.
 ● Нужно создать объекты, которые необходимо будет применять повторно, не создавая при этом новых экземпляров. (Примером являются файлы работы с базами данных или сетью. Готовые экземпляры можно хранить в классе фабрики и передавать при запросе.)
 Как применять фабричный метод?
 1. Все объекты приводятся к общему интерфейсу.
 2. В классе фабрики создается специальный метод, который на вход получает тип создаваемого объекта и возвращает общий интерфейс для всех объектов.
 3. Заменяются все участки кода, которые создают объект не через Фабричный метод.
 Фабричный метод позволяет не привязывать код к конкретным классам объектов, упрощает программу из-за переноса кода, отвечающего за создание, в отдельное место, упрощает добавление новых объектов.
 */

// MARK: - Test

class FactoryMethod {
    
    static func testExampleWithVehicles() {
        
        let car = CarFactory.sharedInstance.produse()
        car.drive()
        
        let bus = BusFactory.sharedInstance.produse()
        bus.drive()
        
        let truck = TruckFactory.sharedInstance.produse()
        truck.drive()
    }
    
}

// MARK: - Example №1 - Vehicles
/*
 Представим ситуацию, у нас автопарк грузовиков, и впроцессе написания программы мы создали 1000 экземпляров в разных местах, через какое-то время нам стало необходимо изменить инициализатор у грузовика -> представляем боль, вот для таких моментов используем фабрику.
 
 */


// MARK: protocol

fileprivate protocol Vehicle {
    func drive()
}

fileprivate protocol VehicleFactory {
    func produse() -> Vehicle
}
// MARK: classes

fileprivate class Car: Vehicle {
    func drive() {
        print("you drive Car")
    }
}

fileprivate class Bus: Vehicle {
    func drive() {
        print("you drive Bus")
    }
}

fileprivate class Truck: Vehicle {
    func drive() {
        print("you drive Truck")
    }
}

fileprivate class CarFactory: VehicleFactory {
    static let sharedInstance = CarFactory()
    private init() {}
    
    func produse() -> Vehicle {
        print("made a car")
        return Car()
    }
    
}

fileprivate class BusFactory: VehicleFactory {
    static let sharedInstance = BusFactory()
    private init() {}
    
    func produse() -> Vehicle {
        print("made a bus")
        return Bus()
    }
    
}

fileprivate class TruckFactory: VehicleFactory {
    static let sharedInstance = TruckFactory()
    private init() {}
    
    func produse() -> Vehicle {
        print("made a truck")
        return Truck()
    }
    
}
