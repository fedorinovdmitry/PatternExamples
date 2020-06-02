//
//  Patterns.swift
//  PatternExamples
//
//  Created by Дмитрий Федоринов on 26.05.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import Foundation

fileprivate protocol PatternType {
    var name: String { get }
    func giveExample()
}

class Patterns {
    static let shared = Patterns()
    private init() {}
    
    
    private enum Creational: String, PatternType, CaseIterable {
        
        case factoryMethod = "Creational -> FactoryMethod"
        case abstractFactory = "Creational -> AbstractFactory"
        case builder = "Creational -> Builder"
        case prototype = "Creational -> Prototype"
        case singleTon = "Creational -> SingleTon"
        
        var name: String { get { return self.rawValue } }
        
        func giveExample() {
            
            switch self {
            case .factoryMethod:
                print("testExampleWithCars")
                FactoryMethod.testExampleWithVehicles()
            case .abstractFactory:
                print("testExampleOfCarsAndBus")
                AbstractFactory.testExampleOfCarsAndBus()
            case .builder:
                print("testExampleWithBurgers")
                Builder.testExampleWithBurgers()
            case .prototype:
                print("testExampleWithMonster")
                Prototype.testExampleWithMonster()
            case .singleTon:
                print("testExampleSafe")
                Singleton.testExampleSafe()
            }
            print("----------------------")
        }
        
    }
    
    private enum Structural: String, PatternType, CaseIterable {
        
        case composite = "Structural -> Composite"
        case adapter = "Structural -> Adapter"
        case decorator = "Structural -> Decorator"
        case facade = "Structural -> Facade"
        case proxy = "Strucutral -> Proxy"
        
        var name: String { get { return self.rawValue } }
        
        func giveExample() {
            
            switch self {
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
    }
    
    private enum Behavioral: String, PatternType, CaseIterable {
        
        case chainOfResponsibility = "Behavioral -> ChainOfResponsibility"
        case command = "Behavioral -> Command"
        case iterator = "Behavioral -> Iterator"
        case observer = "Behavioral -> Observer"
        case state = "Behavioral -> State"
        case strategy = "Behavioral -> Strategy"
        case templateMethod = "Behavioral -> TemplateMethod"
        
        var name: String { get { return self.rawValue } }
        
        func giveExample() {
            
            switch self {
            case .chainOfResponsibility:
                print("testExampleWithErrors")
                ChainOfResponsibility.testExampleWithErrors()
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
    }
    
    
    typealias PatternTest = (patternName: String, test: ()->())
    
    private var patternsForTests = [PatternTest]()
    
    func generateArrayOfPatternsTests() -> [PatternTest] {
        
        patternsForTests.append(("Creational", { }))
        addPatterns(Creational.allCases)
        
        patternsForTests.append(("Structural", { }))
        addPatterns(Structural.allCases)
        
        patternsForTests.append(("Behavioral", { }))
        addPatterns(Behavioral.allCases)
        
        return patternsForTests
    }
    
    private func addPatterns(_ patterns: [PatternType]) {
        
        for pattern in patterns {
            let name = pattern.name
            let test: ()->() = { pattern.giveExample() }
            let paternTest: PatternTest = (name, test)
            patternsForTests.append(paternTest)
        }
        
    }
}
