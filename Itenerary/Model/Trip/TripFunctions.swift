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
        Data.tripModels.append(tripModel)
    }
    
    static func readTrips(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.tripModels.isEmpty {
                Data.tripModels.append(TripModel(title: "Trip to Bali!"))
                Data.tripModels.append(TripModel(title: "Mexico"))
                Data.tripModels.append(TripModel(title: "Russian Trip"))
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    static func updateTrip(_ tripModel: TripModel) {
        
    }
    
    static func deleteTrip(_ tripModel: TripModel) {
        
    }
    
}
