//
//  AppButton.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 12/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

class AppButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = Theme.tintColor
        layer.cornerRadius = frame.height / 2
        setTitleColor(.white, for: .normal)
    }

}
