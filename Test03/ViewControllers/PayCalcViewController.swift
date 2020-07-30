//
//  PayCalcViewController.swift
//  Test03
//
//  Created by Andrew Matula on 6/11/20.
//  Copyright © 2020 Andrew Matula. All rights reserved.
//

import UIKit

class PayCalcViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    
    @IBOutlet weak var HourlyPay: UITextField!
    @IBOutlet weak var HoursWorked: UITextField!
    
    @IBOutlet weak var Error01: UILabel!
    @IBOutlet weak var Error02: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var totalPay : UILabel!
    @IBOutlet weak var taxesPaid: UILabel!
    @IBOutlet weak var actualPay: UILabel!
    @IBOutlet weak var taxPercentage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cleanup()
        Error01.text = ""
        Error02.text = ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CalcPay(_ sender: Any) {
        
        Error01.text = ""
        Error02.text = ""
        
        var formErrors = 0
        
        let bracket06amt = 518400.0
        let bracket06perc = 0.37
        let bracket05amt = 207350.0
        let bracket05perc = 0.35
        let bracket04amt = 163300.0
        let bracket04perc = 0.32
        let bracket03amt = 85525.0
        let bracket03perc = 0.24
        let bracket02amt = 40125.0
        let bracket02perc = 0.22
        let bracket01amt = 9875.0
        let bracket01perc = 0.12
        let bracket00perc = 0.10
        var taxes = 0.0
        let stDeduct = 12200.0
        
        let numCheck = "[0-9]"
        
        if HourlyPay.text?.trimmingCharacters(in: .whitespaces) == ""{
            Error01.text = "Error: Enter Hourly Pay"
            formErrors = 1
        } else if inputIsValid(pattern: numCheck, inputData: HourlyPay.text!) == false {
            Error01.text = "Error: Invalid Input"
            formErrors = 1
        } else {
            Error01.text = ""
        }
        
        if HoursWorked.text?.trimmingCharacters(in: .whitespaces) == "" {
            Error02.text = "Error: Enter Hours Worked"
            formErrors = 1
        } else if inputIsValid(pattern: numCheck, inputData: HoursWorked.text!) == false {
            Error02.text = "Error: Invalid Input"
            formErrors = 1
        } else {
            Error02.text = ""
        }
        
        if formErrors == 1 {
            cleanup()
        }
        
        if formErrors == 0 {
            let pay = Double(HourlyPay.text!.trimmingCharacters(in: .whitespaces))!
            let hours = Double(HoursWorked.text!.trimmingCharacters(in: .whitespaces))!
            let total = (pay * hours * 52)
            var total02 = total - stDeduct
            let total03 = total02
            let maxFICA = 137700.0
            
            if total02 > bracket06amt {
                taxes = taxes + ((total02 - bracket06amt) * bracket06perc)
                total02 = bracket06amt - 1.0
            }
            if total02 > bracket05amt {
                taxes += ((total02-bracket05amt)*bracket05perc)
                total02 = bracket05amt - 1.0
            }
            if total02 > bracket04amt {
                taxes += ((total02-bracket04amt)*bracket04perc)
                total02 = bracket04amt - 1.0
            }
            if total02 > bracket03amt {
                taxes += ((total02-bracket03amt)*bracket03perc)
                total02 = bracket03amt - 1.0
            }
            if total02 > bracket02amt {
                taxes += ((total02-bracket02amt)*bracket02perc)
                total02 = bracket02amt - 1.0
            }
            if total02 > bracket01amt {
                taxes += ((total02-bracket01amt)*bracket01perc)
                total02 = bracket01amt - 1.0
            }
            if total02 > 0 {
                taxes += ((total02)*bracket00perc)
            }
            //FICA taxes
            
            if total03 >= maxFICA {
                taxes += (maxFICA*0.0765)
            } else {
                taxes += (total03*0.0765)
            }
                
            
            
            subTitle.textColor = UIColor.black
            subTitle.text = "Yearly Total"
            totalPay.text = "Total Pay: $ "+"\(round(total*100)/100)"
            taxesPaid.text = "Gov stole: $ "+"\(round(taxes*100)/100)"
            actualPay.text = "Your real pay: $ "+"\(round((total-taxes)*100)/100)"
            taxPercentage.text = "Effective Tax: "+"\(round((taxes/total)*10000)/100)"+" %"
                view.endEditing(true)
        }
    }
    
    func inputIsValid (pattern:String, inputData:String) -> Bool {
        
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let matches = regex?.matches(in: inputData, options: [], range: NSRange(location: 0, length: inputData.count))
        if matches!.count == inputData.trimmingCharacters(in: .whitespaces).count {
            return true
        } else {
            return false
        }
    }
    
    func cleanup() {
        subTitle.text = ""
        totalPay.text = ""
        taxesPaid.text = ""
        actualPay.text = ""
        taxPercentage.text = ""
    }
    
    @IBAction func DismissTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
