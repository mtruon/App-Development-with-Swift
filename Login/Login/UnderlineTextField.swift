//
//  UnderlineTextField.swift
//  Login
//
//  Created by MICHAEL on 2018-11-04.
//  Copyright © 2018 Michael Truong. All rights reserved.
//

import UIKit

class UnderlineTextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUnderline()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUnderline()
    }
    
    func initUnderline() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: 1.0)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
