//
//  Udacity_OTM.swift
//  On The Map
//
//  Created by SimranJot Singh on 06/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

import Foundation

class Udacity_OTM {
    
    //MARK: Properties
    
    let sessionObject: SessionManager
    
    //MARK: Init Method
    
    init() {
        let apiUrlData = APIUrlData(scheme: APIComponents.scheme, host: APIComponents.host, path: APIComponents.path)
        sessionObject = SessionManager(apiData: apiUrlData)
    }
    
}

//MARK: Constants Extension

extension Udacity_OTM {
    
    //MARK: API Components Constants
    
    struct APIComponents {
        static let host = "https"
        static let scheme = "www.udacity.com"
        static let path = "api"
    }
    
    //MARK: API Methods
    
    struct APIMethods {
        static let session = "/session"
    }
    
    //MARK: API Header Keys
    
    struct APIHeaderKeys  {
        static let accept = "Accept"
        static let contentType = "Content-Type"
    }
    
    //MARK: API Requeest Body Keys
    
    struct HTTPBodyKeys {
        static let udacity = "udacity"
        static let username = "username"
        static let password = "password"
    }
    
    //MARK: JSON Response Keys
    
    struct JSONResponseKeys {
        static let account = "account"
        static let key = "key"
        static let session = "session"
        static let user = "user"
        static let firstName = "first_name"
        static let lastName = "last_Name"
    }
    
    //MARK: SignUp URL
    
    static let signUpURL = "https://www.udacity.com/account/auth#!/signup"
}
