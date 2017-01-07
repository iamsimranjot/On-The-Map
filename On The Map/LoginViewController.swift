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
    
    private let udacity_otm = Udacity_OTM.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUIForState(.Initialize)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Set UI State
        setUIForState(.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    @IBAction func loginClicked(_ sender: Any) {
        
        // Set UI State
        setUIForState(.Login)
        
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            throwError()
        } else {
            udacity_otm.loginWithCredentials(username: emailTextField.text!, password: passwordTextField.text!) { (userKey, error) in
//                dispatch_async(dispatch_get_main_queue()) {
//                    if let userKey = userKey {
//                        self.getStudentWithUserKey(userKey)
//
//                    } else {
//                        self.alertWithError(error!.localizedDescription)
//                    }
//                }
            }
        }
    }

    @IBAction func signUpClicked(_ sender: Any) {
        
        if let signUpURL = URL(string: Udacity_OTM.signUpURL), UIApplication.shared.canOpenURL(signUpURL) {
            UIApplication.shared.open(signUpURL)
        }
    }
    
    //MARK: Helper Methods
    
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
    
    private func throwError(){
        if emailTextField.text!.isEmpty {
            animateOnError(textField: emailTextField)
            errorLabel.text = AppConstants.Errors.usernameEmpty
        } else {
            animateOnError(textField: passwordTextField)
            errorLabel.text = AppConstants.Errors.passwordEmpty
        }
    }
    
    private func animateOnError(textField: UITextField){
        UIView.animate(withDuration: 1.0){
            let animate = CABasicAnimation.init(keyPath: "shake")
            animate.duration = 0.2
            animate.repeatCount = 2
            animate.autoreverses = true
            animate.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 5, y: textField.center.y))
            animate.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 5, y: textField.center.y))
            textField.layer.add(animate, forKey: "shake")
        }
    }
}
