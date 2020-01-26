//
//  AddActivityViewController.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 25/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var dayPickerView: UIPickerView!
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var subtitleTextField: UITextField!
	@IBOutlet var activityTypeButtons: [UIButton]!
	
	/// A callback that the presenting view controller should implement in its `prepare(for:sender:)` function.
	var doneSaving: ((ActivityModel, Int) -> ())?
	var tripIndex: Int!
	var tripModel: TripModel!

    override func viewDidLoad() {
        super.viewDidLoad()
		titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
		dayPickerView.dataSource = self
		dayPickerView.delegate = self
    }
	
	@IBAction func activityTypeSelected(_ sender: UIButton) {
		activityTypeButtons.forEach { $0.tintColor = Theme.accent }
		sender.tintColor = Theme.tintColor
	}
	
	@IBAction func save(_ sender: UIButton) {
		guard titleTextField.hasValue, let newTitle = titleTextField.text else { return }
		let activityType: ActivityType = getSelectedActivityType()
		let dayIndex = dayPickerView.selectedRow(inComponent: 0)
		let activityModel = ActivityModel(title: newTitle, subtitle: subtitleTextField.text ?? "", activityType: activityType)
		ActivityFunctions.createActivity(activityModel, forTripAt: tripIndex, andDayAt: dayIndex)
		if let doneSaving = doneSaving {
			doneSaving(activityModel, dayIndex)
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
