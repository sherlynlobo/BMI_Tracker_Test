//
//  ViewController.swift
//  BMI_Tracker_Test
//
//  Created by Sherlyn Lobo on 2018-12-13.
//  Copyright © 2018 Sherlyn Lobo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var gender: UITextField!
    
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var height: UITextField!
    
    @IBOutlet weak var resultLabel: UITextField!
    
    @IBOutlet weak var metricSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

