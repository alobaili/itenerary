//
//  AddTripViewController.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 12/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

class AddTripViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tripTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    /// A callback that the presenting view controller should implement in its `prepare(for:sender:)` function.
    var doneSaving: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        TripFunctions.createTrip(TripModel(title: tripTextField.text!))
        
        if let doneSaving = doneSaving {
            doneSaving()
        }
        dismiss(animated: true)
    }
    
}
