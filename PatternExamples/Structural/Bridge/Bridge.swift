import Foundation


// MARK: - Theory
/*
 Мост — это структурный паттерн, который разделяет бизнес-логику или большой класс на несколько отдельных иерархий, которые потом можно развивать отдельно друг от друга.
 Одна из этих иерархий (абстракция) получит ссылку на объекты другой иерархии (реализация) и будет делегировать им основную работу. Благодаря тому, что все реализации будут следовать общему интерфейсу, их можно будет взаимозаменять внутри абстракции.
 
 Когда применять Мост?
 ● Есть общий класс, у которого несколько возможных реализаций.
 ● Есть необходимость расширения класса в двух независимых плоскостях.
 ● Необходимо изменять реализацию во время выполнения программы.

 Как применять Мост?
 1. Определить, есть ли среди классов проекта такие, которые относятся к разным измерениям – интерфейс и реализация.
 2. Обдумать необходимый функционал и на его основе создать класс абстракции.
 3. Определить, что могут делать все платформы, и создать общий интерфейс реализации.
 4. Для всех видов создать конкретные реализации, которые будут иметь общий интерфейс.
 5. Добавить в класс абстракции ссылку на объект из иерархии реализации.
 6. Для каждого варианта абстракции необходимо создать свой подкласс.
 7. Клиент должен подать объект реализации в конструктор абстракции, чтобы связать их воедино. После этого можно свободно применять объект абстракции.
 Мост позволяет реализовать принцип открытости/закрытости, скрыть некоторые детали реализации, но увеличивает сложность программы.
 */
// MARK: - Test

class Bridge {

    static func testExample() {
        
        let tv = TV()
        
        let remote = Remote(device: tv)
        remote.togglePower()
        remote.setChanel(chanel: 32)
        remote.chanelUp()
        remote.volumeUp()
        remote.volumeUp()
        tv.prinDescription()
        
        let radio = Radio()
        remote.setNew(device: radio)
        remote.togglePower()
        remote.setChanel(chanel: 100)
        remote.chanelUp()
        remote.volumeUp()
        remote.volumeUp()
        remote.mute()
        remote.togglePower()
        radio.prinDescription()
    }

}

// MARK: - Example №1 -

/*
В этом примере Мост разделяет монолитный код приборов и пультов на две части: приборы (выступают реализацией) и пульты управления ими (выступают абстракцией).
 Класс пульта имеет ссылку на объект прибора, которым он управляет. Пульты работают с приборами через общий интерфейс. Это даёт возможность связать пульты с различными приборами.
Сами пульты можно развивать независимо от приборов. Для этого достаточно создать новый подкласс абстракции. Вы можете создать как простой пульт с двумя кнопками, так и более сложный пульт с тач-интерфейсом.
Клиентскому коду остаётся выбрать версию абстракции и реализации, с которым он хочет работать, и связать их между собой.
 
 
 */


// MARK: protocols

// Все устройства имеют общий интерфейс. Поэтому с ними может
// работать любой пульт.
fileprivate protocol Device {
    var isEnabled: Bool { get }
    var volume: Int { get }
    var activeChanel: Int { get }
    
    func enable()
    func disable()
    func setVolume(value: Int)
    func setChanel(chanel: Int)
    
}
extension Device {
    func prinDescription() {
        let deviceType = type(of: self)
        let strEnable = isEnabled ? "turn on" : "turn off"
        print("\(deviceType) is \(strEnable), volume is \(volume), active channel is \(activeChanel)")
    }
}

// MARK: classes

// Класс пультов имеет ссылку на устройство, которым управляет.
// Методы этого класса делегируют работу методам связанного устройства.
fileprivate class Remote {
    
    private var device: Device
    
    init(device: Device) {
        self.device = device
    }
    
    func setNew(device: Device) {
        self.device = device
    }
    
    func togglePower() {
        if device.isEnabled {
            device.disable()
        } else {
            device.enable()
        }
    }
    
    func volumeUp() {
        device.setVolume(value: device.volume + 10)
    }
    func volumeDown() {
        device.setVolume(value: device.volume - 10)
    }
    func chanelUp() {
        device.setChanel(chanel: device.activeChanel + 1)
    }
    func chanelDown() {
        device.setChanel(chanel: device.activeChanel - 1)
    }
    
}
// Вы можете расширять класс пультов, не трогая код устройств.
extension Remote {
    func mute() {
        device.setVolume(value: 0)
    }
    func setChanel(chanel: Int) {
        device.setChanel(chanel: chanel)
    }
}

// Rаждое устройство имеет особую реализацию.
fileprivate class TV: Device {
    var isEnabled: Bool = false
    
    var volume: Int = 0
    
    var activeChanel: Int = 1
    
    func enable() {
        //какая то сложная процедура включения
        isEnabled = true
    }
    
    func disable() {
        isEnabled = false
    }
    
    func setVolume(value: Int) {
        switch value {
        case _ where value > 100:
            volume = 100
        case _ where value < 0:
            volume = 0
        default:
            volume = value
        }
    }
    
    func setChanel(chanel: Int) {
        if chanel > 0 {
          activeChanel = chanel
        }
    }
    
}

fileprivate class Radio: Device {
    var isEnabled: Bool = false
    
    var volume: Int = 0
    
    var activeChanel: Int = 300
    
    func enable() {
        isEnabled = true
    }
    
    func disable() {
        isEnabled = false
    }
    
    func setVolume(value: Int) {
        switch value {
        case _ where value > 100:
            volume = 100
        case _ where value < 0:
            volume = 0
        default:
            volume = value
        }
    }
    
    func setChanel(chanel: Int) {
        if chanel > 0 {
          activeChanel = chanel + 10 // тут сложный алгоритм подсчета частоты
        }
    }
    
}
