//
//  UIButtonExtensions.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 11/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

extension UIButton {
    func createFloatingActionButton() {
        backgroundColor = Theme.tintColor
        layer.cornerRadius = frame.height / 2
        tintColor = .white
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
}
