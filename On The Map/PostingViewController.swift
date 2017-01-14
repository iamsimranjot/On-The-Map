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
    
    //MARK: Outlets
    
    @IBOutlet weak var topSection: UIView!
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
