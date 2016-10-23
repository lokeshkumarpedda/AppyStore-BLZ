//
//  AppDelegate.swift
//  AppyStoreBLZ
//
//  Created by Shelly on 01/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.All
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        hotlineIntegration()
        
        
        return true
    }
    func hotlineIntegration()
    {
        //setting the configuration with app id and key
        let config = HotlineConfig.init(appID: "07996bb5-47b0-4c10-8f53-59d71900a411", andAppKey: "1a62b09a-9bf6-45f8-918c-330fdf2557f3")
        
        // Create a user object
        let user = HotlineUser.sharedInstance();
        
        // To set an identifiable name for the user
        user.name = "Ten";
        
        //To set user's email id
        user.email = "ben10.lokesh@mail.com";
        
        //To set user's phone number
        user.phoneCountryCode="91";
        user.phoneNumber = "9035932951";
        
        //To set user's identifier (external id to map the user to a user in your system. Setting an external ID is COMPULSARY for many of Hotline’s APIs
        user.externalID="ben.lokesh.7";
        
        // FINALLY, REMEMBER TO SEND THE USER INFORMATION SET TO HOTLINE SERVERS
        Hotline.sharedInstance().updateUser(user)
        
        //You can set custom user properties for a particular user
        Hotline.sharedInstance().updateUserPropertyforKey("customerType", withValue: "Premium")
        
        //You can set user demographic information
        Hotline.sharedInstance().updateUserPropertyforKey("city", withValue: "Mumbai")
        
        //You can segment based on where the user is in their journey of using your app
        Hotline.sharedInstance().updateUserPropertyforKey("loggedIn", withValue: "true")
        
        //You can capture a state of the user that includes what the user has done in your app
        Hotline.sharedInstance().updateUserPropertyforKey("transactionCount", withValue: "3")
        
        //Managing Badge number for unread messages - Manual
        Hotline.sharedInstance().initWithConfig(config)
        print("Unread messages count \(Hotline.sharedInstance().unreadCount()) .")
        
        Hotline.sharedInstance().unreadCountWithCompletion { (count:Int) -> Void in
            print("Unread count (Async) :\(count)")
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
        let unreadCount : NSInteger = Hotline.sharedInstance().unreadCount()
        UIApplication.sharedApplication().applicationIconBadgeNumber = unreadCount;
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Hotline.sharedInstance().updateDeviceToken(deviceToken)
    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        if Hotline.sharedInstance().isHotlineNotification(userInfo){
            Hotline.sharedInstance().handleRemoteNotification(userInfo, andAppstate: application.applicationState)
        }
    }
}

