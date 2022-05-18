//
//  Date + Extension.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 18.05.22.
//

import Foundation
import SwiftUI

extension Date {
    
    func localDate() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))//seconds from Grinvich
        let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) ?? Date()// change into our TimeZone
        return localDate
    }
    
    func getWeekdayNumber() -> Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        return weekday
    }
    
    func startEndDate() -> (Date, Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")//if u don't state timeZone, it will be not 00:00 but 21:03
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        
        let dateStart = formatter.date(from: "\(year)/\(month)/\(day)") ?? Date()//we don't state 00:00, it's so by default
        let dateEnd:Date = {
            let components = DateComponents(day: 1, second: -1)//23.59
            return calendar.date(byAdding: components, to: dateStart) ?? Date()
        }()
        
        return (dateStart, dateEnd)
    }
    
    func offsetDays(days: Int) -> Date {
        let offsetDate = Calendar.current.date(byAdding: .day, value: -days, to: self) ?? Date()
        return offsetDate
    }
    
    func getWeekArray() -> [[String]] {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.dateFormat = "EEEEEE" //nsdateformatter.com 2 letters only
        
        var weekArray: [[String]] = [[], []]
        let calendar = Calendar.current
        
        for index in -6...0 {
            let date = calendar.date(byAdding: .weekday, value: index, to: self) ?? Date()
            let day = calendar.component(.day, from: date)
            weekArray[1].append("\(day)")
            let weekday = formatter.string(from: date)
            weekArray[0].append(weekday)
        }
        return weekArray
    }
}
