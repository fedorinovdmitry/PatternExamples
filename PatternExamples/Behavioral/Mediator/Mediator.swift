
import Foundation


// MARK: - Theory
/*
Паттерн Посредник позволяет уменьшить связанность классов между собой путем определения этих связей в отдельном классе-посреднике. Этот шаблон проектирования позволяет строить удобные и правильные связи классов между собой.
 
 Сама эта концепция активно используется в ООП и в iOS-разработке. Вью-контроллер — посредник между вью (отображением) и моделью, в архитектуре VIPER это слой presenter, NotificationCenter — посредник между передатчиком данных (тем, кто постит нотификацию) и получателем (обсервером).
 
 Когда применять Посредника?
 ● Если существует множество связей между классами, что приводит к невозможности их изменения.
 ● Когда класс невозможно использовать повторно из-за того, что он связан с множеством других.
 Как применять Посредника?
 1. Определить классы с большим количеством связей.
 2. Создать общий интерфейс для Посредников.
 3. Создать общий класс для всех объектов, которыми будет управлять Посредник.
 4. Реализовать конкретных Посредников на основе интерфейса Посредников.
 5. Реализовать конкретные объекты, которыми будет управлять Посредник, на основе общего
 класса.
 6. Связать созданные объекты с Посредником.
 Посредник позволяет решить проблемы множества зависимых связей между классами, упрощает их взаимодействие и централизует управление этими классами в одном месте. Однако использование одного Посредника может привести к тому, что он будет отвечать за все связи в проекте и станет громоздким.
 */
// MARK: - Test

class Mediator {

    static func testExampleWithSensors() {
        
        let iphone: SensorMediator = Smartphone()
        let gps = GPS(device: iphone)
        let radar = Radar(device: iphone)
        let camera = Camera(device: iphone)
        
        iphone.addSensor(sensor: gps)
        iphone.addSensor(sensor: radar)
        iphone.addSensor(sensor: camera)
        
        gps.send(message: "lon: 20, lat: 40")
        
    }

}

// MARK: - Example №1 -

/*
 Рассмотрим пример паттерна Посредник. Сейчас идет бурное развитие технологий, и в нашей жизни появляется большое количество различных технологических новшеств. Допустим, что у нас есть компьютер, который позволяет связать несколько датчиков между собой (радар, gps, камера).
 
 Как видно из примера, все Датчики, которые обрабатывает Компьютер, получили сообщение от Датчика gps с текущим местоположение

 */


// MARK: protocols


// MARK: classes

fileprivate protocol Sensor {
    func recieve(message: String)
}

fileprivate protocol SensorMediator {
    func addSensor(sensor: Sensor)
    func send(message: String, by sensor: Sensor)
}

fileprivate class SensorParrent {
    
    private var device: SensorMediator
    
    init(device: SensorMediator) {
        self.device = device
    }
    
    func send(message: String) {
        print("\(type(of: self)) sensor send: '\(message)'")
        self.device.send(message: message, by: self)
    }
    
}
extension SensorParrent: Sensor {
    func recieve(message: String) {
        print("\(type(of: self)) sensor is recieve: '\(message)'")
    }
}

fileprivate class GPS: SensorParrent {
    //реализация особеностей
}
fileprivate class Camera: SensorParrent {
    //реализация особеностей
}
fileprivate class Radar: SensorParrent {
    //реализация особеностей
}

fileprivate class Smartphone: SensorMediator {
    
    private var sensors = [Sensor]()
    
    func addSensor(sensor: Sensor) {
        sensors.append(sensor)
    }
    
    func send(message: String, by sensor: Sensor) {
        for s in sensors {
            let sType = type(of: s)
            let sensorType = type(of: sensor)
            if sType != sensorType {
                s.recieve(message: message)
            }
        }
    }
    
}
