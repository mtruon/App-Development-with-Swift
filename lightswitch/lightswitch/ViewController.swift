//
//  ViewController.swift
//  lightswitch
//
//  Created by MICHAEL on 2018-11-01.
//  Copyright © 2018 Michael Truong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    var lightOn = false
    let lightOnColor = UIColor(red: 1.0, green: (204/255), blue: 0, alpha: 1)
    let lightOffColour = UIColor(red: (25/255), green: (25/255), blue: (25/255), alpha: 1)
    
    // MARK: Outlet
    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var lightOnImage: UIImageView!    
    @IBOutlet weak var lightLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup shadow for the light bulb
        lightButton.layer.shadowColor = UIColor.white.cgColor
        lightButton.layer.shadowRadius = 10
    }
    
    func updateUI() {
        lightButton.layer.shadowOpacity = lightOn ? 1 : 0
        UIView.animate(withDuration: 0.5) {
            if self.lightOn {
                self.lightOnImage.alpha = 1
                self.view.backgroundColor = self.lightOnColor
                self.lightLabel.textColor = UIColor.black
                self.lightLabel.text = "Remember to turn it off.."
            } else {
                self.lightOnImage.alpha = 0.15
                self.view.backgroundColor = self.lightOffColour
                self.lightLabel.textColor = UIColor.white
                self.lightLabel.text = "Turn the light on!"
            }
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        lightOn = !lightOn
        updateUI()
    }
    
}

