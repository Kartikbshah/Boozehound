//
//  WelcomeVC.swift
//  Boozehound
//
//  Created by MAC-186 on 2/22/16.
//  Copyright © 2016 MoveoApps. All rights reserved.
//

import UIKit
import SideMenu
import MapKit

class WelcomeVC: UIViewController, MKMapViewDelegate, UIPopoverPresentationControllerDelegate {
    
    var mutSearchData: [[String: String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialSettings()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        showStatusBar()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Class Methods
    
    func doInitialSettings() {
        setupSideMenu()
    }
    
    func showStatusBar() {
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
    private func setupSideMenu() {
        SideMenuManager.menuFadeStatusBar = false
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
