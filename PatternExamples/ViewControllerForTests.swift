//
//  ViewController.swift
//  PatternExamples
//
//  Created by Дмитрий Федоринов on 13.05.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class Patterns {
    static let sharedInstance = Patterns()
    private init() {}
    
    private enum Creational: String {
        case factoryMethod = "Creational -> FactoryMethod"
        case abstractFactory = "Creational -> AbstractFactory"
        case singleTon = "Creational -> SingleTon"
    }
    
    private enum Structural: String {
        case decorator = "Structural -> Decorator"
        case adapter = "Structural -> Adapter"
        
    }
    
    private enum Behavioral: String {
        case strategy = "Behavioral -> Strategy"
        case observer = "Behavioral -> Observer"
        case command = "Behavioral -> Command"
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
        case .decorator:
            print("1.testExampleWithPorsche")
            Decorator.testExampleWithPorsche()
            print("")
            print("2.testExampleWithExtensionDate")
            Decorator.testExampleWithExtensionDate()
        case .adapter:
            print("testExampleWithPredator")
            Adapter.testExampleWithPredator()
        }
        print("----------------------")
        
    }
    
    private func giveBehavioralTestExample(for behavioralPattern: Behavioral) {
        switch behavioralPattern {
        case .strategy:
            print("testExample1Human")
            Strategy.testExample1Human()
        case .observer:
            print("testExample1TeacherPupils")
            Observer.testExample1TeacherPupils()
        case .command:
            print("testExampleWithBankOperations")
            Commands.testExampleWithBankOPeration()
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
        newArr.append((Structural.adapter.rawValue,
                       { self.giveStructuralTestExample(for: .adapter) }))
        newArr.append((Structural.decorator.rawValue,
                       { self.giveStructuralTestExample(for: .decorator) }))
        
        
        newArr.append(("Behavioral", { }))
        newArr.append((Behavioral.command.rawValue,
                       { self.giveBehavioralTestExample(for: .command)}))
        newArr.append((Behavioral.observer.rawValue,
                       { self.giveBehavioralTestExample(for: .observer) }))
        newArr.append((Behavioral.strategy.rawValue,
                       { self.giveBehavioralTestExample(for: .strategy) }))
        
        
        
        return newArr
    }
}

class ViewControllerForTests: UIViewController {
    
    var tableView: UITableView {
        var tView = UITableView()
        tView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tView.dataSource = self
        tView.delegate = self
        tView.backgroundColor = UIColor.white
        
        tView.contentInset.top = 20
        let contentSize = tView.contentSize
        let footer = UIView(frame: CGRect(x: tView.frame.origin.x,
                                          y: tView.frame.origin.y + contentSize.height,
                                          width: tView.frame.size.width,
                                          height: tView.frame.height - tView.contentSize.height))
        
        tView.tableFooterView = footer
        
        tView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tView
    }
    
    var array = Patterns.sharedInstance.generateArrayOfPatternsTests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(tableView)
        
        
    }
    
    
}
extension ViewControllerForTests: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row].patternName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        array[indexPath.row].test()
        
        let allertController = UIAlertController(title: "Look at Console",
                                                 message: "testing: \(array[indexPath.row].patternName)",
            preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        allertController.addAction(ok)
        
        present(allertController, animated: true, completion: nil)
    }
    
}

