//
//  ViewController.swift
//  PatternExamples
//
//  Created by Дмитрий Федоринов on 13.05.2020.
//  Copyright © 2020 Дмитрий Федоринов. All rights reserved.
//

import UIKit

class ViewControllerForTests: UIViewController {
    
    var tableView: UITableView {
        var tView = UITableView()
        tView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tView.dataSource = self
        tView.delegate = self
        tView.backgroundColor = UIColor.white
        
        tView.contentInset.top = 20
        
        tView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tView
    }
    
    var array = Patterns.shared.generateArrayOfPatternsTests()
    
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

