//
//  AttendanceViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 24/12/22.
//

import Foundation
import CoreLocation

class AttendanceViewModel: ObservableObject {
    @Published var date: Date = Date()
    @Published var reversedGeoCodeLoc: String = "-"
    @Published var longitude: String = ""
    @Published var latitude: String = ""
    @Published var tempat: Bool = false
    var locA: CLLocation?
    
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
    
    func getReversedGeoCodeLoc() {
        LocationManager.shared.getCurrentReverseGeoCodedLocation { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
            
            if let error {
                print(error.localizedDescription)
                return
            }
            
            guard let location else {return}
            self.locA = location
            print("\(location.coordinate.latitude)")
            self.latitude = "\(location.coordinate.latitude)"
            self.longitude = "\(location.coordinate.longitude)"
            guard let placemark = placemark else { return }
            self.reversedGeoCodeLoc = "\(String(describing: placemark.description))"
            
            self.tempat = self.checkDistance()
        }
    }
    
    func checkDistance() -> Bool {
        guard let locA = self.locA else { return false}
        let locB = CLLocation(latitude: 7.75561, longitude: 110.38478)
        return locA.distance(from: locB) > 25
    }
    
}
