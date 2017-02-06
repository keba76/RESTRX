//
//  AppDelegate.swift
//  RESTRx
//
//  Created by Ievgen Keba on 2/2/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import UIKit
import SimpleAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var data = InstagramData()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white], for: .normal)
        
        SimpleAuth.configuration()["instagram"] = ["client_id" : "05794eedd1dd4f3fb9d954a31d0b407d", SimpleAuthRedirectURIKey :  "https://elfsight.com/service/generate-instagram-access-token/"]
        
        
        return true
    }
}

