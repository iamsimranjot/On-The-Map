//
//  OnTheMapTabBarController.swift
//  On The Map
//
//  Created by SimranJot Singh on 06/01/17.
//  Copyright © 2017 SimranJot Singh. All rights reserved.
//

import UIKit
import FBSDKLoginKit

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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstants.notifications.loading), object: nil)
        udacity_otm.logout(){ (success, error) in
            if success == true {
                DispatchQueue.main.async {
                    FBSDKLoginManager().logOut()
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
        if let currentStudent = dataSource_otm.studentUser {
            parse_otm.getParticularStudentLocation(uniqueKey: currentStudent.uniqueKey) { (location, error) in
                DispatchQueue.main.async {
                    if let location = location {
                        self.overwriteAlert() { (alert) in
                            self.presentPostingVC(objectId: location.objectID)
                        }
                    } else {
                        self.presentPostingVC()
                    }
                }
            }
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstants.notifications.loading), object: nil)
        dataSource_otm.pinDownStudentsLocations()
    }
    
    //MARK: Helper Methods
    
    private func presentPostingVC (objectId: String? = nil){
        performSegue(withIdentifier: AppConstants.Identifiers.postingSegue, sender: objectId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PostingViewController {
            destination.objectId = sender as! String?
        }
    }
    
    private func alertWithError(error: String, title: String) {
        let alertView = UIAlertController(title: title, message: error, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: AppConstants.AlertActions.dismiss, style: .cancel, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
    private func overwriteAlert(completionClosure: @escaping (UIAlertAction) -> Void){
        let alertView = UIAlertController(title: AppConstants.Alert.overWriteAlert, message: AppConstants.Alert.overWriteMessage, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: AppConstants.AlertActions.cancel, style: .cancel, handler: nil))
        alertView.addAction(UIAlertAction(title: AppConstants.AlertActions.overWrite, style: .default, handler: completionClosure))
        self.present(alertView, animated: true, completion: nil)
    }
    
    func studentLocationsPinnedDownError() {
        alertWithError(error: AppConstants.Errors.unableToUpdateLocations, title: "")
    }
    
}
