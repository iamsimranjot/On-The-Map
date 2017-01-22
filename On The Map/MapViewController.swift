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
        observe()
        
        dataSource_otm.pinDownStudentsLocations()
    }

    //MARK: Helper Methods
    
    func alertWithError(error: String) {
        UIApplication.shared.endIgnoringInteractionEvents()
        self.view.alpha = 1.0
        let alertView = UIAlertController(title: "", message: error, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: AppConstants.AlertActions.dismiss, style: .cancel, handler: nil))
        self.present(alertView, animated: true){
            self.view.alpha = 1.0
        }
    }
    
    func studentLocationsUpdated() {
        
        if dataSource_otm.studentLocations.isEmpty {
            alertWithError(error: AppConstants.Errors.fetchingFailed)
            return
        }
        
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
            UIApplication.shared.endIgnoringInteractionEvents()
            self.view.alpha = 1.0
        }
    }
    
    func observe() {
        // Observe Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(studentLocationsUpdated), name: NSNotification.Name(rawValue: AppConstants.notifications.studentLocationsPinnedDown), object: nil)
    }
}

// MARK: - OTMMapViewController: MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = AppConstants.Identifiers.dropPinReuse
        
        var dropPinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if dropPinView == nil {
            dropPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            dropPinView!.canShowCallout = true
            dropPinView!.pinTintColor = UIColor.red
            dropPinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            dropPinView!.annotation = annotation
        }
        
        return dropPinView
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
