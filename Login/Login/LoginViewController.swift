//
//  LoginViewController.swift
//  Login
//
//  Created by MICHAEL on 2018-11-04.
//  Copyright © 2018 Michael Truong. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var forgotUserButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Utilize the extension code to underline text fields
        usernameField.addUnderline()
        passwordField.addUnderline()
        
        // Round the button borders
        signInButton.layer.cornerRadius = 20
        signInButton.clipsToBounds = true
        
        // Handle Text Field Input with Delegate
        usernameField.delegate = self
        passwordField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else { return }
        
        if sender == forgotUserButton {
            segue.destination.navigationItem.title = "Forgot Username"
        } else if sender == forgotPasswordButton {
            segue.destination.navigationItem.title = "Forgot Password"
        }
    }
    
    // MARK: Actions
    @IBAction func forgotUsernamePressed(_ sender: Any) {
        performSegue(withIdentifier: "ForgottenUsernameOrPassowrd", sender: sender)
    }
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        performSegue(withIdentifier: "ForgottenUsernameOrPassowrd", sender: sender)
    }
    @IBAction func signInPressed(_ sender: Any) {
        performSegue(withIdentifier: "LandingPage", sender: nil)
    }
    
    // MARK: UITextField Delegate Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
