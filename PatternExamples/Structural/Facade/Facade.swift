import Foundation


// MARK: - Theory
/*
 Паттерн проектирования Фасад позволяет скрыть множество интерфейсов за одним, что приводит к более простому использованию.
 
 Когда применять Фасад?
 ● Необходимо скрыть сложную реализацию и предоставить к ней простой интерфейс.
 ● Нужно разложить подсистему на отдельные слои.
 Как применять Фасад?
 1. Выяснить, возможно ли создать более простой интерфейс.
 2. Создать класс, который реализует этот интерфейс.
 3. Если ответственность Фасада начинает размываться, необходимо подумать о введении
 дополнительных Фасадов.
 Фасад уменьшает зависимость между подсистемой и клиентом, изолирует клиентов от прочих компонентов. Большим минусом может стать частое использование фасадов и вынесение всего функционала за них.
 */
// MARK: - Test

class Facade {

    static func testExample() {
        
        let superMarket = Supermarket()
        
        let packet = superMarket.buyProducts(products: [.meat(weight: 2.5),
                                           .beer(volume: 1),
                                           .fruit(weight: 3),
                                           .sweet(weight: 1.5),
                                           .bread(weight: 0.5)])
        
        print(packet)
        
    }

}

// MARK: - Example №1 -

/*
 представим что в нашем районе все продукты продаются в отдельных магазинах, и нам приходится зайти в каждый магазин, сделать запрос, ждать ответ, потом идти дальше... много классов, много зависимостей, сложный интерфейс, паттерн фасад помогает упростить данный момент, построив пятерочку в которй будет продоватся все продукты и в которой можно удобно закупится
 */

// MARK: protocols


// MARK: classes
fileprivate class MeatShop {
    func buyMeat() -> String {
        return "meat"
    }
}
fileprivate class BeerShop {
    func buyBeer() -> String {
        return "beer"
    }
}
fileprivate class FruitShop {
    func buyFruit() -> String {
        return "fruit"
    }
}
fileprivate class SweetShop {
    func buySweet() -> String {
        return "sweets"
    }
}
fileprivate class BreadShop {
    func buyBread() -> String {
        return "bread"
    }
}

///Supermarket (Facade)
fileprivate class Supermarket {
    private let meatShop = MeatShop()
    private let beerShop = BeerShop()
    private let fruitShop = FruitShop()
    private let sweetShop = SweetShop()
    private let breadShop = BreadShop()
    
    enum Product {
        case meat (weight: Double)
        case beer (volume: Double)
        case fruit (weight: Double)
        case sweet (weight: Double)
        case bread (weight: Double)
    }
    
    func buyProducts(products: [Product]) -> String {
        var basket = ""
        for product in products {
            switch product {
            case .meat(let weight):
                basket += "\(weight) kg " + meatShop.buyMeat() + ", "
            case .beer(let volume):
                basket += "\(volume) liters " + beerShop.buyBeer() + ", "
            case .fruit(let weight):
                basket += "\(weight) kg " + fruitShop.buyFruit() + ", "
            case .sweet(let weight):
                basket += "\(weight) kg " + sweetShop.buySweet() + ", "
            case .bread(let weight):
                basket += "\(weight) kg " + breadShop.buyBread() + ", "
            }
            
        }
        if !products.isEmpty {
            let commaIndex = basket.lastIndex(of: ",")
            basket.remove(at: basket.index(after: commaIndex ?? basket.endIndex))
            basket.remove(at: commaIndex ?? basket.endIndex)
            return "I bought: \(basket)"
        }
        return basket
    }
    
}
