//
//  ViewController.swift
//  Login
//
//  Created by MICHAEL on 2018-11-04.
//  Copyright © 2018 Michael Truong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Applying rounded borders to the signup and login button
        signUpButton.layer.cornerRadius = 20
        signUpButton.clipsToBounds = true
        logInButton.layer.cornerRadius = 20
        logInButton.clipsToBounds = true
        
        // Setting the title colours of the navigation item's to white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else { return }
        
        // WIP: TBD
        if sender == logInButton {
            navigationController?.fadeTo(segue.destination)
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        // Leads to no where -- End project
    }
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "LogIn", sender: nil)
    }
}

