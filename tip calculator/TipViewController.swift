//
//  TipViewController.swift
//  Tip Calculator
//
//  Created by Tyler Wood on 2/6/17.
//  Copyright © 2017 Tyler Wood. All rights reserved.
//

import UIKit

class TipViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        // ALways call the super implementation of viewDidLoad
        super.viewDidLoad()
        
        print("tip loaded it's view")
    }
    
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var totalCostLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var tipRate = 15.0
    
    var basePriceValue: Double? {
        didSet {
            updateTotalCostLabel()
            updateTipAmountLabel()
        }
    }
    
    var tipValue: Double? {
        if let value = basePriceValue {
            return (value * (tipRate/100))
        }
        else {
            return nil
        }
    }
    
    var totalCost: Double? {
        if let value = tipValue {
            return (value + basePriceValue!)
        }
        else {
            return nil
        }
    }
    
    func updateTipAmountLabel() {
        if let value = tipValue {
            tipAmountLabel.text = numberFormatter.stringFromNumber(value)
        }
        else {
            tipAmountLabel.text = "???"
        }
    }
    
    func updateTotalCostLabel() {
        if let total = totalCost {
            totalCostLabel.text = numberFormatter.stringFromNumber(total)
        }
        else {
            totalCostLabel.text = "???"
        }
    }
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }()

    func textField(textField: UITextField,
                   shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool {
        
        // localize decimal separator
        let currentLocale = NSLocale.currentLocale()
        let decimalSeparator = currentLocale.objectForKey(NSLocaleDecimalSeparator) as! String
        
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(decimalSeparator)
        let replacementTextHasDecimalSeparator = string.rangeOfString(decimalSeparator)
        
        
        // Disallow alpha characters
        let letters = NSCharacterSet.letterCharacterSet()
        let replacementTextHasAlpha = string.rangeOfCharacterFromSet(letters)
        
        if (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) {
            return false
        }
            
        else if replacementTextHasAlpha != nil {
            return false
        }
            
        else {
            return true
        }
    }

    @IBAction func textFieldEditingChanged(textField: UITextField) {
        
        if let text = textField.text, number = numberFormatter.numberFromString(text) {
            basePriceValue = number.doubleValue
        }
        else {
            basePriceValue = nil
        }
    }
    


}

