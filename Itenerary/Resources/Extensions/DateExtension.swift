//
//  DateExtension.swift
//  Itenerary
//
//  Created by Abdulaziz AlObaili on 24/01/2020.
//  Copyright © 2020 Abdulaziz AlObaili. All rights reserved.
//

import Foundation

extension Date {
	
	func add(days: Int) -> Date {
		return Calendar.current.date(byAdding: .day, value: days, to: Date())!
	}
	
}
