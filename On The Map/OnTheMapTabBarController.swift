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

    //MARK: LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
                    self.alertWithError(error: error!)
                }
            }
        }
        
    }
    
    @IBAction func addPin(_ sender: Any) {
    }
    
    @IBAction func refresh(_ sender: Any) {
    }
    
    //MARK: Helper Methods
    
    private func alertWithError(error: String) {
        let alertView = UIAlertController(title: AppConstants.Alert.LogoutAlertTitle, message: error, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: AppConstants.AlertActions.dismiss, style: .cancel, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
}
