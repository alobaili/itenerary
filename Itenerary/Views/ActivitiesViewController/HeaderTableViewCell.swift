//
//  HeaderTableViewCell.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 19/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont(name: Theme.bodyFontNameBold, size: 17)
        subtitleLabel.font = UIFont(name: Theme.bodyFontName, size: 15)
    }
    
    func setup(model: DayModel) {
		titleLabel.text = model.title.mediumDate
        subtitleLabel.text = model.subtitle
    }

}
