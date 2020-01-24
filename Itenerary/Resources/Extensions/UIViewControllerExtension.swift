//
//  UIViewControllerExtension.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 24/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

extension UIViewController {
	
	/// Returnes the initial view controller on a storyboard that is named the same as the caller.
	static func getInstance() -> UIViewController {
		let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
		return storyboard.instantiateInitialViewController()!
	}
	
}
