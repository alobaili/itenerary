//
//  UITextFieldExtension.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 24/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

extension UITextField {
	
	var hasValue: Bool {
		guard text == "" else { return true }
		
		let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
		imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
		imageView.layer.shadowOpacity = 1
		imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
		imageView.layer.shadowRadius = 2
		imageView.tintColor = .yellow
		imageView.contentMode = .scaleAspectFit
		rightView = UIView()
		rightView?.sizeToFit()
		rightView?.addSubview(imageView)
		imageView.center = .init(x: rightView!.center.x - 16, y: rightView!.center.y)
		rightViewMode = .unlessEditing
		
		return false
	}
	
}
