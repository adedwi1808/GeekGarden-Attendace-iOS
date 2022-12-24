//
//  AttendanceViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 24/12/22.
//

import Foundation

class AttendanceViewModel: ObservableObject {
    @Published var date: Date = Date()
    
    private var timeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh.mm"
        return formatter
    }
    
    private var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        return formatter
    }
    
    var updateTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in 
            self.date = Date()
        })
    }
    
    func timeString(date: Date) -> String {
        timeFormat.string(from: date)
    }
    
    func dateString(date: Date) -> String {
        dateFormat.string(from: date)
    }
    
}
