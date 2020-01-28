//
//  AddActivityViewController.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 25/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

class AddActivityViewController: UITableViewController {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var dayPickerView: UIPickerView!
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var subtitleTextField: UITextField!
	@IBOutlet var activityTypeButtons: [UIButton]!
	
	/// A callback that the presenting view controller should implement in its `prepare(for:sender:)` function.
	var doneSaving: ((ActivityModel, Int) -> ())?
	var tripIndex: Int!
	var tripModel: TripModel!
	
	// For editing activity
	var dayIndexToEdit: Int?
	var activityModelToEdit: ActivityModel!
	var doneUpdating: ((Int, Int, ActivityModel) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
		titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
		dayPickerView.dataSource = self
		dayPickerView.delegate = self
		
		if let dayIndex = dayIndexToEdit, let activityModel = activityModelToEdit {
			// Update Activity: populate the popup
			titleLabel.text = "Edit Activity"
			
			// Select the day in the picker view
			dayPickerView.selectRow(dayIndex, inComponent: 0, animated: true)
			
			// Populate the activity data
			// Set the selected activity type button
			activityTypeSelected(activityTypeButtons[activityModel.activityType.rawValue])
			titleTextField.text = activityModel.title
			subtitleTextField.text = activityModel.subtitle
		} else {
			// New Activity: Set default values
			activityTypeSelected(activityTypeButtons[ActivityType.excursion.rawValue])
		}
    }
	
	@IBAction func activityTypeSelected(_ sender: UIButton) {
		activityTypeButtons.forEach { $0.tintColor = Theme.accent }
		sender.tintColor = Theme.tintColor
	}
	
	@IBAction func save(_ sender: UIButton) {
		guard titleTextField.hasValue, let newTitle = titleTextField.text else { return }
		let activityType: ActivityType = getSelectedActivityType()
		let newDayIndex = dayPickerView.selectedRow(inComponent: 0)
		
		if activityModelToEdit != nil {
			// Update activity
			activityModelToEdit.activityType = activityType
			activityModelToEdit.title = newTitle
			activityModelToEdit.subtitle = subtitleTextField.text ?? ""
			
			ActivityFunctions.updateActivity(activityModelToEdit, forTripAt: tripIndex, oldDayIndex: dayIndexToEdit!, newDayIndex: newDayIndex)
			
			if let doneUpdating = doneUpdating, let oldDayIndex = dayIndexToEdit {
				doneUpdating(oldDayIndex, newDayIndex, activityModelToEdit)
			}
		} else {
			// New Activity
			let activityModel = ActivityModel(title: newTitle, subtitle: subtitleTextField.text ?? "", activityType: activityType)
			ActivityFunctions.createActivity(activityModel, forTripAt: tripIndex, andDayAt: newDayIndex)
			if let doneSaving = doneSaving {
				doneSaving(activityModel, newDayIndex)
			}
		}
		
		dismiss(animated: true)
	}
	
	func getSelectedActivityType() -> ActivityType {
		for (index, button) in activityTypeButtons.enumerated() {
			if button.tintColor == Theme.tintColor {
				return ActivityType(rawValue: index) ?? .excursion
			}
		}
		return .excursion
	}
	
	@IBAction func cancel(_ sender: UIButton) {
		dismiss(animated: true)
	}
	
	@IBAction func done(_ sender: UITextField) {
		sender.resignFirstResponder()
	}

}

extension AddActivityViewController: UIPickerViewDataSource {
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return tripModel.dayModels.count
	}
	
}

extension AddActivityViewController: UIPickerViewDelegate {
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return tripModel.dayModels[row].title.mediumDate
	}
	
}
