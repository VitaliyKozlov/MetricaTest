//
//  AppDelegate.swift
//  MetricaTest
//
//  Created by Vitaliy Kozlov on 31/03/2019.
//  Copyright © 2019 Vitaliy Kozlov. All rights reserved.
//

import UIKit
import YandexMobileMetrica
import AppsFlyerLib
import FacebookCore
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppsFlyerTrackerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: appMetricaKey)
        YMMYandexMetrica.activate(with: configuration!)
        
        AppsFlyerTracker.shared().appsFlyerDevKey = appsFlyerDevKey
        AppsFlyerTracker.shared().appleAppID = appId
       AppsFlyerTracker.shared().delegate = self
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        
        /*if userActivity!.activityType == NSUserActivityTypeBrowsingWeb {
            if let url = userActivity!.webpageURL {
                
            }
        }*/
        return Deeplinker.handleDeeplink(url: url)
        
     
    }

    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        print ("TEST!!!!")
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            print (userActivity.webpageURL)
            if let url = userActivity.webpageURL {
                return Deeplinker.handleDeeplink(url: url)
            }
        }
        return false
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Track Installs, updates & sessions(app opens) (You must include this API to enable tracking)
        AppsFlyerTracker.shared()?.trackAppLaunch()
        print ("Active")
         Deeplinker.checkDeepLink()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

