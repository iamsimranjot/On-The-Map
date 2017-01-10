//
//  AppConstants.swift
//  On The Map
//
//  Created by SimranJot Singh on 06/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

import UIKit

//MARK : App Constants Main Struct

struct AppConstants {
    
    //MARK: Segue Identifiers
    
    struct Identifiers {
        static let loginSegue = "Login"
        static let dropPinReuse = "DropPin"
        static let studentLocationCell = "StudentLocationCell"
    }
    
    //MARK: Errors
    
    struct Errors {
        static let usernameEmpty = "Please provide an Email Address."
        static let passwordEmpty = "Please provide the password."
        static let cannotOpenURL = "Cannot Open URL"
        static let unableToUpdateLocations = "Unable to update and pin down student locations."
    }
    
    //MARK: Alerts
    
    struct Alert {
        static let LoginAlertTitle = "Login Error"
        static let LogoutAlertTitle = "Logout Error"
    }
    
    //MARK: Alert Actions
    
    struct AlertActions {
        static let dismiss = "Dismiss"
    }
    
    //MARK: Notifications Names
    
    struct notifications {
        static let studentLocationsPinnedDown = "Student Locations Pinned Down"
        static let studentLocationsPinnedDownError = "Student Locations Pinned Down Error"
        static let loading = "Loading"
    }
    
    struct facebookLogin {
        static let AppID = "365362206864879"
        static let URLSuffix = "onthemap"
        static let URLScheme = "fb\(AppID)\(URLSuffix)"
    }
}
