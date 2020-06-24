//
//  ViewController.swift
//  Operations0624
//
//  Created by leslie on 6/24/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Time consuming operation:
        ///A loop to calculate the logarithm of a sequence of values
        let operation = BlockOperation {
            var total: Double = 1
            for f in 1..<100 {
                total = log(total+Double(f))
            }
            print("Total: \(total)")
        }
        
        ///Adding new queue
        let queue = OperationQueue()
        queue.addOperation(operation)
        
        ///iOS Main Queue
        print("Printed in the Main Queue.")
    }


}

