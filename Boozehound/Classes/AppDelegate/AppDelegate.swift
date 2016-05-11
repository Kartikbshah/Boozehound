//
//  AppDelegate.swift
//  Boozehound
//
//  Created by MAC-186 on 2/2/16.
//  Copyright © 2016 MoveoApps. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import ReachabilitySwift

extension UIViewController
{
    var appDelegate:AppDelegate
    {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?
    var strDeviceToken : String = ""
    var reachability: Reachability?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        IQKeyboardManager.sharedManager().enable = true
        
        if application.respondsToSelector(#selector(UIApplication.isRegisteredForRemoteNotifications))
        {
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes:[.Alert, .Badge, .Sound], categories: nil))
            application.registerForRemoteNotifications()
        }

        do
        {
           try reachability?.startNotifier()
        }
        catch
        {
            
        }
        
        checkReachability()
        
        checkUserAvailability()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication)
    {
        
    }

    func applicationDidEnterBackground(application: UIApplication)
    {
        
    }

    func applicationWillEnterForeground(application: UIApplication)
    {

    }

    func applicationDidBecomeActive(application: UIApplication)
    {

    }

    func applicationWillTerminate(application: UIApplication)
    {

    }

    //MARK: Remote Notification Methods
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData)
    {
        //MARK: Warning need to check
        self.strDeviceToken = "\(deviceToken)".stringByReplacingOccurrencesOfString(" ", withString: "").stringByReplacingOccurrencesOfString("<", withString: "").stringByReplacingOccurrencesOfString(">", withString: "")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError)
    {
        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject])
    {
        
    }
    
    // MARK: Reachability Check
    
    func checkReachability() -> Bool
    {
        do
        {
            self.reachability = try Reachability.reachabilityForInternetConnection()
            
            if (self.reachability!.isReachable())
            {
                return true
            }
            else
            {
                return false
            }
        }
        catch
        {
            return false
        }
    }
    
    // MARK: Check User
    
    func checkUserAvailability() {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var initialViewController = UIViewController()
        if let _ = userDefaults.objectForKey("userdata") {
            initialViewController = storyboard.instantiateViewControllerWithIdentifier("NavBoozeHound")
        }
        else {
            initialViewController = storyboard.instantiateViewControllerWithIdentifier("NavLogin")
        }
        self.window!.rootViewController = initialViewController
        self.window!.makeKeyAndVisible()
    }
}

