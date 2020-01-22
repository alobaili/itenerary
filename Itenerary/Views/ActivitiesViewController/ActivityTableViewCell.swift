//
//  ActivityTableViewCell.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 22/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

	@IBOutlet weak var cardView: UIView!
	@IBOutlet weak var activityImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		cardView.addShadowAndRoundedCorners()
		titleLabel.font = UIFont(name: Theme.bodyFontNameDemiBold, size: 17)
		subtitleLabel.font = UIFont(name: Theme.bodyFontName, size: 17)
    }

	func setup(model: ActivityModel) {
		activityImageView.image = getActivityImage(for: model.activityType)
		titleLabel.text = model.title
		subtitleLabel.text = model.subtitle
	}
	
	func getActivityImage(for activityType: ActivityType) -> UIImage {
		switch activityType {
			case .auto: return UIImage(systemName: "car.fill")!
			case .excursion: return UIImage(systemName: "map.fill")!
			case .flight: return UIImage(systemName: "airplane")!
			case .food: return UIImage(systemName: "mappin")!
			case .hotel: return UIImage(systemName: "bed.double.fill")!
		}
	}
}
