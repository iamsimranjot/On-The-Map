//
//  OTMTableViewController.swift
//  On The Map
//
//  Created by Simranjot Singh on 10/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

import UIKit

class OTMTableViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var itemTableView: UITableView!
    
    //MARK: Properties
    
    let dataSource_otm = DataSource_OTM.sharedDataSource_OTM()
    
    //MARK: LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
