//
//  ViewController.swift
//  RestAPICall
//
//  Created by Vinay Ponnuri on 8/3/18.
//  Copyright © 2018 Vinay Ponnuri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Weather.forcast(withLocatioin: "42.3601,-71.0589") { (results:[Weather]) in
            for result in results {
                print("\(result)\n\n")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

