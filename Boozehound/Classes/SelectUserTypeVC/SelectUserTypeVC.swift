//
//  SelectUserTypeVC.swift
//  Boozehound
//
//  Created by MAC-186 on 2/2/16.
//  Copyright © 2016 MoveoApps. All rights reserved.
//

import UIKit

class SelectUserTypeVC: UIViewController {

    @IBOutlet var cntLblBoozhoundTop: NSLayoutConstraint!
    @IBOutlet var cntLblBartenderBottom: NSLayoutConstraint!
    var timerAnimation : NSTimer!
    var isOneAnimating : Bool = false
    let animationDuration : Double = 0.4
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

    @IBAction func btnBoozeHoundPressed(sender: UIButton) {
        strSelectedUserType = Constants.UserTypeBoozehound
        performSegueWithIdentifier("segueToLoginVC", sender: nil)
    }
    
    @IBAction func btnBartenderPressed(sender: UIButton) {
        strSelectedUserType = Constants.UserTypeBartender
        performSegueWithIdentifier("segueToLoginVC", sender: nil)
    }
    
    // MARK: - Class Methods
    
    func doInitialSettings() {
        timerAnimation = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(SelectUserTypeVC.animateView), userInfo: nil, repeats: true)
        hideStatusBar()
    }
    
    func hideStatusBar() {
        UIApplication.sharedApplication().statusBarHidden = true
    }
    
    func animateView() {
        if(isOneAnimating) {
            if(self.cntLblBoozhoundTop.constant == -20) {
                UIView.animateWithDuration(animationDuration, animations: {
                    self.cntLblBoozhoundTop.constant = 0
                    self.view.layoutIfNeeded()
                })
                isOneAnimating = false
            }
            else {
                UIView.animateWithDuration(animationDuration, animations: {
                    self.cntLblBoozhoundTop.constant = -20
                    self.view.layoutIfNeeded()
                })
            }
        }
        else {
            if(self.cntLblBartenderBottom.constant == -20) {
                UIView.animateWithDuration(animationDuration, animations: {
                    self.cntLblBartenderBottom.constant = 0
                    self.view.layoutIfNeeded()
                })
                isOneAnimating = true
            }
            else {
                UIView.animateWithDuration(animationDuration, animations: {
                    self.cntLblBartenderBottom.constant = -20
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "segueToLoginVC"){
            let aVC : LoginVC = segue.destinationViewController as! LoginVC
            aVC.strSelectedUserType = strSelectedUserType
        }
    }
}
