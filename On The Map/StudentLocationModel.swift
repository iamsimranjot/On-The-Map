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
        let firstName = dictionary[Parse_OTM.JSONResponseKeys.firstName]
        let lastName = dictionary[Parse_OTM.JSONResponseKeys.lastName]
        let uniqueKey = dictionary[Parse_OTM.JSONResponseKeys.uniqueKey]
        let mediaURL = dictionary[Parse_OTM.JSONResponseKeys.mediaURL]
        student = StudentModel(uniqueKey: uniqueKey as! String, firstName: firstName as! String, lastName: lastName as! String, mediaURL: mediaURL as! String)
        
        // Fill LocationModel Data
        let latitude = dictionary[Parse_OTM.JSONResponseKeys.latitude]
        let longitude = dictionary[Parse_OTM.JSONResponseKeys.longitude]
        
        
        let mapString = dictionary[Parse_OTM.JSONResponseKeys.mapString]
        location = LocationModel(latitude: latitude as! Double, longitude: longitude as! Double, mapString: mapString as! String)
    }
    
    //Helper Method
    static func locationsFromDictionaries(dictionaries: [[String:AnyObject]]) -> [StudentLocationModel] {
        var studentLocations = [StudentLocationModel]()
        for studentDictionary in dictionaries {
            studentLocations.append(StudentLocationModel(dictionary: studentDictionary))
        }
        return studentLocations
    }
}
