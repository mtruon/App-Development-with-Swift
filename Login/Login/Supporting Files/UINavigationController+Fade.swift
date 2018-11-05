//
//  UINavigationController+Fade.swift
//  Login
//
//  Created by MICHAEL on 2018-11-04.
//  Copyright © 2018 Michael Truong. All rights reserved.
//

import UIKit

extension UINavigationController {
    func fadeTo(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
}
