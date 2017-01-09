//
//  OnTheMapTabBarController.swift
//  On The Map
//
//  Created by SimranJot Singh on 06/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

import UIKit

class OnTheMapTabBarController: UITabBarController {
    
    //MARK: Properties
    
    let udacity_otm = Udacity_OTM.sharedInstance()
    let parse_otm = Parse_OTM.sharedInstance()
    let dataSource_otm = DataSource_OTM.sharedDataSource_OTM()

    //MARK: LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Observe Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(studentLocationsPinnedDownError), name: NSNotification.Name(rawValue: AppConstants.notifications.studentLocationsPinnedDownError), object: nil)
    }

   //MARK: Actions
    
    @IBAction func logoutClicked(_ sender: Any) {
        udacity_otm.logout(){ (success, error) in
            if success == true {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async{
                    self.alertWithError(error: error!, title: AppConstants.Alert.LogoutAlertTitle)
                }
            }
        }
        
    }
    
    @IBAction func addPin(_ sender: Any) {
    }
    
    @IBAction func refresh(_ sender: Any) {
        dataSource_otm.pinDownStudentsLocations()
    }
    
    //MARK: Helper Methods
    
    private func alertWithError(error: String, title: String) {
        let alertView = UIAlertController(title: title, message: error, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: AppConstants.AlertActions.dismiss, style: .cancel, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
    func studentLocationsPinnedDownError() {
        alertWithError(error: AppConstants.Errors.unableToUpdateLocations, title: "")
    }
    
}
