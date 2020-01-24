//
//  AddTripViewController.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 12/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit
import Photos

class AddTripViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tripTextField: UITextField!
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
        imageView.layer.cornerRadius = 10
        
        if let index = tripIndexToEdit {
            let trip = Data.tripModels[index]
            tripTextField.text = trip.title
            imageView.image = trip.image
            titleLabel.text = "Edit Trip"
        } else {
            tripTextField.text = nil
            imageView.image = nil
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
		guard tripTextField.hasValue, let newTripName = tripTextField.text else { return }
        
        if let index = tripIndexToEdit {
            TripFunctions.updateTrip(at: index, title: newTripName, image: imageView.image)
        } else {
            TripFunctions.createTrip(TripModel(title: newTripName, image: imageView.image))
        }
        
        if let doneSaving = doneSaving {
            doneSaving()
        }
        dismiss(animated: true)
    }
    
    fileprivate func presentImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true)
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
                case .authorized:
                    DispatchQueue.main.async {
                        self.presentImagePicker()
                }
                case .notDetermined:
                    if status == .authorized {
                        self.presentImagePicker()
                }
                case .restricted:
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Photo Library Restricted", message: "Photo Library access is restricted and it cannot be used.", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true)
                }
                case .denied:
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Photo Library Access Denied", message: "Photo Library access was previously denied. Please update your Settings if you want to change this.", preferredStyle: .alert)
                        let goToSettingsAction = UIAlertAction(title: "Go to Settings", style: .default) { action in
                            let url = URL(string: UIApplication.openSettingsURLString)!
                            UIApplication.shared.open(url, options: [:])
                        }
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                        alertController.addAction(goToSettingsAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true)
                }
                @unknown default:
                    break
            }
        }
    }
    
}

extension AddTripViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.imageView.image = image
        } else if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
