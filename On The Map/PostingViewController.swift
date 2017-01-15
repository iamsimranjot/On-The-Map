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
    private var mark: CLPlacemark? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func configureUI(_ state: UIState, location: CLLocationCoordinate2D? = nil) {
        switch state {
        case .Find:
            topSectionLabelView.isHidden = false
            mapKitView.isHidden = true
            mediaURLTextField.isHidden = true
            middleSection.backgroundColor = UIColor.black //to be done
            bottomSection.isOpaque = false
            locationTextField.isHidden = false
            findButton.isHidden = false
            submitButton.isHidden = true
        case .Submit:
            topSectionLabelView.isHidden = true
            mapKitView.isHidden = false
            mediaURLTextField.isHidden = false
            middleSection.backgroundColor = UIColor.clear
            bottomSection.isOpaque = true
            locationTextField.isHidden = true
            findButton.isHidden = true
            submitButton.isHidden = false
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
