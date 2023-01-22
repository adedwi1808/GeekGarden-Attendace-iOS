//
//  DateFormatter.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 22/01/23.
//

import Foundation

extension DateFormatter {
    static let remoteFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    
    static let stringMonthOnly: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter
    }()
    
    static let stringDayOnly: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter
    }()
    
    static let stringTimeOnly: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
    static func stringMonth(using date: String) -> String {
        let date = DateFormatter.remoteFormat.date(from: date)!
        return DateFormatter.stringMonthOnly.string(from: date)
    }
    
    static func stringDay(using date: String) -> String {
        let date = DateFormatter.remoteFormat.date(from: date)!
        return DateFormatter.stringDayOnly.string(from: date)
    }
    
    static func stringTime(using date: String) -> String {
        let date = DateFormatter.remoteFormat.date(from: date)!
        return DateFormatter.stringTimeOnly.string(from: date)
    }
}
