import Foundation


// MARK: - Theory
/*
 Адаптер конвертирует интерфейс класса таким образом, чтобы получился необходимый класс. Другими словами, он обеспечивает совместную работу классов с несовместимыми интерфейсами. Паттерн состоит из трех составных частей: цель, адаптер и адаптируемый.
 Примерами Адаптера из жизни являются все разновидности переходников. Они адаптируют один интерфейс к возможностям другого интерфейса.


 Когда применять Адаптер?
 ● Если необходимо использовать существующий класс, но его интерфейс не соответствует остальному коду приложения.
 ● Требуется применять несколько существующих подклассов, но в них отсутствует необходимая общая функциональность, при этом расширение суперкласса невозможно.
 Как применять Адаптер?
 1. Убедиться, что в программе есть несколько классов с неподходящими интерфейсами.
 2. Создать общий клиентский интерфейс, с помощью которого классы смогут использовать
 сторонний класс.
 3. Создать класс для адаптера, реализуя этот интерфейс.
 4. Поместить в адаптер объект служебного класса.
 5. Реализовать необходимые методы клиентского интерфейса в адаптере.
 6. Приложение должно применять адаптер только с помощью клиентского интерфейса, так как это позволит в будущем легко добавлять новые адаптеры.
 Как и у многих паттернов проектирования, у Адаптера существует минус – усложнение программы за счет введения дополнительных классов. С другой стороны, Адаптер помогает скрыть от клиента подробности преобразования различных интерфейсов.
 */
// MARK: - Test

class Adapter {

    static func testExampleWithPredator() {
        
        let wolf: Predator = Wolf()
        let lion = Lion()
        
        let lionAdapter = LionAdapter(lion: lion)
        
        predatorDiscription(predator: wolf)
        print("-----")
        predatorDiscription(predator: lionAdapter)
    }

    private static func predatorDiscription(predator: Predator) {
        let str = String(describing: predator.self)
        print("it is: \(takeTypeName(str:str))")
        predator.scaryVoice()
        predator.hunting()
    }
    
    private static func takeTypeName(str: String) -> String {
        var result = ""
        for i in str.reversed() {
            if i == "." {
                break
            }
            result += String(i)
        }
        return String(result.reversed())
    }
    
}

// MARK: - Example №1 -

/*
 у нас есть класс хищники и метод который работает только с хищниками. Нам необходимо сделать так чтобы новый класс леф тоже можно было использовать в этом методе, но при этом мы не хотим хоть как-то менять класс льва, потому что леф царь зверей и он никаким протколам и классам не подчиняется, поэтому применем паттерн адаптер
 */


// MARK: protocols
///Хищники  (Target)
fileprivate protocol Predator {
    func scaryVoice()
    func hunting()
}

// MARK: classes
///Типичный представитель хищников - Волк
fileprivate class Wolf: Predator {
    func scaryVoice() {
        print("АААУууууууууууууу")
    }
    
    func hunting() {
        print("hunting only flock, very fast and dangerous")
    }
}

///Король леф, которому пофиг на протоколы и ограничения (Adaptee)
fileprivate class Lion {
    func growl() {
        print("Аааааарррррр-рарраар-арар")
    }
    func kingHunting() {
        print("hunting like a king, very strong fierce")
    }
    
}

/// Adapter
fileprivate class LionAdapter: Predator {
    
    var lion: Lion
    
    init(lion: Lion) {
        self.lion = lion
    }
    
    func scaryVoice() {
        lion.growl()
    }
    
    func hunting() {
        lion.kingHunting()
    }
    
}
