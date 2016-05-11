//
//  CommonMethods.swift
//  Boozehound
//
//  Created by Mital Solanki on 07/03/16.
//  Copyright © 2016 MoveoApps. All rights reserved.
//

import UIKit

class CommonMethods: NSObject
{
    // MARK: - Email Validation
    
    class func validateEmail(aStrEmailAdd: String) -> Bool
    {
        let aStrEmailRegex: String = "(?:[A-Za-z0-9]+(?:\\.[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[A-Za-z0-9](?:[a-" +
            "zA-Z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[A-Za-z0-9-]*[A-Za-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let aPredEmailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", aStrEmailRegex)
        let boolIsEmailValid: Bool = aPredEmailTest.evaluateWithObject(aStrEmailAdd)
        return boolIsEmailValid
    }
    
    // MARK: - Name Validation
    
    class func validateName(aStrName: String) -> Bool
    {
        let aStrNameRegex: String = "^[a-z A-Z'-]+$"
        let aPredNameTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", aStrNameRegex)
        let boolIsNameValid: Bool = aPredNameTest.evaluateWithObject(aStrName)
        return boolIsNameValid
    }
    
    // MARK: - Compare Password
    
    class func ComparePassword(strPassword: String, ConfirmPassword strConfirmPassword: String) -> Bool
    {
        if (strConfirmPassword == strPassword)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    // MARK: - Phone Validation
    
    class func validatePhone(aStrPhone: String) -> Bool
    {
        var strPhone : String = aStrPhone
        strPhone = strPhone.stringByReplacingOccurrencesOfString("+", withString: "")
        strPhone = strPhone.stringByReplacingOccurrencesOfString("-", withString: "")
        let aStrPhoneRegex: String = "^[0-9]{8,10}$"
        let aPredPhoneTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", aStrPhoneRegex)
        let boolIsPhoneValid: Bool = aPredPhoneTest.evaluateWithObject(strPhone)
        return boolIsPhoneValid
    }
    
    // MARK: - Present AlertView
    
    class func PresnetAlertViewWithMessage(strMessage: String)
    {
        let alertController = UIAlertController(title: "BoozeHound", message: strMessage, preferredStyle: .Alert)
        let alertActionOk = UIAlertAction(title: "OK", style: .Default, handler: { (ACTION) -> Void in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(alertActionOk)
        UIApplication.sharedApplication().keyWindow!.rootViewController!.presentViewController(alertController, animated: true, completion:nil)
    }
}
