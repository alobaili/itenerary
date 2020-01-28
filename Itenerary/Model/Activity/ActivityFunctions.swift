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
	
	static func deleteActivity(_ activityModel: ActivityModel, forTripAt tripIndex: Int, andDayAt dayIndex: Int) {
		let dayModel = Data.tripModels[tripIndex].dayModels[dayIndex]
		
		if let index = dayModel.activityModels.firstIndex(of: activityModel) {
			Data.tripModels[tripIndex].dayModels[dayIndex].activityModels.remove(at: index)
		}
	}
	
	static func updateActivity(_ activityModel: ActivityModel, forTripAt tripIndex: Int, oldDayIndex: Int, newDayIndex: Int) {
		if oldDayIndex != newDayIndex {
			// Move activity to new day
			let lastIndex = Data.tripModels[tripIndex].dayModels[newDayIndex].activityModels.count
			reorderActivity(activityModel, forTripAt: tripIndex, oldDayIndex: oldDayIndex, newDayIndex: newDayIndex, newActivityIndex: lastIndex)
		} else {
			// Update activity in the same day
			let dayModel = Data.tripModels[tripIndex].dayModels[oldDayIndex]
			let activityIndex = (dayModel.activityModels.firstIndex(of: activityModel))!
			Data.tripModels[tripIndex].dayModels[newDayIndex].activityModels[activityIndex] = activityModel
		}
	}
	
	static func reorderActivity(_ activityModel: ActivityModel, forTripAt tripIndex: Int, oldDayIndex: Int, newDayIndex: Int, newActivityIndex: Int) {
		// 1. Remove activity from old location
		let oldDayModel = Data.tripModels[tripIndex].dayModels[oldDayIndex]
		let oldActivityIndex = (oldDayModel.activityModels.firstIndex(of: activityModel))!
		Data.tripModels[tripIndex].dayModels[oldDayIndex].activityModels.remove(at: oldActivityIndex)
		// 2. Insert activity into the new location
		Data.tripModels[tripIndex].dayModels[newDayIndex].activityModels.insert(activityModel, at: newActivityIndex)
	}
	
}
