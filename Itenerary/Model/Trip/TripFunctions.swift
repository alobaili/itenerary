//
//  TripFunctions.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 11/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import Foundation

class TripFunctions {
    
    static func createTrip(_ tripModel: TripModel) {
        
    }
    
    static func readTrips() {
        if Data.tripModels.isEmpty {
            Data.tripModels.append(TripModel(title: "Trip to Bali!"))
            Data.tripModels.append(TripModel(title: "Mexico"))
            Data.tripModels.append(TripModel(title: "Russian Trip"))
        }
    }
    
    static func updateTrip(_ tripModel: TripModel) {
        
    }
    
    static func deleteTrip(_ tripModel: TripModel) {
        
    }
    
}
