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
    
    let startOfDay : Date
    let endOfDay : Date
    
    let startOfWeek : Date
    let endOfWeek : Date
    
    let startOfMonth : Date
    let endOfMonth : Date
    
    let startOfYear : Date
    let endOfYear : Date
    
    init() {
        self.date = Date.now
        self.calendar = Calendar(identifier: .gregorian)
        self.calendar.timeZone = TimeZone(identifier: "GMT")!
        //self.calendar.firstWeekday = 2

        self.startOfDay = Date().startOfDay(using: self.calendar)
        self.endOfDay = Date().endOfDay(using: self.calendar)
        
        self.startOfWeek = Date().startOfWeek(using: self.calendar)
        self.endOfWeek = Date().endOfWeek(using: self.calendar)
        
        self.startOfMonth = Date().startOfMonth(using: self.calendar)
        self.endOfMonth = Date().endOfMonth(using: self.calendar)
        
        self.startOfYear = Date().startOfYear(using: self.calendar)
        self.endOfYear = Date().endOfYear(using: self.calendar)
        
        print("AICI")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "GMT")!
        
        print("Azi")
        print(dateFormatter.string(from: self.date))
        
        print("Inceput zi")
        print(dateFormatter.string(from: self.startOfDay))
        
        print("Sfarsit zi")
        print(dateFormatter.string(from: self.endOfDay))
        
        print("Inceput saptamana")
        print(dateFormatter.string(from: self.startOfWeek))
        
        print("Sfarsit saptamana")
        print(dateFormatter.string(from: self.endOfWeek))
        
        print("Inceput luna")
        print(dateFormatter.string(from: self.startOfMonth))
        
        print("Sfarsit luna")
        print(dateFormatter.string(from: self.endOfMonth))
        
        print("Inceput an")
        print(dateFormatter.string(from: self.startOfYear))
        
        print("Sfarsit an")
        print(dateFormatter.string(from: self.endOfYear))
    }
}

extension Date {
    func startOfDay(using calendar: Calendar = Calendar.current) -> Date {
        return calendar.startOfDay(for: self)
    }
    
    func endOfDay(using calendar: Calendar = Calendar.current) -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return calendar.date(byAdding: components, to: startOfDay(using: calendar))!
    }
    
    func startOfWeek(using calendar: Calendar = Calendar.current) -> Date {
        var components = DateComponents()
        components.day = 1 //Temporary fix for having Monday as the first day of the week

        let initialStartOfWeek = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
        return calendar.date(byAdding: components, to: initialStartOfWeek)!
        
        //TODO: Resolve this
        //calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
    
    func endOfWeek(using calendar: Calendar = Calendar.current) -> Date {
        var components = DateComponents()
        components.weekOfYear = 1
        components.second = -1
        return calendar.date(byAdding: components, to: startOfWeek(using: calendar))!
    }
    
    func startOfMonth(using calendar: Calendar = Calendar.current) -> Date {
        let components = calendar.dateComponents([.year, .month], from: startOfDay(using: calendar))
        return calendar.date(from: components)!
    }
    
    func endOfMonth(using calendar: Calendar = Calendar.current) -> Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return calendar.date(byAdding: components, to: startOfMonth(using: calendar))!
    }
    
    func startOfYear(using calendar: Calendar = Calendar.current) -> Date {
        let components = Calendar.current.dateComponents([.year], from: startOfDay(using: calendar))
        return calendar.date(from: components)!
    }
    
    func endOfYear(using calendar: Calendar = Calendar.current) -> Date {
        var components = DateComponents()
        components.year = 1
        components.second = -1
        return calendar.date(byAdding: components, to: startOfYear(using: calendar))!
    }
}
