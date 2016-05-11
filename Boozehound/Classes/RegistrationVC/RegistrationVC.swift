//
//  RegistrationVC.swift
//  Boozehound
//
//  Created by MAC-186 on 2/17/16.
//  Copyright © 2016 MoveoApps. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController
{
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: Variables
    
    @IBOutlet var tblRegistration: UITableView!
    var strSelectedUserType : String!
    var arrPlaceholders : [String]!
    var dictRegistrationData = [String : String]()
    
    // MARK: View LifeCycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doInitialSettings()
    }
    
    // MARK: - IBActions
    
    @IBAction func btnClosePressed(sender: UIButton)
    {
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func btnNextPressed(sender: UIButton)
    {
        print(dictRegistrationData)
        
        var allEntered = true
        for i in 0 ..< arrPlaceholders.count {
            let strValue = dictRegistrationData[arrPlaceholders[i]]
            if(strValue!.characters.count == 0) {
                CommonMethods.PresnetAlertViewWithMessage("Please enter \(arrPlaceholders[i].lowercaseString).")
                allEntered = false
                break
            }
        }
        
        let isValidEmail = CommonMethods.validateEmail(dictRegistrationData["Email Address"]!)
        let isPasswordSame = CommonMethods.ComparePassword(dictRegistrationData["Password"]!, ConfirmPassword: dictRegistrationData["Confirm Password"]!)
        
        if(!isValidEmail) {
            CommonMethods.PresnetAlertViewWithMessage(Constants.NO_VALID_EMAIL)
        }
        else if(!isPasswordSame) {
            CommonMethods.PresnetAlertViewWithMessage(Constants.PASSWORD_NOT_MATCH)
        }
        
        if(allEntered && isValidEmail && isPasswordSame) {
            if (appDelegate.checkReachability())
            {
                let dictParams : [String : AnyObject] = [
                    "firstname" : dictRegistrationData["First Name"]!,
                    "lastname" : dictRegistrationData["Last Name"]!,
                    "email" : dictRegistrationData["Email Address"]!,
                    "password" : dictRegistrationData["Password"]!,
                    "country" : dictRegistrationData["Country"]!,
                    "state" : dictRegistrationData["State"]!,
                    "city" : dictRegistrationData["City"]!,
                    "phonenumber" : dictRegistrationData["Contact Number"]!,
                    "type" : strSelectedUserType == Constants.UserTypeBartender ? "1" : "2",
                    "deviceid" : appDelegate.strDeviceToken,
                    "devicetype" : Constants.DeviceType
                    ]

                WebServiceHelper.postWebServiceCall(Constants.URL_Register_Step1, activityMessage: Constants.Register, params: dictParams, isShowLoader: true, success: { (responseObject) -> Void in
                    
                    print(responseObject)
                    if(responseObject["success"].stringValue == "0") {
                        CommonMethods.PresnetAlertViewWithMessage(responseObject["message"].stringValue)
                    }
                    else {
                        let userDefaults = NSUserDefaults.standardUserDefaults()
                        userDefaults.setObject(responseObject["userdata"].dictionaryObject, forKey: "userdata")
                        userDefaults.synchronize()
                        self.performSegueWithIdentifier("segueToRegistrationProfileVC", sender: nil)
                    }
                }, failure: { (errMsg) -> Void in
                    
                })
            }
            else
            {
                CommonMethods.PresnetAlertViewWithMessage(Constants.NO_NETWORK)
            }
        }
    }
    
    // MARK: - Table View Datasource - Delegates
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let aCell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("RegistrationCell")!
        let aTextField = aCell.viewWithTag(1000) as! BHTextField
        aTextField.placeholder = arrPlaceholders[indexPath.row]
        aTextField.placeHolderColor = UIColor.whiteColor()
        aTextField.inputView = nil
        
        if (["Password", "Confirm Password"].contains(arrPlaceholders[indexPath.row]))
        {
            aTextField.secureTextEntry = true
        }
       
        aTextField.addTarget(self, action: #selector(RegistrationVC.textChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        return aCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrPlaceholders.count
    }

    // MARK: - Text Field Delegates
    
    func textChange(sender: UITextField)
    {
        dictRegistrationData[sender.placeholder!] = sender.text!
    }
    
    // MARK: - Class Methods
    
    func doInitialSettings()
    {
        hideStatusBar()
        
        if (strSelectedUserType == Constants.UserTypeBoozehound)
        {
            arrPlaceholders = ["First Name", "Last Name", "Email Address", "Password", "Confirm Password"]
        }
        else
        {
            arrPlaceholders = ["First Name", "Last Name", "Email Address", "Password", "Confirm Password", "Country", "State", "City", "Contact Number"]
        }
        
        for strField in ["First Name", "Last Name", "Email Address", "Password", "Confirm Password", "Country", "State", "City", "Contact Number"]
        {
            dictRegistrationData[strField] = ""
        }
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    func hideStatusBar()
    {
        UIApplication.sharedApplication().statusBarHidden = true
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
}
