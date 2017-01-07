//
//  StudentModel.swift
//  On The Map
//
//  Created by SimranJot Singh on 07/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

struct StudentModel {
    
    let uniqueKey: String
    let firstName: String
    let lastName: String
    var mediaURL: String
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    init(uniqueKey: String, firstName: String, lastName: String, mediaURL: String) {
        self.uniqueKey = uniqueKey
        self.firstName = firstName
        self.lastName = lastName
        self.mediaURL = mediaURL
    }
    
}
