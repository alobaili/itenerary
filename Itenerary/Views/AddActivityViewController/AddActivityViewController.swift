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
	
	var tripIndex: Int!
	var tripModel: TripModel!

    override func viewDidLoad() {
        super.viewDidLoad()
		titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
    }
	
	@IBAction func save(_ sender: UIButton) {
		dismiss(animated: true)
	}
	
	@IBAction func cancel(_ sender: UIButton) {
		dismiss(animated: true)
	}

}
