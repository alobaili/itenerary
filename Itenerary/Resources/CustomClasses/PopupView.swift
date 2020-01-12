//
//  PopupView.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 12/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

class PopupView: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
        backgroundColor = Theme.backgroundColor
    }

}
