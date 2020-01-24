//
//  AddDayViewController.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 24/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

class AddDayViewController: UIViewController {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var subtitleTextField: UITextField!
	@IBOutlet weak var cancelButton: UIButton!
	@IBOutlet weak var saveButton: UIButton!
	
	
	/// A callback that the presenting view controller should implement in its `prepare(for:sender:)` function.
	var doneSaving: (() -> ())?
	var tripIndexToEdit: Int?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
		titleLabel.layer.shadowOpacity = 1
		titleLabel.layer.shadowColor = UIColor.white.cgColor
		titleLabel.layer.shadowOffset = .zero
		titleLabel.layer.shadowRadius = 3
	}
	
	@IBAction func cancel(_ sender: UIButton) {
		dismiss(animated: true)
	}
	
	@IBAction func save(_ sender: UIButton) {
		titleTextField.rightViewMode = .never
		
		guard let newTripName = titleTextField.text, newTripName != "" else {
			let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
			imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
			imageView.layer.shadowOpacity = 1
			imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
			imageView.layer.shadowRadius = 2
			imageView.tintColor = .yellow
			imageView.contentMode = .scaleAspectFit
			titleTextField.rightView = UIView()
			titleTextField.rightView?.sizeToFit()
			titleTextField.rightView?.addSubview(imageView)
			imageView.center = .init(x: titleTextField.rightView!.center.x - 16, y: titleTextField.rightView!.center.y)
			titleTextField.rightViewMode = .always
			return
		}
		
//		if let index = tripIndexToEdit {
//			TripFunctions.updateTrip(at: index, title: newTripName, image: imageView.image)
//		} else {
//			TripFunctions.createTrip(TripModel(title: newTripName, image: imageView.image))
//		}
		
		if let doneSaving = doneSaving {
			doneSaving()
		}
		dismiss(animated: true)
	}

}
