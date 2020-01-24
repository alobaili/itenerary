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
	var doneSaving: ((DayModel) -> ())?
	var tripIndex: Int!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
	}
	
	@IBAction func cancel(_ sender: UIButton) {
		dismiss(animated: true)
	}
	
	@IBAction func save(_ sender: UIButton) {
		guard titleTextField.hasValue, let newTitle = titleTextField.text else { return }
		
		let dayModel = DayModel(title: newTitle, subtitle: subtitleTextField.text ?? "", data: nil)
		DayFunctions.createDay(dayModel, forTripAt: tripIndex)
		
		if let doneSaving = doneSaving {
			doneSaving(dayModel)
		}
		dismiss(animated: true)
	}

}
