//
//  LeftMenuVC.swift
//  Boozehound
//
//  Created by MAC-186 on 2/23/16.
//  Copyright © 2016 MoveoApps. All rights reserved.
//

import UIKit
import Kingfisher

class LeftMenuVC: UIViewController {

    var arrMenuItems : [[String : String]]!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialSettings()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view Datasource/Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var strCellIdentifier = ""
        if(indexPath.row == 0)
        {
            strCellIdentifier = "ProfileCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(strCellIdentifier, forIndexPath: indexPath) as! ProfileCell
            
            cell.imgProfilePic.layer.cornerRadius = cell.imgProfilePic.frame.size.height/2
            cell.imgProfilePic.clipsToBounds = true
            cell.imgProfilePic.layer.borderWidth = 2.0
            cell.imgProfilePic.layer.borderColor = UIColor.whiteColor().CGColor
            
            let userDefaults = NSUserDefaults.standardUserDefaults()
            let userData = userDefaults.objectForKey("userdata") as! [String : String]
            cell.lblUserName.text = userData["firstname"]! + " " + userData["lastname"]!
            
            cell.imgProfilePic.kf_showIndicatorWhenLoading = true
            cell.imgProfilePic.kf_setImageWithURL(NSURL(string: userData["userimage"]!)!, placeholderImage: UIImage(named: "addProfile"))
            
            return cell
        }
        else {
            strCellIdentifier = "MenuCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(strCellIdentifier, forIndexPath: indexPath) as! MenuCell
            cell.lblMenuName.text = arrMenuItems[indexPath.row]["title"]
            
            
            if let strIcon = arrMenuItems[indexPath.row]["icon"] {
                if (strIcon.characters.count > 0) {
                    cell.imgMenuIcon.image = UIImage(named: strIcon)
                }
            }
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(arrMenuItems[indexPath.row]["title"] == "LOGOUT") {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            var initialViewController = UIViewController()
            if let _ = userDefaults.objectForKey("userdata") {
                userDefaults.removeObjectForKey("userdata")
                userDefaults.synchronize()
            }
            initialViewController = self.storyboard!.instantiateViewControllerWithIdentifier("NavLogin")
            appDelegate.window!.rootViewController = initialViewController
            appDelegate.window!.makeKeyAndVisible()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 180
        }
        else {
            return 60
        }
    }
    
    // MARK: - Class Methods
    
    func doInitialSettings() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let _ = userDefaults.objectForKey("userdata") {
                arrMenuItems = [["title":"Profile"],
                    ["title":"LOGOUT","icon":"menuIconLogout"]]
        }
    }
    
    func pushToVC(strIdentifier : String) {
        let aStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let aVC : UIViewController = aStoryboard.instantiateViewControllerWithIdentifier(strIdentifier)
        self.navigationController!.pushViewController(aVC, animated: true)
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
