//
//  LoginViewController.swift
//  Spacemate
//
//  Created by Melanie Gravier on 7/17/18.
//  Copyright © 2018 Mel. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInSignUpButton: UIButton!
    
    @IBOutlet weak var changeLogInSignUpButton: UIButton!
    
    var signUpMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInSignUpTapped(_ sender: Any) {
        if signUpMode {
            let user = PFUser()
            
            user.username = usernameTextField.text
            user.password = passwordTextField.text
            
            user.signUpInBackground(block: { (success, error) in
                if error != nil {
                    var errorMessage = "Sign up failed, try again."
                    
                    if let newError = error as NSError? {
                        if let detailError = newError.userInfo["error"] as? String {
                            errorMessage = detailError
                        }
                    }
                    
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = errorMessage
                    
                } else {
                    print("Sign up successful!")
                }
            })
        } else {
            if let username = usernameTextField.text {
                if let password = passwordTextField.text {
                    PFUser.logInWithUsername(inBackground: username, password: password, block: { (user, error) in
                        if error != nil {
                            var errorMessage = "Login failed, try again."
                            
                            if let newError = error as NSError? {
                                if let detailError = newError.userInfo["error"] as? String {
                                    errorMessage = detailError
                                }
                            }
                            
                            self.errorLabel.isHidden = false
                            self.errorLabel.text = errorMessage
                            
                        } else {
                            print("Login successful!")
                        }
                    })
                }
            }
            
        }
    }
    
    
    @IBAction func changeLogInSignUpTapped(_ sender: Any) {
        if signUpMode {
            // execute code if user is already signed up
            logInSignUpButton.setTitle("Log In", for: .normal)
            changeLogInSignUpButton.setTitle("Sign Up", for: .normal)
            signUpMode = false
        } else {
            // execute if the user is not signed up yet
            logInSignUpButton.setTitle("Sign Up", for: .normal)
            changeLogInSignUpButton.setTitle("Log In", for: .normal)
            signUpMode = true
        }
    }
    

}
