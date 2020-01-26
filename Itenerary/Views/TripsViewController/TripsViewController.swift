//
//  TripsViewController.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 11/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

class TripsViewController: UIViewController {

	@IBOutlet weak var logoImageView: UIImageView!
	@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var helpView: UIVisualEffectView!
    
    var tripIndexToEdit: Int?
    var seenHelpView = "seenHelpView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TripFunctions.readTrips { [unowned self] in
            self.tableView.reloadData()
            
            if !Data.tripModels.isEmpty {
                if !UserDefaults.standard.bool(forKey: self.seenHelpView) {
                    self.view.addSubview(self.helpView)
                    self.helpView.frame = self.view.bounds
                }
            }
        }
        
        view.backgroundColor = Theme.backgroundColor
        addButton.createFloatingActionButton()
		
		// x° × π/180 = y rad
		let radians: CGFloat = 200 * CGFloat.pi / 180
		
		UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseIn], animations: {
			self.logoImageView.alpha = 0
			self.logoImageView.transform = CGAffineTransform(rotationAngle: radians)
				.scaledBy(x: 3, y: 3)
		})
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTripSegue" {
            let popupViewController = segue.destination as! AddTripViewController
            popupViewController.tripIndexToEdit = tripIndexToEdit
            popupViewController.doneSaving = { [weak self] in
                self?.tableView.reloadData()
            }
            tripIndexToEdit = nil
        }
    }
    
    
    @IBAction func closeHelpView(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.helpView.alpha = 0
        }) { success in
            self.helpView.removeFromSuperview()
            UserDefaults.standard.set(true, forKey: self.seenHelpView)
        }
    }
    
}

extension TripsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.tripModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TripsTableViewCell.identifier) as! TripsTableViewCell
        
        cell.setup(tripModel: Data.tripModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            
            let alertController = UIAlertController(title: "Delete Trip", message: "Are you sure you want to delete the trip: \(Data.tripModels[indexPath.row].title)", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                actionPerformed(false)
            }
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
                TripFunctions.deleteTrip(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                actionPerformed(true)
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            self.present(alertController, animated: true)
        }
        
        deleteAction.image = UIImage(systemName: "xmark")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            self.tripIndexToEdit = indexPath.row
            self.performSegue(withIdentifier: "toAddTripSegue", sender: nil)
            actionPerformed(true)
        }
        
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = Theme.editColor
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trip = Data.tripModels[indexPath.row]
		let vc = ActivitiesViewController.getInstance() as! ActivitiesViewController
        vc.tripID = trip.id
		vc.tripTitle = trip.title
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
