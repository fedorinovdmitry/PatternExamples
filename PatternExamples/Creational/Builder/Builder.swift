import Foundation


// MARK: - Theory
/*
 Строитель — это порождающий паттерн проектирования, который позволяет создавать сложные объекты пошагово. Строитель даёт возможность использовать один и тот же код строительства для получения разных представлений объектов.

 Когда применять Строителя?
 ● Если у объекта в конструкторе большое количество опциональных параметров.
 ● Если программа должна создавать различные представления одного объекта.
 ● Если необходимо конвертировать одну сущность в множество других.
 Как применять Строителя?
 1. Выявить основные шаги для создания объекта.
 2. Создать общего Строителя и определить для него основные шаги.
 3. Создать конкретных Строителей и конфигурации параметров.
 4. Создать управляющий класс (Директор). В результате его деятельности будут создаваться
 различные конфигурации объектов.
 5. Для создания объекта необходимо вызывать метод объекта Директора.
 Строитель позволяет пошагово создавать объекты, применять один и тот же код для конфигурирования различных объектов, изолирует сложный код создания объекта от бизнес-логики. Как и в случае Абстрактной фабрики, применение Строителя приводит к усложнению программы за счет увеличения числа классов.
 */
// MARK: - Test

class Builder {

    static func testExampleWithBurgers() {
        //создадим классический бургер без помощи билдера
        let _ = Hamburger(meat: .beef,
                                      bread: .wheat,
                                      sauces: [Sauce(ingedients: [.egg, .mustard]), Sauce(ingedients: [.tomato])],
                                      additionalIngredients: [.salad, .onion, .cheese])
        //Инициализация объекта выглядит сложно. А еще представьте, что бургер создается пошагово: например, один объект (условно — работник кухни) добавляет в него мясо, другой (соус-шеф) создает композицию соусов и так далее. Теперь используем builder
        
        let director = HamburegerDirector()
        let classicBureger = director.makeHamburger(with: .classicBurger)
        print("Classic \(classicBureger)")
        let chikenChiliSpecial = director.makeHamburger(with: .chikenChiliSpecial)
        print("ChikenChiliSpecial \(chikenChiliSpecial)")
        
        let myPPBurgerBuilder = HamburgerBuilder()
        myPPBurgerBuilder.setMeat(.vegeterianTofu)
        myPPBurgerBuilder.setBread(.rye)
        myPPBurgerBuilder.addSauce(Sauce(ingedients: [.tomato]))
        myPPBurgerBuilder.addAditionalIngredient(.salad)
        myPPBurgerBuilder.addAditionalIngredient(.onion)
        let myPPBurger = director.makeHamburger(with: myPPBurgerBuilder)
        print("MyPP \(myPPBurger)")
        
        
    }

}

// MARK: - Example №1 -

/*
 Для примера рассмотрим приготовление бургера. Бургер будет собираться из хлеба, мяса и других ингредиентов. Бургеров будет много типов
 */


// MARK: protocols


// MARK: classes

fileprivate enum Ingredient: String {
    case egg
    case tomato
    case chili
    case potato
    case mustard
    case vasabi
    case cheese
    case onion
    case salad
}

fileprivate enum Meat {
    case chiken
    case beef
    case pork
    case vegeterianTofu
}

fileprivate enum Bread {
    case wheat
    case rye
}

fileprivate struct Sauce: Hashable {
    var ingedients: Set<Ingredient>
}

fileprivate struct Hamburger{
    var meat: Meat
    var bread: Bread
    var sauces: Set<Sauce>
    var additionalIngredients: Set<Ingredient>
    
}
extension Hamburger: CustomStringConvertible {
    var description: String {
        var saucesStr = ""
        var ingredientStr = ""
        sauces.forEach{ saucesStr += "Sauce: "
            $0.ingedients.forEach{ saucesStr += $0.rawValue + "\n"} }
        additionalIngredients.forEach { ingredientStr += "ingredient: " + $0.rawValue + "\n"}
        return "\(type(of: self)) with:\n\(meat)\n\(bread)\n" + saucesStr + ingredientStr
    }
}

fileprivate class HamburgerBuilder {
    private(set) var meat: Meat = .beef
    private(set) var bread: Bread = .wheat
    private(set) var sauces: Set<Sauce> = []
    private(set) var additionalIngredients: Set<Ingredient> = []
    
    func build() -> Hamburger {
        return Hamburger(meat: meat, bread: bread, sauces: sauces, additionalIngredients: additionalIngredients)
    }
    
    func setMeat(_ meat: Meat) {
        self.meat = meat
    }
    
    func setBread(_ bread: Bread) {
        self.bread = bread
    }
    
    func addSauce(_ sauce: Sauce) {
        sauces.insert(sauce)
    }
    
    func addAditionalIngredient(_ ingredient: Ingredient) {
        additionalIngredients.insert(ingredient)
    }
}

fileprivate class HamburegerDirector {
    
    enum HamburgerType {
        case classicBurger
        case chikenChiliSpecial//...
    }
    
    func makeHamburger(with type: HamburgerType) -> Hamburger {
        switch type {
        case .classicBurger:
            return createClassicBurger()
        case .chikenChiliSpecial:
            return createChikenChiliSpecial()
        }
    }
    
    func makeHamburger(with customBuilder: HamburgerBuilder) -> Hamburger {
        return customBuilder.build()
    }

    private func createClassicBurger() -> Hamburger {
        let builder = HamburgerBuilder()
        builder.setMeat(.beef)
        builder.setBread(.wheat)
        builder.addSauce(Sauce(ingedients: [.egg, .mustard]))
        builder.addSauce(Sauce(ingedients: [.tomato]))
        builder.addAditionalIngredient(.salad)
        builder.addAditionalIngredient(.onion)
        builder.addAditionalIngredient(.cheese)
        return builder.build()
    }
    
    private func createChikenChiliSpecial() -> Hamburger {
        let builder = HamburgerBuilder()
        builder.setMeat(.chiken)
        builder.setBread(.rye)
        builder.addSauce(Sauce(ingedients: [.chili, .tomato]))
        builder.addAditionalIngredient(.vasabi)
        builder.addAditionalIngredient(.potato)
        return builder.build()
    }
    
    
}
