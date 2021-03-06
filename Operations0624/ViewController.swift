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
        
        dispatchingTasksWithGCD()

        addingTasksToDispatchGroup()
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

extension ViewController {
    //TODO: Dispatching tasks with GCD
    func dispatchingTasksWithGCD() {
        let queue = DispatchQueue(label: "myqueue")
        
        ///this new queue executes with the iOS main queue simultaneously
        queue.async(execute: {
            var total: Double = 1
            for f in 1..<100 {
                total = log(total + Double(f))
            }
            print("_Total: \(total)")
        })
        
        ///iOS main queue
        print("_Printed in the Main Queue")

    }
}

extension ViewController {
    
    //TODO: Working on the main queue with GCD
    func workingOnTheMainQueueWithGCD() {
        let queue = DispatchQueue(label: "myqueue")
        queue.async(execute: {
            
            var total: Double = 1
            for f in 1..<100 {
                total = log(total + Double(f))
            }
            
            let main = DispatchQueue.main
            
            ///This last operation is performed synchronously since we are already inside an asynchronous operation.
            main.sync(execute: {
                self.totalLbl.text = "__Total: \(total)"
            })
        })
        
        print("__Printed in the Main Queue")

    }
}

extension ViewController {
    //TODO: Adding tasks to a Dispatch Group
    func addingTasksToDispatchGroup() {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "myqueue")
        
        group.enter()
        queue.async(execute: {
            print("__First Task Executed")
            group.leave()
        })
        
        group.enter()
        queue.async(execute: {
            print("__Second Task Executed")
            group.leave()
        })
        
        group.notify(queue: .main, execute: {
            print("__The tasks are over")
        })
    }
}
