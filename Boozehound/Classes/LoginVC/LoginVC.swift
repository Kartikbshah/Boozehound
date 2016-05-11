//
//  LoginVC.swift
//  Boozehound
//
//  Created by MAC-186 on 2/2/16.
//  Copyright © 2016 MoveoApps. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var txtEmail: BHTextField!
    @IBOutlet var txtPassword: BHTextField!
    
    @IBOutlet var btnSignUp: UIButton!
    var strSelectedUserType : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialSettings()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: - IBActions
    
    @IBAction func btnLoginPressed(sender: UIButton) {
        
        if(txtEmail.text!.characters.count == 0) {
            CommonMethods.PresnetAlertViewWithMessage("Please enter \(txtEmail.placeholder!.lowercaseString).")
        }
        else if(txtPassword.text!.characters.count == 0) {
            CommonMethods.PresnetAlertViewWithMessage("Please enter \(txtPassword.placeholder!.lowercaseString).")
        }
        else {
            if (appDelegate.checkReachability())
            {
                let dictParams : [String : AnyObject] = ["email" : txtEmail.text!,
                    "password": txtPassword.text!,
                    "devicetype": Constants.DeviceType,
                    "deviceid": appDelegate.strDeviceToken
                ]
                
                WebServiceHelper.postWebServiceCall(Constants.URL_Login, activityMessage: Constants.Login, params: dictParams, isShowLoader: true, success:
                    { (responseObject) -> Void in
                        print(responseObject)
                        if(responseObject["success"].stringValue == "0") {
                            CommonMethods.PresnetAlertViewWithMessage(responseObject["message"].stringValue)
                        }
                        else {
                            let userDefaults = NSUserDefaults.standardUserDefaults()
                            userDefaults.setObject(responseObject["userdata"].dictionaryObject, forKey: "userdata")
                            userDefaults.synchronize()
                            
                            self.performSegueWithIdentifier("segueToMapVC", sender: nil)
                        }
                    })
                    { (error) -> Void in
                        print(error)
                }
                
                
            }
            else
            {
                CommonMethods.PresnetAlertViewWithMessage(Constants.NO_NETWORK)
            }
            
            
            
           
        }
    }
    
    @IBAction func btnSignUpPressed(sender: AnyObject) {
        performSegueWithIdentifier("segueToRegistrationVC", sender: nil)
    }
    
    // MARK: - Class Methods
    
    func doInitialSettings() {
        // Sign Up Button Attributed String
        let mutAttrStr : NSMutableAttributedString = NSMutableAttributedString(string: "New User? ", attributes: [NSFontAttributeName : UIFont(name: Constants.FontDosisRegular, size: btnSignUp.titleLabel!.font.pointSize)!])
        mutAttrStr.appendAttributedString(NSAttributedString(string: "SIGN UP", attributes: [NSFontAttributeName : UIFont(name: Constants.FontDosisBold, size: btnSignUp.titleLabel!.font.pointSize)!, NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]))
        btnSignUp.setAttributedTitle(mutAttrStr, forState: UIControlState.Normal)
        
        txtPassword.btnRight.addTarget(self, action: #selector(LoginVC.btnForgotPasswordPressed), forControlEvents: UIControlEvents.TouchUpInside)
        
        hideStatusBar()
    }
    
    func hideStatusBar() {
        UIApplication.sharedApplication().statusBarHidden = true
    }
    
    func btnForgotPasswordPressed() {
        
        let alertVC = UIAlertController(title: "BoozeHound", message: "Forgot Password?", preferredStyle: UIAlertControllerStyle.Alert)
        alertVC.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Email"
        }

        let alertCancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Destructive, handler: nil)
        alertVC.addAction(alertCancelAction)
        
        let alertOkAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            let textField = alertVC.textFields![0]
            print(textField.text!)
            if (textField.text!.characters.count > 0) {
                if (self.appDelegate.checkReachability())
                {
                    let dictParams : [String : AnyObject] = [ "email": textField.text! ]
                    
                    WebServiceHelper.postWebServiceCall(Constants.URL_ForgotPassword, activityMessage: Constants.Login, params: dictParams, isShowLoader: true, success:
                        { (responseObject) -> Void in
                            print(responseObject)
                            if(responseObject["success"].stringValue == "0") {
                                CommonMethods.PresnetAlertViewWithMessage(responseObject["message"].stringValue)
                            }
                            else {
                                CommonMethods.PresnetAlertViewWithMessage(responseObject["message"].stringValue)
                            }
                        })
                        { (error) -> Void in
                            print(error)
                    }
                }
                else
                {
                    CommonMethods.PresnetAlertViewWithMessage(Constants.NO_NETWORK)
                }
            }
        }
        
        alertVC.addAction(alertOkAction);
        
        UIApplication.sharedApplication().keyWindow!.rootViewController!.presentViewController(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "segueToRegistrationVC"){
            let aVC = segue.destinationViewController as! RegistrationVC
            aVC.strSelectedUserType = strSelectedUserType
        }
    }
}
