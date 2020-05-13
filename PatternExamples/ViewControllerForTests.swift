//
//  ViewController.swift
//  PatternExamples
//
//  Created by Дмитрий Федоринов on 13.05.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class Patterns {
    enum Behavioral {
        case Strategy
        
    }
    
    static func giveBehavioralTestExample(for behavioralPattern: Behavioral) {
        switch behavioralPattern {
        case .Strategy:
            print("testExample1Human")
            Strategy.testExample1Human()
        }
    }
}

class ViewControllerForTests: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Patterns.giveBehavioralTestExample(for: .Strategy)
        
        
    }
    
    
    
    
}

