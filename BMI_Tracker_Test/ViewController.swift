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
    var lastCalculationType: Int? //0 if BMICalculate, 1 if AreYouHealthy Calculate

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func CalculateBMI(_ sender: UIButton) {
        
        if weight.text != nil && height.text != nil, var weight1 = Double(weight.text!), var height1 = Double(height.text!) {
            self.view.endEditing(true)
            //Calculating BMI using metric, so convert to metric first
            if !metricSwitch.isOn {
                (weight1) *= 0.453592;
                (height1) *= 0.0254;
            }
            let BMI: Double = weight1 / (height1 * height1)
            let shortBMI = String(format: "%.2f", BMI)
            var resultText = "Your BMI is \(shortBMI): "
            var descriptor : String?
            if(BMI < 16.0) { descriptor = "Severely Thin" }
            else if(BMI < 16.99) { descriptor = "Moderately Thin" }
            else if(BMI < 18.49) { descriptor = "Slightly Thin" }
            else if(BMI < 24.99) { descriptor = "Normal" }
            else if(BMI < 29.99) { descriptor = "Overweight" }
            else if(BMI < 34.99) { descriptor = "Obese Class I" }
            else if(BMI < 39.99) { descriptor = "Obese Class II" }
            else { descriptor = "Obese Class III" }
            resultText += descriptor!
            print(resultText)
            resultLabel.text = resultText
            resultLabel.isHidden = false
            lastCalculationType = 0
        }
    }
    
    @IBAction func AreYouHealthy(_ sender: UIButton) {
    }
    
    @IBAction func metricSwitchChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            //If text is already there, convert it to metric
            if height.text != nil && !((height.text!).isEmpty) {
                if let heightVal = Double(height.text!) {
                    height.text = String(format: "%.2f", heightVal * 0.0254)
                }
            }
            if weight.text != nil && !((weight.text!).isEmpty) {
                if let weightVal = Double(weight.text!) {
                    weight.text = String(format: "%.2f", weightVal * 0.453592)
                }
            }
            if lastCalculationType == 1 && height.text != nil && !((height.text!).isEmpty) {
                
            }
            else if lastCalculationType == 0 && height.text != nil && !((height.text!).isEmpty) && weight.text != nil && !((weight.text!).isEmpty) {
                
            }
            height.placeholder = "Height(m)"
            weight.placeholder = "Weight(kg)"
        }
    }
    
    
}

