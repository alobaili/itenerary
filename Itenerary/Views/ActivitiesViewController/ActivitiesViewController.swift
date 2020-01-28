//
//  ActivitiesViewController.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 18/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var addButton: UIButton!
	
    var tripID: UUID!
    var tripModel: TripModel!
	var tripTitle = ""
    var sectionHeaderHeight: CGFloat = 0
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		title = tripTitle
		addButton.createFloatingActionButton()
        
        tableView.dataSource = self
        tableView.delegate = self
        
		updateTableViewWithTripData()
        
        sectionHeaderHeight = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier)?.bounds.height ?? 0
    }
	
	fileprivate func updateTableViewWithTripData() {
		TripFunctions.readTrip(by: tripID) { [weak self] tripModel in
			guard let self = self else { return }
			self.tripModel = tripModel
			
			guard let tripModel = tripModel else { return }
			self.backgroundImageView.image = tripModel.image
			self.tableView.reloadData()
		}
	}
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
	
	@IBAction func addAction(_ sender: UIButton) {
		let alertController = UIAlertController(title: "Which would you like to add?", message: nil, preferredStyle: .actionSheet)
		let dayAction = UIAlertAction(title: "Day", style: .default, handler: handleAddDay)
		let activityAction = UIAlertAction(title: "Activity", style: .default, handler: handleAddActivity)
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		activityAction.isEnabled = tripModel.dayModels.count > 0
		alertController.addAction(dayAction)
		alertController.addAction(activityAction)
		alertController.addAction(cancelAction)
		alertController.popoverPresentationController?.sourceView = sender
		alertController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: -4, width: sender.bounds.width, height: sender.bounds.height)
		present(alertController, animated: true)
	}
	
	func handleAddDay(action: UIAlertAction) {
		let vc = AddDayViewController.getInstance() as! AddDayViewController
		vc.tripModel = tripModel
		vc.tripIndex = getTripIndex()
		vc.doneSaving = { [weak self] dayModel in
			self?.tripModel.dayModels.append(dayModel)
			let index = [self?.tripModel.dayModels.firstIndex(of: dayModel) ?? 0]
			self?.tableView.insertSections(IndexSet(index), with: .automatic)
		}
		present(vc, animated: true)
	}
	
	fileprivate func getTripIndex() -> Int! {
		return Data.tripModels.firstIndex { $0.id == tripID }
	}
	
	func handleAddActivity(action: UIAlertAction) {
		let vc = AddActivityViewController.getInstance() as! AddActivityViewController
		vc.tripModel = tripModel
		vc.tripIndex = getTripIndex()
		vc.doneSaving = { [weak self] (activityModel, dayIndex) in
			self?.tripModel.dayModels[dayIndex].activityModels.append(activityModel)
			let row = (self?.tripModel.dayModels[dayIndex].activityModels.count)! - 1
			let indexPath = IndexPath(row: row, section: dayIndex)
			self?.tableView.insertRows(at: [indexPath], with: .automatic)
		}
		present(vc, animated: true)
	}
    
}

extension ActivitiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tripModel?.dayModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripModel.dayModels[section].activityModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = tripModel.dayModels[indexPath.section].activityModels[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifier) as! ActivityTableViewCell
		cell.setup(model: model)
        return cell
    }
    
    // MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dayModel = tripModel.dayModels[section]
		let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        cell.setup(model: dayModel)
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let activityModel = tripModel.dayModels[indexPath.section].activityModels[indexPath.row]
		
		let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
			
			let alertController = UIAlertController(title: "Delete Activity", message: "Are you sure you want to delete the activity: \(activityModel.title)", preferredStyle: .alert)
			
			let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
				actionPerformed(false)
			}
			let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
				ActivityFunctions.deleteActivity(activityModel, forTripAt: self.getTripIndex(), andDayAt: indexPath.section)
				self.tripModel.dayModels[indexPath.section].activityModels.remove(at: indexPath.row)
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
		let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> Void) in
			let vc = AddActivityViewController.getInstance() as! AddActivityViewController
			
			// Which trip are we on?
			vc.tripModel = self.tripModel
			
			// Which trip are we working with?
			vc.tripIndex = self.getTripIndex()
			
			// Which day are we on?
			vc.dayIndexToEdit = indexPath.section
			
			// Which activity are we editing?
			vc.activityModelToEdit = self.tripModel.dayModels[indexPath.section].activityModels[indexPath.row]
			
			// What do we want to happen after the activity is saved?
			vc.doneUpdating = { [weak self] oldDayIndex, newDayIndex, activityModel in
				let oldActivityIndex = (self?.tripModel.dayModels[oldDayIndex].activityModels.firstIndex(of: activityModel))!
				if oldDayIndex == newDayIndex {
					// 1. Update the local table data
					self?.tripModel.dayModels[newDayIndex].activityModels[oldActivityIndex] = activityModel
					// 2. Refresh just that row
					let indexPath = IndexPath(row: oldActivityIndex, section: newDayIndex)
					tableView.reloadRows(at: [indexPath], with: .automatic)
				} else {
					// Activity moved to a different day
					// 1. Remove activity from local table data
					self?.tripModel.dayModels[oldDayIndex].activityModels.remove(at: oldActivityIndex)
					// 2. Insert activity into new location
					let lastIndex = (self?.tripModel.dayModels[newDayIndex].activityModels.count)!
					self?.tripModel.dayModels[newDayIndex].activityModels.insert(activityModel, at: lastIndex)
					// 3. Update table rows
					tableView.performBatchUpdates({
						tableView.deleteRows(at: [indexPath], with: .automatic)
						let insertIndexPath = IndexPath(row: lastIndex, section: newDayIndex)
						tableView.insertRows(at: [insertIndexPath], with: .automatic)
					})
				}
			}
			self.present(vc, animated: true)
			actionPerformed(true)
		}
		edit.image = UIImage(systemName: "pencil")
		edit.backgroundColor = Theme.editColor
		return UISwipeActionsConfiguration(actions: [edit])
	}
	
}
