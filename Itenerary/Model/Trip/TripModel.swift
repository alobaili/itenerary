//
//  TripModel.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 11/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

struct TripModel {
    
    let id: UUID
    var title: String
    var image: UIImage?
	var dayModels = [DayModel]() {
		didSet {
			dayModels.sort { $0.title < $1.title }
		}
	}
    
	init(title: String, image: UIImage? = nil, dayModels: [DayModel]? = nil) {
        id = UUID()
        self.title = title
        self.image = image
		if let dayModels = dayModels {
			self.dayModels = dayModels
		}
    }
    
}
