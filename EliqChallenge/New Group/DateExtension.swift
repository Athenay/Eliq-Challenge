//
//  DateExtension.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

extension Date {
    static let hoursInDay = 24
    static let minutesInHour = 60
    static let secondsInMinute = 60
    
    func subtractDays(n: Int) -> Date {
        let inSeconds = n * Date.hoursInDay * Date.minutesInHour * Date.secondsInMinute
        return self.addingTimeInterval(-Double(inSeconds))
    }
    
    func addDays(n: Int) -> Date {
        let inSeconds = n * Date.hoursInDay * Date.minutesInHour * Date.secondsInMinute
        return self.addingTimeInterval(Double(inSeconds))
    }
}
