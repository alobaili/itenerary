//
//  ActivityFunctions.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 26/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import Foundation

class ActivityFunctions {
	
	static func createActivity(_ activityModel: ActivityModel, forTripAt tripIndex: Int, andDayAt dayIndex: Int) {
		Data.tripModels[tripIndex].dayModels[dayIndex].activityModels.append(activityModel)
	}
	
}
