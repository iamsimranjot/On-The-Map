//
//  Facebook_OTM.swift
//  On The Map
//
//  Created by SimranJot Singh on 11/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class Facebook_OTM {
    
    // MARK: Properties
    
    private let fbLoginManager = FBSDKLoginManager()
    
    // MARK: Singleton Instance
    
    private static var sharedInstance = Facebook_OTM()
    
    class func sharedManager() -> Facebook_OTM {
        return sharedInstance
    }
    
    // MARK: Access Token
    
    func currentAccessToken() -> FBSDKAccessToken! {
        return FBSDKAccessToken.current()
    }
    
    // MARK: Logout
    
    func logout() {
        fbLoginManager.logOut()
    }
}
