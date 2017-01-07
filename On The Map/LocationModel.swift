//
//  LocationModel.swift
//  On The Map
//
//  Created by SimranJot Singh on 08/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

import MapKit

struct LocationModel {
    let latitude: Double
    let longitude: Double
    let mapString: String
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
}
