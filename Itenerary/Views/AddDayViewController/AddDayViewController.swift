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
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var subtitleTextField: UITextField!
	@IBOutlet weak var cancelButton: UIButton!
	@IBOutlet weak var saveButton: UIButton!
	
	
	/// A callback that the presenting view controller should implement in its `prepare(for:sender:)` function.
	var doneSaving: ((DayModel) -> ())?
	var tripIndex: Int!
	var tripModel: TripModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
	}
	
	@IBAction func cancel(_ sender: UIButton) {
		dismiss(animated: true)
	}
	
	@IBAction func save(_ sender: UIButton) {
		if alreadyExists(datePicker.date) {
			let alertController = UIAlertController(title: "Day Already Exists", message: "Choose another date.", preferredStyle: .alert)
			let okAction = UIAlertAction(title: "OK", style: .cancel)
			alertController.addAction(okAction)
			present(alertController, animated: true)
			return
		}
		
		let dayModel = DayModel(title: datePicker.date, subtitle: subtitleTextField.text ?? "", data: nil)
		DayFunctions.createDay(dayModel, forTripAt: tripIndex)
		
		if let doneSaving = doneSaving {
			doneSaving(dayModel)
		}
		dismiss(animated: true)
	}
	
	func alreadyExists(_ date: Date) -> Bool {
		return tripModel.dayModels.contains { $0.title.mediumDate == date.mediumDate }
	}
	
	@IBAction func done(_ sender: UITextField) {
		sender.resignFirstResponder()
	}
	
}
