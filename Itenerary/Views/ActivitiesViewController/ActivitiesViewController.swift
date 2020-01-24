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
    var tripModel: TripModel?
	var tripTitle = ""
    var sectionHeaderHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = tripTitle
		addButton.createFloatingActionButton()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TripFunctions.readTrip(by: tripID) { [weak self] tripModel in
            guard let self = self else { return }
            self.tripModel = tripModel
            
            guard let tripModel = tripModel else { return }
            self.backgroundImageView.image = tripModel.image
            self.tableView.reloadData()
        }
        
        sectionHeaderHeight = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier)?.bounds.height ?? 0
    }
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
	
	@IBAction func addAction(_ sender: UIButton) {
		let alertController = UIAlertController(title: "Which would you like to add?", message: nil, preferredStyle: .actionSheet)
		let dayAction = UIAlertAction(title: "Day", style: .default, handler: handleAddDay)
		let activityAction = UIAlertAction(title: "Activity", style: .default) { action in
			print("Add new activity")
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		alertController.addAction(dayAction)
		alertController.addAction(activityAction)
		alertController.addAction(cancelAction)
		alertController.popoverPresentationController?.sourceView = sender
		alertController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: -4, width: sender.bounds.width, height: sender.bounds.height)
		present(alertController, animated: true)
	}
	
	func handleAddDay(action: UIAlertAction) {
		let vc = AddDayViewController.getInstance()
		present(vc, animated: true)
	}
	
    
}

extension ActivitiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tripModel?.dayModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripModel?.dayModels[section].activityModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = tripModel?.dayModels[indexPath.section].activityModels[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifier) as! ActivityTableViewCell
		cell.setup(model: model!)
        return cell
    }
    
    // MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dayModel = tripModel?.dayModels[section]
		let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        cell.setup(model: dayModel!)
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
}
