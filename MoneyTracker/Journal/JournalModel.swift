//
//  JournalModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 19.12.2022.
//

import Foundation


class JournalModel {
    
    let date: Date
    var calendar: Calendar
    let currentDay : Date
    let dateComponents : DateComponents
    let startOfDay : Date
    var startOfDayComponents: DateComponents
    let endOfDay : Date
    var endOfDayComponents : DateComponents
    let startOfWeek : Date
    let endOfWeek : Date
    let startOfMonth : Date
    let endOfMonth : Date
    let startOfYear : Date
    let endOfYear : Date
    
    init() {
        self.date = Date.now
        self.calendar = Calendar.current
        self.dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        self.currentDay = calendar.date(from: dateComponents)!
        self.startOfDayComponents = DateComponents()
        startOfDayComponents.hour = 02
        startOfDayComponents.minute = 00
        startOfDayComponents.second = 00
        self.startOfDay = calendar.date(byAdding: startOfDayComponents, to: currentDay)!
        self.endOfDayComponents = DateComponents()
        endOfDayComponents.hour = 23
        endOfDayComponents.minute = 59
        endOfDayComponents.second = 59
        self.endOfDay = calendar.date(byAdding: endOfDayComponents, to: startOfDay)!
        self.startOfWeek = calendar.startOfWeek(Date())
        self.endOfWeek = calendar.endOfWeek(Date())
        self.startOfMonth = calendar.startOfMonth(Date())
        self.endOfMonth = calendar.endOfMonth(Date())
        self.startOfYear = calendar.startOfYear(Date())
        self.endOfYear = calendar.endOfYear(Date())
    }
}

extension Calendar {
    
    func dayOfWeek(_ date: Date) -> Int {
        var dayOfWeek = self.component(.weekday, from: date) - 1 - self.firstWeekday
        
        if dayOfWeek <= 0 {
            dayOfWeek += 7
        }
        return dayOfWeek
    }
    
    func startOfWeek(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(day: -self.dayOfWeek(date)), to: date)!
    }
    
    func endOfWeek(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(day: 7), to: self.startOfWeek(date))!
    }
    
    func startOfMonth(_ date: Date) -> Date {
        return self.date(from: self.dateComponents([.year, .month], from: date))!
    }
    
    func endOfMonth(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(date))!
    }
    
    func startOfYear(_ date: Date) -> Date {
        return self.date(from: self.dateComponents([.year], from: date))!
    }
    
    func endOfYear(_ date: Date) -> Date {
        return self.date(from: DateComponents(year: self.component(.year, from: date), month: 12, day: 31))!
    }
}
