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
        itemTableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertWithError(error: String) {
        let alertView = UIAlertController(title: "", message: error, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: AppConstants.AlertActions.dismiss, style: .cancel, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
}

extension OTMTableViewController: UITableViewDataSource, UITableViewDelegate {
 
    //MARK: Table Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource_otm.studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.Identifiers.studentLocationCell) as! StudentLocationCell
        let studentLocation = dataSource_otm.studentLocations[indexPath.row]
        cell.configureStudentLocationCell(studentLocation: studentLocation)
        return cell
    }
    
    //MARK: Table Delegates
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentURL = dataSource_otm.studentLocations[indexPath.row].student.mediaURL
        
        // Check if it exists & proceed accordingly
        if let studentMediaURL = URL(string: studentURL), UIApplication.shared.canOpenURL(studentMediaURL) {
            // Open URL
            UIApplication.shared.open(studentMediaURL)
        } else {
            // Return with Error
            alertWithError(error: AppConstants.Errors.cannotOpenURL)
        }
    }
    
}
