//
//  MockData.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 19/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import Foundation

class MockData {
    
    static func createMockTripModelData() -> [TripModel] {
        var mockTrips = [TripModel]()
        mockTrips.append(TripModel(title: "Trip to Bali!"))
        mockTrips.append(TripModel(title: "Mexico"))
        mockTrips.append(TripModel(title: "Russian Trip"))
        return mockTrips
    }
    
    static func createMockDayModelData() -> [DayModel] {
        var dayModels = [DayModel]()
        dayModels.append(DayModel(title: "April 18", subtitle: "Departure", data: createMockActivityModelData(sectionTitle: "April 18")))
        dayModels.append(DayModel(title: "April 19", subtitle: "Exploring", data: createMockActivityModelData(sectionTitle: "April 19")))
        dayModels.append(DayModel(title: "April 20", subtitle: "Scuba Diving!", data: createMockActivityModelData(sectionTitle: "April 20")))
        dayModels.append(DayModel(title: "April 21", subtitle: "Volunteering", data: createMockActivityModelData(sectionTitle: "April 21")))
        dayModels.append(DayModel(title: "April 22", subtitle: "Time to go back home", data: createMockActivityModelData(sectionTitle: "April 22")))
        return dayModels
    }
    
    static func createMockActivityModelData(sectionTitle: String) -> [ActivityModel] {
        return [ActivityModel]()
    }
}
