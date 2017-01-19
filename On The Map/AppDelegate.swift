//
//  AppDelegate.swift
//  On The Map
//
//  Created by SimranJot Singh on 25/12/16.
//  Copyright © 2016 SimranJot Singh. All rights reserved.
//

import UIKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: Properties
    
    var window: UIWindow?

    //MARK: UIApplicationDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FBSDKSettings.setAppURLSchemeSuffix(AppConstants.facebookLogin.URLSuffix)
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == AppConstants.facebookLogin.URLScheme {
            return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: UIApplicationOpenURLOptionsKey.sourceApplication.rawValue, annotation: nil
            )
        } else {
            return true
        }
    }


}

