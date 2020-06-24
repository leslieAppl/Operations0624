//
//  ViewController.swift
//  Operations0624
//
//  Created by leslie on 6/24/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalLbl: UILabel!
    
    //TODO: Adding operations to a queue
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///First execution in order
        calculation()
        
        addingDependency()
        
        ///Time consuming operation:
        ///A loop to calculate the logarithm of a sequence of values
        let operation = BlockOperation {
            var total: Double = 1
            for f in 1..<10000 {
                total = log(total+Double(f))
            }
            print("Total: \(total)")
            
            //TODO: Adding operations to the main queue
            ///main: referencing to the iOS main thread
            let main = OperationQueue.main
            main.addOperation {
                self.totalLbl.text = "Total: \(total)"
            }
        }
        
        ///Adding new queue
        let queue = OperationQueue()
        queue.addOperation(operation)
        
        ///iOS Main Queue
        print("Printed in the Main Queue.")
        
//        addingDependency()
    }

    //TODO: Adding a dependency
    func addingDependency() {
        let firstOperation = BlockOperation {
            print("First Operation Executed")
        }
        
        let secondOperation = BlockOperation {
            print("Second Operation Executed")
        }
        
        firstOperation.addDependency(secondOperation)
        
        let queue = OperationQueue()
        queue.addOperations([firstOperation, secondOperation], waitUntilFinished: false)
    }
    
    func calculation() {
        var total: Double = 1
        for f in 1..<100 {
            total = log(total+Double(f))
        }
        print("Total: \(total)")
    }
}

