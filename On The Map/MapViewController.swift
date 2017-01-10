//
//  MapViewController.swift
//  On The Map
//
//  Created by SimranJot Singh on 07/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Properties
    
    let dataSource_otm = DataSource_OTM.sharedDataSource_OTM()
    
    //MARK: LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Confirm MapView Delegate
        mapView.delegate = self
        
        // Observe Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(studentLocationsUpdated), name: NSNotification.Name(rawValue: AppConstants.notifications.studentLocationsPinnedDown), object: nil)
        
        dataSource_otm.pinDownStudentsLocations()
    }

    //MARK: Cannot Open URL
    
    func alertWithError(error: String) {
        let alertView = UIAlertController(title: "", message: error, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: AppConstants.AlertActions.dismiss, style: .cancel, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
    func studentLocationsUpdated() {
        var annotations = [MKPointAnnotation]()
        
        for studentLocation in dataSource_otm.studentLocations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = studentLocation.location.coordinate
            annotation.title = studentLocation.student.fullName
            annotation.subtitle = studentLocation.student.mediaURL
            annotations.append(annotation)
        }
        
        DispatchQueue.main.async {
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotations(annotations)
        }
    }
}

// MARK: - OTMMapViewController: MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "OTMPin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let mediaURL = NSURL(string: ((view.annotation?.subtitle)!)!) {
                if UIApplication.shared.canOpenURL(mediaURL as URL) {
                    UIApplication.shared.open(mediaURL as URL)
                } else {
                    alertWithError(error: AppConstants.Errors.cannotOpenURL)
                }
            }
        }
    }
}
