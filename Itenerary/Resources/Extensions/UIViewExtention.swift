//
//  UIViewExtention.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 11/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadowAndRoundedCorners() {
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
    }
    
}
