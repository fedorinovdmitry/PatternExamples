import Foundation


// MARK: - Theory
/*
 Прототип — это порождающий паттерн проектирования, который позволяет копировать объекты, не вдаваясь в подробности их реализации.
 
 Когда применять Прототип?
 ● Когда код не должен зависеть от создаваемых объектов.
 ● Если необходимо избежать увеличения иерархии классов объектов, причем объекты
 отличаются только внутренним состоянием.
 Как применять Прототип?
 1. Подписать объект на протокол NSCopying.
 2. Реализовать методы протокола NSCopying.
 3. Изменить копирование объектов на object.copy().
 
 */
// MARK: - Test

class Prototype {

    static func testExampleWithMonster() {
        
        // работа с сылочным типом без протипа
        print("работа с сылочным типом без протипа")
        let mainOrk = Monster(name: "mainOrk", health: 1000, damage: 10)
        let ork1 = Monster(name: "ork", health: 100, damage: 2)
        let expectedBeOrk2 = ork1
        mainOrk.hitMonster(ork1)
        print("ork1: \(ork1.health)") // 90
        print("ork1: \(expectedBeOrk2.health)") // 90
        print("/n")
        
        //используем NSCopying
        print("используем NSCopying")
        let goblin1 = Monster(name: "goblin", health: 50, damage: 1)
        let goblin2 = goblin1.copy() as! Monster
        mainOrk.hitMonster(goblin1)
        print("goblin1: \(goblin1.health)") // 40
        print("goblin2: \(goblin2.health)") // 50
        print("/n")
        /*
         1. copy(with zone: NSZone? = nil) ​возвращает ​Any.​ Поэтому при копировании пришлось принудительно приводить скопированный объект к нужному типу: ​as! Monster.
         2. Мы применили ​monster.copy(),​не передав параметр ​zone,​потому что по умолчанию он ​nil.​В принципе, так и нужно делать, однако все еще остается возможность передать ​NSZone.​Это тоже класс objective-c. Раньше он использовался для низкоуровневого управления памятью освобождаемых объектов. С появлением ARC и тем более в языке Swift не нужно пользоваться этим объектом. Поэтому для нас это ничего не значащий параметр, засоряющий код.
         Исправить эти минусы поможет собственная реализация протокола ​Copying (да, нативного решения на чистом Swift, к сожалению, нет).
         */
        
        //используем свою реализацию Прототипа
        print("используем свою реализацию Прототипа")
        let urukHay1 = MyMonster(name: "urukHay", health: 150, damage: 15)
        let urukHay2 = urukHay1.copy()
        urukHay2.hitMonster(urukHay1)
        print("urukHay1: \(urukHay1.health)") // 135
        print("urukHay2: \(urukHay2.health)") // 150
        
        
    }

}

// MARK: - Example №1 -

/*
 допустим мы создаем игру, у нас есть класс Монстр, экземляр этого класса будет какой-то конткретный монстр, например орк и у него будет конкретный набор характеристик. Для того чтобы сделать отряд орков нам придется для каждого члена отряда создать новый объект Монстр и присваивать ему конткретные значения, но мы можем использовать паттерн прототип и просто копировать орка столько раз, сколько нам необходимо.
 
 данный пример мы реализуем 2 способами:
 -с помощью станадртной реализации Prototype в iOS, используя NSCopying
 -сделаем свой вариант используя протокол
 */

// MARK: NSCopying

fileprivate class Monster: NSCopying {
    
    let name: String
    var health: Int
    let damage: Int
    
    init(name: String, health: Int, damage: Int) {
        self.name = name
        self.health = health
        self.damage = damage
    }
    
    func hitMonster(_ monster: Monster) {
        monster.health -= self.damage
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Monster(name: self.name,
                       health: self.health,
                       damage: self.damage)
    }
}

// MARK: Prototype without ObjC

protocol Copyable {
    init(_ prototype: Self)
}
extension Copyable {
    func copy() -> Self {
        return type(of: self).init(self)
    }
}

fileprivate class MyMonster: Copyable {

    let name: String
    var health: Int
    let damage: Int
    
    init(name: String, health: Int, damage: Int) {
        self.name = name
        self.health = health
        self.damage = damage
    }
    
    required init(_ prototype: MyMonster) {
        self.name = prototype.name
        self.health = prototype.health
        self.damage = prototype.damage
    }
    
    func hitMonster(_ monster: MyMonster) {
        monster.health -= self.damage
    }
}


