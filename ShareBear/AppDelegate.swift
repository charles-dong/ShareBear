//
//  AppDelegate.swift
//  ShareBear
//
//  Created by Charles Dong on 1/17/15.
//  Copyright (c) 2015 Charles Dong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Parse - use Local Datastore (https://parse.com/docs/ios_guide#localdatastore/iOS)
        Parse.enableLocalDatastore()
        
        // Parse - Initialization
        Parse.setApplicationId("7BKJ9y88Z3uQoEmaXljrT2T0EviR3XesW4fNd0BN", clientKey: "QwqdYpwSUDJ6FnRHHmUI8PyrYrJfwvZNFIOjeH6x")
        
        // Parse - track statistics around application opens
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        
        // Parse - set up Facebook
        PFFacebookUtils.initializeFacebook()
        
        
        return true
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
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // Parse - Facebook Activation
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
        
        // Facebook - Logs 'install' and 'app activate' App Events.
        FBAppEvents.activateApp()
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        PFFacebookUtils.session().close()
    }
    
    // Parse - Facebook Login
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String,
        annotation: AnyObject?) -> Bool {
            return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication,
                withSession:PFFacebookUtils.session())
    }


}

