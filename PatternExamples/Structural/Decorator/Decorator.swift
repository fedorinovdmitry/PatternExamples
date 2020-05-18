import Foundation


// MARK: - Theory
/*
 г)Декоратор (Decorator) – класс, который расширяет функционал другого класса без применения наследования.

 Наследование — это первое, что приходит в голову многим программистам, когда нужно расширить какое-то существующее поведение. Но механизм наследования имеет несколько досадных проблем.
 * Он статичен. Вы не можете изменить поведение существующего объекта. Для этого вам надо создать новый объект, выбрав другой подкласс.
 * Он не разрешает наследовать поведение нескольких классов одновременно. Из-за этого вам приходится создавать множество подклассов-комбинаций для получения совмещённого поведения.
 Одним из способов обойти эти проблемы является замена наследования агрегацией либо композицией . Это когда один объект содержит ссылку на другой и делегирует ему работу, вместо того чтобы самому наследовать его поведение. Как раз на этом принципе построен паттерн Декоратор.
 ￼
 Наследование против Агрегации.
 Декоратор имеет альтернативное название — обёртка. Оно более точно описывает суть паттерна: вы помещаете целевой объект в другой объект-обёртку, который запускает базовое поведение объекта, а затем добавляет к результату что-то своё.
 Оба объекта имеют общий интерфейс, поэтому для пользователя нет никакой разницы, с каким объектом работать — чистым или обёрнутым. Вы можете использовать несколько разных обёрток одновременно — результат будет иметь объединённое поведение всех обёрток сразу.
 
 Декоратор применяется для изменения или расширения функциональности объектов во время выполнения программы. К счастью, в Swift есть поддержка расширений (extension). Расширения дают возможность добавить в любой объект нужную функциональность без применения наследования.

 Когда применять Декоратор?
 ● Необходимо увеличить функционал для конкретного объекта.
 ● Нет возможности расширения функционала с помощью наследования.
 Как применять Декоратор?
 ● Убедиться в необходимости дополнения к объекту.
 ● Создать нужный функционал в расширении.
 ● Реализовать расширения на стороне клиента.
 Декоратор обладает более гибкой архитектурой, нежели наследование, позволяет добавлять функционал во время выполнения программы.

 
 */
// MARK: - Test

class Decorator {

    ///Example №1 - Porsche
    static func testExampleWithPorsche() {
        
        var porscheGarrage: [Porsche] = [Boxter(), Model911(), Panamera()]
        
        printPorsheArray(arr: porscheGarrage)
        
        print("set PremiumAudioSystem on all cars")// тем самым увел цена и описание
        for i in 0...porscheGarrage.count - 1 {
            porscheGarrage[i] = PremiumAudioSystem(dp: porscheGarrage[i])
        }
        
        printPorsheArray(arr: porscheGarrage)
        
        print("give 22 Wheels on Panamera and PanoramicSunRoof on Boxter")
        porscheGarrage[0] = PanoramicSunRoof(dp: porscheGarrage[0])
        porscheGarrage[2] = Wheels22(dp: porscheGarrage[2])
        
        printPorsheArray(arr: porscheGarrage)
    }
    
    private static func printPorsheArray(arr: [Porsche]) {
        for car in arr {
            car.getFullDescription()
        }
    }
    
    ///Example №2 - extension for Date
    static func testExampleWithExtensionDate() {
        print("print today date with 'dd MM yyyy' format")
        let date = Date()
        print(date.string())
    }

}

// MARK: - Example №1 - Porsche

/*
 Есть марка авто - Porsche и есть модели Boxter Panamera и 911, каждая модель может комплектоватся разными пакетами и приспособлениями. Например мы можем поставить крутую аудиосистему, панорамную крышу и 22 колеса, каждая модель порше может иметь разную комбинацию комплектаций и в зависимости от нее менять свои свойства, например цену, если использовать наследование получистся очень много реализаций:
 Porsche -> 911 -> standart
 Porsche -> 911 -> standart AudioSystema
 Porsche -> 911 -> standart AudioSystema 22wheels
 Porsche -> 911 -> standart AudioSystema Panorama
 Porsche -> 911 -> standart AudioSystema 22wheels Panorama
 и т.д.
 
 как мы используем Decorator или "оберку":
мы создадим проткол porche со свойствами цены и описания, создадим класс по каждой модели авто и подпишем на этот протокол, и создадим еще 1 абстрактынй класс модели PorshceDecorator, который будет принимать в себя любую модель porsch и как бы обертвовать эту модель комплектацией с помощью переопределения свойств и методов.
 
 */

// MARK: protocols
fileprivate protocol Porsche {
    func getPrice() -> Double
    func getDescription() -> String
}
extension Porsche {
    func getFullDescription() {
        let price = String(getPrice())
        print("\(getDescription()) and it price is \(price)")
    }
}


// MARK: classes
fileprivate class Boxter: Porsche {
    func getPrice() -> Double {
        return 80000
    }
    
    func getDescription() -> String {
        return "Porsche Boxter"
    }
    
}

fileprivate class Model911: Porsche {
    func getPrice() -> Double {
        return 120000
    }
    
    func getDescription() -> String {
        return "Porsche 911"
    }
    
}

fileprivate class Panamera: Porsche {
    func getPrice() -> Double {
        return 100000
    }
    
    func getDescription() -> String {
        return "Porsche Panamera"
    }
}

fileprivate class PorshceDecorator: Porsche { // абстрактный класс
    
    private let decoratedPorsche: Porsche
    required init(dp: Porsche) {
        self.decoratedPorsche = dp
    }
    
    func getPrice() -> Double {
        return decoratedPorsche.getPrice()
    }
    
    func getDescription() -> String {
        return decoratedPorsche.getDescription()
    }
    
}

fileprivate class PremiumAudioSystem: PorshceDecorator {
    required init(dp: Porsche) {
        super.init(dp: dp)
    }
    
    override func getPrice() -> Double {
        return super.getPrice() + 30000
    }
    override func getDescription() -> String {
        return super.getDescription() + " with PremiumAudioSystem"
    }
}

fileprivate class PanoramicSunRoof: PorshceDecorator {
    required init(dp: Porsche) {
        super.init(dp: dp)
    }
    
    override func getPrice() -> Double {
        return super.getPrice() + 20000
    }
    override func getDescription() -> String {
        return super.getDescription() + " with PanoramicSunRoof"
    }
}

fileprivate class Wheels22: PorshceDecorator {
    required init(dp: Porsche) {
        super.init(dp: dp)
    }
    
    override func getPrice() -> Double {
        return super.getPrice() + 10000
    }
    override func getDescription() -> String {
        return super.getDescription() + " with 22 Wheels"
    }
}


// MARK: - Example №2 - extension for Date

/*
 Добавим в Date функционал для конвертирования даты в строку.
 */

extension Date {
    func string(format: String = "dd MM yyyy") -> String{
        let foramter = DateFormatter()
        foramter.dateFormat = format
        return foramter.string(from: self)
    }
}

