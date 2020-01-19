//
//  TripFunctions.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 11/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import UIKit

class TripFunctions {
    
    static func createTrip(_ tripModel: TripModel) {
        Data.tripModels.append(tripModel)
    }
    
    static func readTrips(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.tripModels.isEmpty {
                Data.tripModels = MockData.createMockTripModelData()
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    static func updateTrip(at index: Int, title: String, image: UIImage? = nil) {
        Data.tripModels[index].title = title
        Data.tripModels[index].image = image
    }
    
    static func deleteTrip(at index: Int) {
        Data.tripModels.remove(at: index)
    }
    
}
