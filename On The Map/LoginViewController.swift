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
        
        //Confirm TextFields Delegate's
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    //MARK: Actions
    
    @IBAction func loginClicked(_ sender: Any) {
        
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            throwError()
        } else {
            
            // Set UI State
            setUIForState(.Login)
            
            udacity_otm.loginWithCredentials(username: emailTextField.text!, password: passwordTextField.text!) { (userKey, error) in
                
                DispatchQueue.main.async {
                    //Check for user key
                    if let userKey = userKey {
                        self.udacity_otm.fetchStudentData(fromKey: userKey) { (student, error) in
                            DispatchQueue.main.async {
                                if let _ = student {
                                    self.performSegue(withIdentifier: AppConstants.segueIdentifiers.loginSegue, sender: self)
                                } else {
                                    self.alertWithError(error: error!)
                                }
                            }
                        }
                    } else {
                        self.alertWithError(error: error!)
                    }
                }
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
            
        case .Initialize:
            loginButton.layer.cornerRadius = 4.0
            passwordTextField.isSecureTextEntry = true
            errorLabel.text = ""
            
        case .Normal:
            setEnabled(enabled: true)
            emailTextField.text = ""
            passwordTextField.text = ""
            activityIndicator.stopAnimating()
            contentStackView.alpha = 1.0
    
        case .Login:
            setEnabled(enabled: false)
            activityIndicator.startAnimating()
            contentStackView.alpha = 0.5
            errorLabel.text = ""
        }
    }
    
    private func setEnabled(enabled: Bool){
        activityIndicator.isHidden = enabled
        loginButton.isEnabled = enabled
        emailTextField.isEnabled = enabled
        passwordTextField.isEnabled = enabled
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
            animate.duration = 0.1
            animate.repeatCount = 2
            animate.autoreverses = true
            animate.fromValue = NSValue(cgPoint: CGPoint(x: self.contentStackView.center.x - 5, y: self.contentStackView.center.y))
            animate.toValue = NSValue(cgPoint: CGPoint(x: self.contentStackView.center.x + 5, y: self.contentStackView.center.y))
            self.contentStackView.layer.add(animate, forKey: "shake")
        }
    }
        
    private func alertWithError(error: String) {
        setUIForState(.Normal)
        let alertView = UIAlertController(title: AppConstants.Alert.LoginAlertTitle, message: error, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: AppConstants.AlertActions.dismiss, style: .cancel, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
