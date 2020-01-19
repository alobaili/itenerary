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
    
    var tripID: UUID!
    var tripModel: TripModel?
    var sectionHeaderHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TripFunctions.readTrip(by: tripID) { [weak self] tripModel in
            guard let self = self else { return }
            self.tripModel = tripModel
            
            guard let tripModel = tripModel else { return }
            self.title = tripModel.title
            self.backgroundImageView.image = tripModel.image
            self.tableView.reloadData()
        }
        
        sectionHeaderHeight = tableView.dequeueReusableCell(withIdentifier: "headerCell")?.bounds.height ?? 0
    }
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

extension ActivitiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tripModel?.dayModels.count ?? 0
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let title = tripModel?.dayModels[section].title ?? ""
//        let subtitle = tripModel?.dayModels[section].subtitle ?? ""
//        return "\(title) - \(subtitle)"
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripModel?.dayModels[section].activityModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = tripModel?.dayModels[indexPath.section].activityModels[indexPath.row].title
        
        return cell!
    }
    
    // MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dayModel = tripModel?.dayModels[section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderTableViewCell
        cell.setup(model: dayModel!)
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
}
