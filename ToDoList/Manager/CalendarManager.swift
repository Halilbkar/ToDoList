//
//  CalendarSetup.swift
//  ToDoList
//
//  Created by Halil Bakar on 19.02.2023.
//

import Foundation
import FSCalendar

var dateString = ""

let timeType = "HH:mm"
let dateType = "E, d MMM yyyy"

struct CalendarManager {
    
    static func calendarSetup(_ calendarView: FSCalendar) {
        
        calendarView.scope = .week
        calendarView.calendarHeaderView.isHidden = true
        calendarView.scrollDirection = .vertical
        calendarView.firstWeekday = firstWeekDay()
    
    }
    
    static func firstWeekDay() -> UInt {
        
        let weekday = Calendar.current.component(.weekday, from: Date())
        
        return UInt(weekday)
    }
    
    static func formatter(_ formatType: String, _ date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = formatType
        
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}
