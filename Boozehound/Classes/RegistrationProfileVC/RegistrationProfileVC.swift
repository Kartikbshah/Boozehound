//
//  RegistrationProfileVC.swift
//  Boozehound
//
//  Created by MAC-186 on 2/18/16.
//  Copyright © 2016 MoveoApps. All rights reserved.
//

import UIKit

class RegistrationProfileVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var txtViewBiodata: UITextView!
    @IBOutlet var imgProfilePic: UIImageView!
    var imgPicker = UIImagePickerController()
    var userData = [String : String]()
    
    @IBOutlet var cnstVerticleSpaceSkipButton: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialSettings()
        // Do any additional setup after loading the view.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func btnProfilePicPressed(sender: UIButton) {
        imgPicker.delegate = self
        UIApplication.sharedApplication().statusBarHidden = false
        presentViewController(imgPicker, animated: true, completion: nil)
    }
    
    @IBAction func btnBackPressed(sender: UIButton) {
        navigationController!.popViewControllerAnimated(true)
    }

    @IBAction func btnDonePressed(sender: UIButton) {
        if(imgProfilePic.image != nil) {
            let dictParams : [String : AnyObject] = [
                "userid" : self.userData["userid"]!,
                "biodescription" : txtViewBiodata.text!.characters.count > 0 ? txtViewBiodata.text! : ""
            ]
            
            WebServiceHelper.postWebServiceCallWithImage(Constants.URL_Register_Step2, activityMessage: Constants.Update, image: imgProfilePic.image!, params: dictParams, isShowLoader: true,
                success: { (responseObject) -> Void in
                    
                    print(responseObject)
                    if(responseObject["success"].stringValue == "0") {
                        CommonMethods.PresnetAlertViewWithMessage(responseObject["message"].stringValue)
                    }
                    else {
                        
                        let userDefaults = NSUserDefaults.standardUserDefaults()
                        
                        var dictUserData : [String : AnyObject] = userDefaults.objectForKey("userdata") as! [String : AnyObject]
                        print(dictUserData)
                        
                        for (key, value) in responseObject["userdata"].dictionaryObject! {
                            dictUserData[key] = value
                        }
                        
                        userDefaults.setObject(dictUserData, forKey: "userdata")
                        userDefaults.synchronize()
                        
                        self.performSegueWithIdentifier("segueToMapVC", sender: nil)

                    }
                }) { (error) -> Void in
                    CommonMethods.PresnetAlertViewWithMessage(error.description)
            }
        }
        else {
            CommonMethods.PresnetAlertViewWithMessage("Please select image else skip this step!")
        }
    }

    @IBAction func btnSkipPressed(sender: UIButton) {
        self.performSegueWithIdentifier("segueToMapVC", sender: nil)
    }
    
    // MARK: - UIImagePicker Delegates
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imgProfilePic.image = image
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.hideStatusBar()
        }
        
        imgPicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Class Methods
    
    func doInitialSettings() {
        txtViewBiodata.layer.cornerRadius = 10
        txtViewBiodata.layer.borderColor = UIColor.whiteColor().CGColor
        txtViewBiodata.layer.borderWidth = 1.0
        txtViewBiodata.clipsToBounds = true
        
        imgProfilePic.layer.cornerRadius = imgProfilePic.frame.size.height/2
        imgProfilePic.layer.borderColor = UIColor.whiteColor().CGColor
        imgProfilePic.layer.borderWidth = 2.0
        imgProfilePic.clipsToBounds = true
        
        hideStatusBar()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userData = userDefaults.objectForKey("userdata") as! [String : String]
        
        if(userData["type"] == Constants.UserTypeBartenderValue) {
            txtViewBiodata.hidden = false
            cnstVerticleSpaceSkipButton.constant = 129
        }
        else {
            txtViewBiodata.hidden = true
            cnstVerticleSpaceSkipButton.constant = 8
        }
    }
    
    func hideStatusBar() {
        UIApplication.sharedApplication().statusBarHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
