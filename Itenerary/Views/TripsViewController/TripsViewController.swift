//
//  TripsViewController.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 11/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

class TripsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var tripIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TripFunctions.readTrips { [weak self] in
            self?.tableView.reloadData()
        }
        
        view.backgroundColor = Theme.backgroundColor
        addButton.createFloatingActionButton()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTripSegue" {
            let popupViewController = segue.destination as! AddTripViewController
            popupViewController.tripIndexToEdit = tripIndexToEdit
            popupViewController.doneSaving = { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
}

extension TripsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.tripModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TripsTableViewCell
        
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
            self.tripIndexToEdit = nil
            actionPerformed(true)
        }
        
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = Theme.editColor
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
}
