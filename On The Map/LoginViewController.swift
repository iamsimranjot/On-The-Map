//
//  LoginViewController.swift
//  On The Map
//
//  Created by SimranJot Singh on 25/12/16.
//  Copyright © 2016 SimranJot Singh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: UI Configuration Enum
    private enum UIElementState { case Initialize, Normal, Login }
    
    //MARK: Outlets & Properties
    
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUIForState(.Initialize)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        performSegue(withIdentifier: "Login", sender: self)
    }

    @IBAction func signUpClicked(_ sender: Any) {
    }
    
    private func setUIForState(_ state: UIElementState) {
        switch state {
        case .Normal:
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            loginButton.isEnabled = true
            contentStackView.alpha = 1.0
        
        case .Login:
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            loginButton.isEnabled = false
            contentStackView.alpha = 0.5
            errorLabel.text = ""
            
        default: break
        }
    }

}
