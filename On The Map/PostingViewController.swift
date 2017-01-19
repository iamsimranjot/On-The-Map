//
//  PostingViewController.swift
//  On The Map
//
//  Created by SimranJot Singh on 14/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

import UIKit
import MapKit

class PostingViewController: UIViewController {
    
    //MARK: UI Configuration Enum
    private enum UIState { case Find, Submit }
    
    //MARK: Outlets
    
    @IBOutlet weak var topSection: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var topSectionLabelView: UIView!
    @IBOutlet weak var mediaURLTextField: UITextField!
    @IBOutlet weak var middleSection: UIView!
    @IBOutlet weak var mapKitView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var bottomSection: UIView!
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Properties
    
    private let dataSource_otm = DataSource_OTM.sharedDataSource_OTM()
    private let parse_otm = Parse_OTM.sharedInstance()
    var objectId: String? = nil
    private var mark: CLPlacemark? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpInitialUI()
        configureUI(.Find)
    }
    
    //MARK: Top Section
    
    @IBAction func cancelClicked(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Middle Section
    
    
    //MARK: Bottom Section
    
    @IBAction func submitClicked(_ sender: AnyObject) {
        
    }
    
    @IBAction func findClicked(_ sender: AnyObject) {
        
        // Check if location textfield is empty or not.
        if (locationTextField.text?.isEmpty)! {
            showAlert(message: AppConstants.Errors.emptyLocation)
            return
        }
        
        // Set loading view
        setLoadingView()
        
        //Add the placemark on the location
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(locationTextField.text!) { (placemarkArr, error) in
            
            //Check for errors
            if let _ = error {
                self.showAlert(message: AppConstants.Errors.couldNotGeocode)
            } else if (placemarkArr?.isEmpty)! {
                self.showAlert(message: AppConstants.Errors.noLocationFound)
            } else {
                self.mark = placemarkArr?.first
                self.configureUI(.Submit)
                self.unSetLoadingView()
                self.mapView.showAnnotations([MKPlacemark(placemark: self.mark!)], animated: true)
            }
        }
    }
    
    //MARK: Helper Methods
    
    private func configureUI(_ state: UIState, location: CLLocationCoordinate2D? = nil) {
        switch state {
        case .Find:
            setHiddenElements(false)
            middleSection.backgroundColor = UIColor(hex: 0x3b5998)
        case .Submit:
            setHiddenElements(true)
            topSection.backgroundColor = UIColor(hex: 0x3b5998)
            middleSection.backgroundColor = UIColor.clear
        }
    }
    
    
    private func setLoadingView() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        enableUI(false)
        setAlphaForUI(0.5)
    }
    
    private func unSetLoadingView() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        enableUI(true)
        setAlphaForUI(1.0)
    }
    
    private func enableUI(_ enable: Bool) {
        findButton.isEnabled = enable
        cancelButton.isEnabled = enable
        locationTextField.isEnabled = enable
        //top section label to be done
    }
    
    private func setAlphaForUI(_ alpha: CGFloat) {
        findButton.alpha = alpha
        cancelButton.alpha = alpha
        locationTextField.alpha = alpha
    }
    
    private func setUpInitialUI() {
        locationTextField.delegate = self
        mediaURLTextField.delegate = self
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    private func setHiddenElements(_ hidden: Bool) {
        topSectionLabelView.isHidden = hidden
        mapKitView.isHidden = !hidden
        mediaURLTextField.isHidden = !hidden
        bottomSection.isOpaque = hidden
        locationTextField.isHidden = hidden
        findButton.isHidden = hidden
        submitButton.isHidden = !hidden
    }
    
    private func showAlert(message: String, completionClosure: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            self.unSetLoadingView()
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: AppConstants.AlertActions.dismiss, style: .default, handler: completionClosure))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - OTMPostingViewController: UITextFieldDelegate

extension PostingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
