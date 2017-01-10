//
//  Parse_OTM.swift
//  On The Map
//
//  Created by SimranJot Singh on 06/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

import Foundation

class Parse_OTM {
    
    //MARK: Properties
    
    let sessionObject: SessionManager
    
    //MARK: Singleton Class
    
    private static var sharedManager = Parse_OTM()
    
    class func sharedInstance() -> Parse_OTM {
        return sharedManager
    }
    
    //MARK: Init Method
    
    init() {
        let apiUrlData = APIUrlData(scheme: APIComponents.scheme, host: APIComponents.host, path: APIComponents.path)
        sessionObject = SessionManager(apiData: apiUrlData)
    }
    
    //MARK: Make Parse Client's Request
    
    private func makeRequestToParse(url: URL, method: HTTPMethod, body: [String : AnyObject]? = nil, responseClosure
        : @escaping (_ jsonAsDictionary: [String:AnyObject]?, _ error: String?) -> Void) {
        
        // Add Headers
        let requestHeaders = [
            RequestHeaderKeys.appId: RequestHeaderValues.appId,
            RequestHeaderKeys.APIKey: RequestHeaderValues.APIKey,
            RequestHeaderKeys.accept: RequestHeaderValues.application_json,
            RequestHeaderKeys.content_type: RequestHeaderValues.application_json
        ]
        
        //Make request
        sessionObject.makeRequest(Url: url, requestMethod: method, requestHeaders: requestHeaders, requestBody: body) { (data, error) in
            if let data = data{
                let jsonResponseDictionary = try! JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as!  [String : AnyObject]
                responseClosure(jsonResponseDictionary, nil)
            } else {
                responseClosure(nil, error)
            }
        }
    }
    
    //MARK: Get Multiple Student Locations
    
    func getMultipleStudentLocations(responseClosure: @escaping (_ studentLocations: [StudentLocationModel]?, _ error: String?) -> Void){
        
        // Build URL
        let url = sessionObject.urlForRequest(apiMethod: APIMethod.studentLocation, parameters: [
            ParameterKeys.limit: ParameterValues.hundred as AnyObject,
            ParameterKeys.order: ParameterValues.recentlyUpdated as AnyObject
            ])
        
        // Make Request
        makeRequestToParse(url: url, method: .GET){ (jsonResponseDic, error) in
            
            // Check for Errors
            guard error == nil else {
                responseClosure(nil, error)
                return
            }
            
            // Unwrap Response Json
            if let jsonResponseDic = jsonResponseDic, let studentLocationDics = jsonResponseDic[JSONResponseKeys.results] as? [[String : AnyObject]] {
                responseClosure(StudentLocationModel.locationsFromDictionaries(dictionaries: studentLocationDics), nil)
                return
            }
            
            responseClosure(nil, error)
        }
    }
    
    //MARK: Get Particular Student Location
    
    func getParticularStudentLocation(uniqueKey: String, responseClosure: @escaping (_ studentModel: StudentLocationModel?, _ error: String?) -> Void) {
        
        //Build URL
        let locationURL = sessionObject.urlForRequest(apiMethod: APIMethod.studentLocation, parameters: [ParameterKeys.Where: "{\"\(ParameterKeys.uniqueKey)\":\"" + "\(uniqueKey)" + "\"}" as AnyObject])
        
        //Make Request
        makeRequestToParse(url: locationURL, method: .GET) { (jsonResponseDic, error) in
            
            // Check for errors
            guard error == nil else {
                responseClosure(nil, error)
                return
            }
            
            // Unwrap Response Json
            if let jsonResponseDic = jsonResponseDic, let studentLocationDic = jsonResponseDic[JSONResponseKeys.results] as? [[String : AnyObject]] {
                if studentLocationDic.count == 1 {
                    responseClosure(StudentLocationModel(dictionary: studentLocationDic[0]), nil)
                    return
                }
            }
            
            responseClosure(nil, error)
        }
    }
    
}

//MARK: Constants Extension

extension Parse_OTM {
    
    //MARK: API Components Constants
    
    struct APIComponents {
        static let scheme = "https"
        static let host = "parse.udacity.com"
        static let path = "/parse/classes"
    }
    
    //MARK: APIMrthods
    
    struct APIMethod {
        static let studentLocation = "/StudentLocation"
    }
    
    //MARK: HeaderKeys
    
    struct RequestHeaderKeys {
        static let appId = "X-Parse-Application-Id"
        static let APIKey = "X-Parse-REST-API-Key"
        static let accept = "Accept"
        static let content_type = "Content-Type"
    }
    
    //MARK: HeaderValues
    
    struct RequestHeaderValues {
        static let appId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let application_json = "application/json"
    }
    
    //MARK: Parameter Keys
    
    struct ParameterKeys {
        static let limit = "limit"
        static let order = "order"
        static let Where = "where"
        static let uniqueKey = "uniqueKey"
    }
    
    //MARK: Parameter Values
    
    struct ParameterValues {
        static let hundred = 100
        static let recentlyUpdated = "-updatedAt"
        static let recentlyCreated = "-createdAt"
    }
    
    //MARK: JSONResponseKeys
    
    struct JSONResponseKeys {
        static let error = "error"
        static let results = "results"
        static let objectID = "objectId"
        static let updatedAt = "updatedAt"
        static let uniqueKey = "uniqueKey"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let mediaURL = "mediaURL"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let mapString = "mapString"
    }
    
    //MARK: Student Location Keys
    
    struct StudentLocationKeys {
        static let uniqueKey = "uniqueKey"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let mediaURL = "mediaURL"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let mapString = "mapString"
    }
    
}
