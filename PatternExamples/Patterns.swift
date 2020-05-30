//
//  Patterns.swift
//  PatternExamples
//
//  Created by Дмитрий Федоринов on 26.05.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import Foundation

class Patterns {
    static let sharedInstance = Patterns()
    private init() {}
    
    private enum Creational: String {
        case factoryMethod = "Creational -> FactoryMethod"
        case abstractFactory = "Creational -> AbstractFactory"
        case singleTon = "Creational -> SingleTon"
    }
    
    private enum Structural: String {
        case composite = "Structural -> Composite"
        case adapter = "Structural -> Adapter"
        case decorator = "Structural -> Decorator"
        case facade = "Structural -> Facade"
        case proxy = "Strucutral -> Proxy"
    }
    
    private enum Behavioral: String {
        case command = "Behavioral -> Command"
        case iterator = "Behavioral -> Iterator"
        case observer = "Behavioral -> Observer"
        case state = "Behavioral -> State"
        case strategy = "Behavioral -> Strategy"
        case templateMethod = "Behavioral -> TemplateMethod"
    }
    

    private func giveCreationalTestExample(for creationallPattern: Creational) {
        switch creationallPattern {
        case .factoryMethod:
            print("testExampleWithCars")
            FactoryMethod.testExampleWithVehicles()
        case .abstractFactory:
            print("testExampleOfCarsAndBus")
            AbstractFactory.testExampleOfCarsAndBus()
        case .singleTon:
            print("testExampleSafe")
            Singleton.testExampleSafe()
        }
        print("----------------------")
    }
    
    private func giveStructuralTestExample(for structuralPattern: Structural) {
        switch structuralPattern {
        case .composite:
            print("testExampleWithFiles")
            Composite.testExampleWithFiles()
        case .adapter:
            print("testExampleWithPredator")
            Adapter.testExampleWithPredator()
        case .decorator:
            print("1.testExampleWithPorsche")
            Decorator.testExampleWithPorsche()
            print("")
            print("2.testExampleWithExtensionDate")
            Decorator.testExampleWithExtensionDate()
        case .facade:
            print("testExample")
            Facade.testExample()
        case .proxy:
            print("testExampleWithAutheficatedSrver")
            Proxy.testExampleWithAutheficatedSrver()
        }
        print("----------------------")
        
    }
    
    private func giveBehavioralTestExample(for behavioralPattern: Behavioral) {
        switch behavioralPattern {
        case .command:
            print("testExampleWithBankOperations")
            Commands.testExampleWithBankOPeration()
        case .iterator:
            print("testExampleCarHistory")
            Iterator.testExampleCarHistory()
        case .observer:
            print("testExample1TeacherPupils")
            Observer.testExample1TeacherPupils()
        case .state:
            print("testExampleWithPrinter")
            State.testExampleWithPrinter()
        case .strategy:
            print("testExample1Human")
            Strategy.testExample1Human()
        case .templateMethod:
            print("testExampleDriveTransport")
            TemplateMethod.testExampleDriveTransport()
            
        }
        print("----------------------")
        
    }
    
    
    typealias PatternTests = [(patternName: String, test: ()->Void)]
    func generateArrayOfPatternsTests() -> PatternTests {
        
        var newArr = PatternTests()
        
        newArr.append(("Creational", { }))
        newArr.append((Creational.factoryMethod.rawValue,
                       { self.giveCreationalTestExample(for: .factoryMethod)}))
        newArr.append((Creational.abstractFactory.rawValue,
                       { self.giveCreationalTestExample(for: .abstractFactory)}))
        newArr.append((Creational.singleTon.rawValue,
                       { self.giveCreationalTestExample(for: .singleTon)}))
        
        
        newArr.append(("Structural", { }))
        newArr.append((Structural.composite.rawValue,
                       { self.giveStructuralTestExample(for: .composite) }))
        newArr.append((Structural.adapter.rawValue,
                       { self.giveStructuralTestExample(for: .adapter) }))
        newArr.append((Structural.decorator.rawValue,
                       { self.giveStructuralTestExample(for: .decorator) }))
        newArr.append((Structural.facade.rawValue,
                       { self.giveStructuralTestExample(for: .facade) }))
        newArr.append((Structural.proxy.rawValue,
                       { self.giveStructuralTestExample(for: .proxy) }))
        
        
        newArr.append(("Behavioral", { }))
        newArr.append((Behavioral.command.rawValue,
                       { self.giveBehavioralTestExample(for: .command)}))
        newArr.append((Behavioral.iterator.rawValue,
                       { self.giveBehavioralTestExample(for: .iterator) }))
        newArr.append((Behavioral.observer.rawValue,
                       { self.giveBehavioralTestExample(for: .observer) }))
        newArr.append((Behavioral.state.rawValue,
                       { self.giveBehavioralTestExample(for: .state) }))
        newArr.append((Behavioral.strategy.rawValue,
                       { self.giveBehavioralTestExample(for: .strategy) }))
        newArr.append((Behavioral.templateMethod.rawValue,
                       { self.giveBehavioralTestExample(for: .templateMethod) }))
        
        
        return newArr
    }
}
