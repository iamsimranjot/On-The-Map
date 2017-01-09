//
//  DataSource_OTM.swift
//  On The Map
//
//  Created by SimranJot Singh on 10/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

import UIKit

class DataSource_OTM: NSObject {
    
    //MARK: Properties
    
    let studentLocations = [StudentLocationModel]()
    let studentUser: StudentModel? = nil
    
    //MARK: Singleton Instance
    private static let sharedInstance = DataSource_OTM()
    
    class func sharedDataSource_OTM() -> DataSource_OTM  {
        return sharedInstance
    }
}
