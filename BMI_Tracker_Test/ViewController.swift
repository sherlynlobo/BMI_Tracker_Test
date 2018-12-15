//
//  ViewController.swift
//  BMI_Tracker_Test
//
//  Created by Sherlyn Lobo on 2018-12-13.
//  Copyright © 2018 Sherlyn Lobo. All rights reserved.
// Name : Sherlyn Lobo
// Student ID : 301013071
// BMI Tracker
// Date : 13th December 2018

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var bmidata = 0.0
    var weightdata = 0.0
    var heightdata = 0.0
    

    @IBOutlet weak var gender: UITextField!
    
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var height: UITextField!
    
    @IBOutlet weak var resultLabel: UITextField!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    
    
    @IBOutlet weak var metricSwitch: UISwitch!
    var lastCalculationType: Int? //0 if BMICalculate, 1 if AreYouHealthy Calculate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        height.delegate = self
        weight.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Allow a touch anywhere to close any open textfields
    override func touchesBegan(_: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool)
        
    {
        if let x = UserDefaults.standard.object(forKey: "myName") as? String
        {
            name.text = x
        }
        if let y = UserDefaults.standard.object(forKey: "myAge") as? String
        {
            age.text = y
            
            
        }
        if let a = UserDefaults.standard.object(forKey: "myGender") as? String
        {
            gender.text = a
        }
        if let b = UserDefaults.standard.object(forKey: "myWeight") as? String
        {
            weight.text = b
        }
        if let c = UserDefaults.standard.object(forKey: "myHeight") as? String
        {
            height.text = c
        }

        
    }

    @IBAction func donebutton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "seque1", sender: self)
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        {
            let bmi = Bmidata(entity: Bmidata.entity(), insertInto: context)
            
            bmi.theight = Double(heightdata)
            bmi.tweight = Double(weightdata)
            bmi.tbmi = Double(bmidata)
            
            
            try? context.save()
            
            let combo = name.text!
            UserDefaults.standard.set(combo, forKey: "myName")
            
            let combo1 = age.text!
            UserDefaults.standard.set(combo1, forKey: "myAge")
            let combo2 = gender.text!
            UserDefaults.standard.set(combo2, forKey: "myGender")
            let combo3 = weight.text!
            UserDefaults.standard.set(combo3, forKey: "myWeight")
            let combo4 = height.text!
            UserDefaults.standard.set(combo4, forKey: "myHeight")
        }
        
    }
    @IBAction func CalculateBMI(_ sender: UIButton) {
        
        if weight.text != nil && height.text != nil, var weight1 = Double(weight.text!), var height1 = Double(height.text!) {
            self.view.endEditing(true)
            heightdata = height1
            weightdata = weight1
            //Calculating BMI using metric, so convert to metric first
            if !metricSwitch.isOn {
                (weight1) *= 0.453592;
                (height1) *= 0.0254;
            }
            let BMI: Double = weight1 / (height1 * height1)
            let shortBMI = String(format: "%.2f", BMI)
            bmidata = BMI
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
        
        else {
            //If text is already there, convert it to imperial
            if height.text != nil && !((height.text!).isEmpty) {
                if let heightVal = Double(height.text!) {
                    height.text = String(format: "%.2f", heightVal / 0.0254)
                }
            }
            if weight.text != nil && !((weight.text!).isEmpty) {
                if let weightVal = Double(weight.text!) {
                    weight.text = String(format: "%.2f", weightVal / 0.453592)
                }
            }
            if lastCalculationType == 1 && height.text != nil && !((height.text!).isEmpty) {
            }
            else if lastCalculationType == 0 && height.text != nil && !((height.text!).isEmpty) && weight.text != nil && !((weight.text!).isEmpty) {
            }
            height.placeholder = "Height(in)"
            weight.placeholder = "Weight(lbs)"
        }

    }
    
    
}

