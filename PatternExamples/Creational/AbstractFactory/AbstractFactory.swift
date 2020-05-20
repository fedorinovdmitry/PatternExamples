import Foundation


// MARK: - Theory
/*
 Паттерн Абстрактная фабрика позволяет создать целое семейство связанных между собой объектов без необходимости привязывания к конкретным классам. Он очень похож на фабричный метод, но, в отличие от последнего, абстрактная фабрика создает только объекты, связанные между собой по некоторому признаку.
 Отличия от фабричного метода:
    -Фабричный метод создает объекты, которые относятся к одному и тому же типу, а абстрактная фабрика может создавать независимые объекты
    -Добавление нового объекта приведет к необходимости изменения интерфейса фабрики, а в Фабричном методе достаточно просто добавить процесс создания нового объекта.  
 Когда применять Абстрактную фабрику?
 ● В случаях, когда программа должна работать с несколькими видами связанных друг с другом объектов.
 ● Если в программе применяется Фабричный метод, но нововведения приведут к добавлению новых типов объектов.
 Как применять Абстрактную фабрику?
 1. Распределить все объекты по группам («семействам»).
 2. Создать абстрактные классы, которые смогут охарактеризовать каждую группу объектов.
 3. Создать общий интерфейс, который сможет объединить все Фабрики.
 4. Создание конкретных Фабрик. Фабрика создается для каждой группы объектов.
 5. Создается код для инициализации Фабрик.
 6. Все вызовы конструкторов заменяются на вызовы нужных Фабрик.
 Абстрактная фабрика позволяет избавиться от жесткой зависимости между всеми компонентами программы, разделяет ответственность между классами, дает возможность проектирования семейств объектов, при этом гарантируя их сочетаемость. Однако, за всеми плюсами скрывается один большой недостаток ​– при применении данного паттерна проектирования значительно усложняется код программы за счет увеличения количества дополнительных классов.
 */

// MARK: - Test

class AbstractFactory {
    
    static func testExampleOfCarsAndBus() {
        
        let sizeVehicleFactory = SizeVehiclesFactory()
        let bigVehiclesFactory = sizeVehicleFactory.produceBigVehiclesFactory()
        let littleVehiclesFactory = sizeVehicleFactory.produceLittleVehiclesFactory()
        
        print("big factory start work:")
        let _ = bigVehiclesFactory.produceBus()
        let _ = bigVehiclesFactory.produceCar()
        
        print("little factory start work:")
        let _ = littleVehiclesFactory.produceBus()
        let _ = littleVehiclesFactory.produceCar()
    }
    
    
}

// MARK: - Example №1 -

/*
В данном примере у нас есть большие грузовики, маленькие грузовики, большие и маленькие машины. Для использования абстрактной фабрики нужно выделить группу классов по какой-то характеристике и создать абстракный класс который будет охарактеризовывать данную группу, в нашем случае мы выделим группу транспорта согласно их размеру и создадим фабрику, которая будет создавать маленький транспорт и отдельную фабрику для создания большого транспорта. А так же выделим еще одну абстрактную фабрику которая будет создавать другие фабрики по производству транспорта по разным критериям, тем самым получая иерахическое представление, которое позволит гибко и легко добавлять нам любой вид транспорта и выделять его по любой характеристики.
 
 */


// MARK: protocols

fileprivate protocol VehiclesFactory {
    func produceLittleVehiclesFactory() -> Factory
    func produceBigVehiclesFactory() -> Factory
}

fileprivate protocol Factory {
    func produceBus() -> Bus
    func produceCar() -> Car
}

fileprivate protocol Car {
    func driveCar()
}

fileprivate protocol Bus {
    func driveBus()
}

// MARK: classes

fileprivate class SizeVehiclesFactory: VehiclesFactory {
    
    func produceLittleVehiclesFactory() -> Factory {
        return LittleSizeFactory()
    }
    
    func produceBigVehiclesFactory() -> Factory {
        return BigSizeFactory()
    }
}

fileprivate class LittleSizeFactory: Factory {
    func produceBus() -> Bus {
        print("Little bus is created")
        return LittleSizeBus()
    }
    
    func produceCar() -> Car {
        print("Little car is created")
        return LittleSizeCar()
    }
}

fileprivate class BigSizeFactory: Factory {
    func produceBus() -> Bus {
        print("Big bus is created")
        return BigSizeBus()
    }
    
    func produceCar() -> Car {
        print("Big car is created")
        return BigSizeCar()
    }
}

fileprivate class LittleSizeCar: Car {
    func driveCar() {
        print("Drive litte size car")
    }
}

fileprivate class BigSizeCar: Car {
    func driveCar() {
        print("Drive middle size car")
    }
}

fileprivate class LittleSizeBus: Bus {
    func driveBus() {
         print("Drive little size bus")
    }
}

fileprivate class BigSizeBus: Bus {
    func driveBus() {
        print("Drive big size bus")
    }
}


