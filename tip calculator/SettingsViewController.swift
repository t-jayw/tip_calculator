import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        // ALways call the super implementation of viewDidLoad
        super.viewDidLoad()
        
        defTipField.text = numberFormatter.stringFromNumber(userDefaults.userDefaultTipSetting)
    }


    @IBOutlet var defTipField: UITextField!
    
    var defTipRate: Double? {
        didSet {
            if let val = numberFormatter.numberFromString(defTipField.text!) {
                userDefaults.userDefaultTipSetting = val.integerValue
            }
            else {
            }
        }
    }
    
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 0
        return nf
    }()
    
    let currencyFormatter: NSNumberFormatter = {
        let cf = NSNumberFormatter()
        cf.numberStyle = .CurrencyStyle
        cf.locale = NSLocale.currentLocale()
        return cf
    }()
    
    func defTipField(textField: UITextField,
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
            defTipRate = number.doubleValue
        }
        else {
            defTipRate = nil
        }
    }
    
    @IBAction func settingDismissKeyboard(sender: AnyObject) {
        defTipField.resignFirstResponder()
    }
    
    

    
    
}
