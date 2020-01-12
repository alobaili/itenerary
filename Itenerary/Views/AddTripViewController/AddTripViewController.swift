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
        tripTextField.rightViewMode = .never
        
        guard let newTripName = tripTextField.text, newTripName != "" else {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
            imageView.layer.shadowOpacity = 1
            imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
            imageView.layer.shadowRadius = 2
            imageView.tintColor = .yellow
            imageView.contentMode = .scaleAspectFit
            tripTextField.rightView = UIView()
            tripTextField.rightView?.sizeToFit()
            tripTextField.rightView?.addSubview(imageView)
            imageView.center = .init(x: tripTextField.rightView!.center.x - 16, y: tripTextField.rightView!.center.y)
            tripTextField.rightViewMode = .always
            return
        }
        
        TripFunctions.createTrip(TripModel(title: newTripName))
        
        if let doneSaving = doneSaving {
            doneSaving()
        }
        dismiss(animated: true)
    }
    
}
