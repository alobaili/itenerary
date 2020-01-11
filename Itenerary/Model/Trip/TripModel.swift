//
//  TripModel.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 11/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import Foundation

class TripModel {
    
    let id: UUID
    var title: String
    
    init(title: String) {
        id = UUID()
        self.title = title
    }
    
}
