//
//  StudentLocationModel.swift
//  On The Map
//
//  Created by SimranJot Singh on 08/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

struct StudentLocationModel {
    
    //MARK: Properties
    
    let student: StudentModel
    let location: LocationModel
    let objectID: String
    
    init(dictionary: [String : AnyObject]) {
        objectID = dictionary[Parse_OTM.JSONResponseKeys.objectID] as? String ?? ""
        
        // Fill StudentModel Data
        let firstName = dictionary[Parse_OTM.JSONResponseKeys.firstName] as? String ?? ""
        let lastName = dictionary[Parse_OTM.JSONResponseKeys.lastName] as? String ?? ""
        let uniqueKey = dictionary[Parse_OTM.JSONResponseKeys.uniqueKey] as? String ?? ""
        let mediaURL = dictionary[Parse_OTM.JSONResponseKeys.mediaURL] as? String ?? ""
        student = StudentModel(uniqueKey: uniqueKey, firstName: firstName, lastName: lastName, mediaURL: mediaURL)
        
        // Fill LocationModel Data
        let latitude = dictionary[Parse_OTM.JSONResponseKeys.latitude] as? Double ?? 0.0
        let longitude = dictionary[Parse_OTM.JSONResponseKeys.longitude] as? Double ?? 0.0
        
        
        let mapString = dictionary[Parse_OTM.JSONResponseKeys.mapString] as? String ?? ""
        location = LocationModel(latitude: latitude, longitude: longitude, mapString: mapString)
    }
    
    //Helper Methods
    static func locationsFromDictionaries(dictionaries: [[String:AnyObject]]) -> [StudentLocationModel] {
        var studentLocations = [StudentLocationModel]()
        for studentDictionary in dictionaries {
            studentLocations.append(StudentLocationModel(dictionary: studentDictionary))
        }
        return studentLocations
    }
}
