//
//  DayFunctions.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 24/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import Foundation

class DayFunctions {
	
	static func createDay(_ dayModel: DayModel, forTripAt index: Int) {
		Data.tripModels[index].dayModels.append(dayModel)
	}
	
}
