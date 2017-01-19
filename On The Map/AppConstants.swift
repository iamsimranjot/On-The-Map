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
    
    //MARK: Identifiers
    
    struct Identifiers {
        static let loginSegue = "Login"
        static let dropPinReuse = "DropPin"
        static let studentLocationCell = "StudentLocationCell"
        static let postingSegue = "presentPostingVC"
    }
    
    //MARK: Errors
    
    struct Errors {
        static let usernameEmpty = "Please provide an Email Address."
        static let passwordEmpty = "Please provide the password."
        static let cannotOpenURL = "Cannot Open URL"
        static let unableToUpdateLocations = "Unable to update and pin down student locations."
        static let emptyurl = " You must enter a URL."
        static let emptyLocation = "Must enter a Location."
        static let couldNotGeocode = "Could not geocode the string."
        static let noLocationFound = "No location found."
        static let postingFailed = "Student location could not be posted."
    }
    
    //MARK: Alerts
    
    struct Alert {
        static let LoginAlertTitle = "Login Error"
        static let LogoutAlertTitle = "Logout Error"
        static let overWriteAlert = "Overwrite Location?"
        static let overWriteMessage = "You've already posted a pin. Would you like to overwrite it?"
    }
    
    //MARK: Alert Actions
    
    struct AlertActions {
        static let dismiss = "Dismiss"
        static let overWrite = "Overwrite"
        static let cancel = "Cancel"
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
