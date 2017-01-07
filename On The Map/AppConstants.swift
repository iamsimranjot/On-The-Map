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
    
    struct segueIdentifiers {
        static let loginSegue = "Login"
    }
    
    //MARK: Errors
    
    struct Errors {
        static let usernameEmpty = "Please provide an Email Address."
        static let passwordEmpty = "Please provide the password."
    }
    
    //MARK: Alerts
    
    struct Alert {
        static let LoginAlertTitle = "Login Error"
    }
    
    //MARK: Alert Actions
    
    struct AlertActions {
        static let dismiss = "Dismiss"
    }
}
