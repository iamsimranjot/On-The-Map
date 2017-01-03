//
//  SessionManager.swift
//  On The Map
//
//  Created by SimranJot Singh on 25/12/16.
//  Copyright © 2016 SimranJot Singh. All rights reserved.
//

import Foundation

//MARK: HTTP Request Method Enum

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

//MARK: APIUrlData

struct APIUrlData {
    let scheme: String
    let host: String
    let path: String
}

class SessionManager {
    
    //MARK: Properties
    
    private let session: URLSession!
    private let apiUrlData: APIUrlData
    
    //MARK: Initializer
    
    init(apiData: APIUrlData) {
        
        //Get your Configuration Object
        let sessionConfiguration = URLSessionConfiguration.default
        
        //Set the Configuration on your session object
        session = URLSession(configuration: sessionConfiguration)
        apiUrlData = apiData
    }
    
    //MARK: Data Task Request
    
    func makeRequest(Url: URL, requestMethod: HTTPMethod, requestHeaders: [String:String]? = nil, requestBody: [String:String]? = nil, responseClosure: (NSData?, NSError?)){
        
        //Create request from passed URL
        var request = URLRequest(url: Url)
        request.httpMethod = requestMethod.rawValue
        
    }
    
}
