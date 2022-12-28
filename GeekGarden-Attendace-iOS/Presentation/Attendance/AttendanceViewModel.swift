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
    @Published var numberOfAbsencesToday: Int = 0
    @Published var checkInTime: String = "-"
    @Published var checkOutTime: String = "-"
    
    private var locA: CLLocation?
    private var prefs = UserDefaults()
    private var attendanceServices: AttendanceServicesProtocol
    
    init(attendanceServices: AttendanceServicesProtocol = AttendanceServices()) {
        self.attendanceServices = attendanceServices
    }
    
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
    
    func checkAttendance() async {
        do {
            let data = try await attendanceServices.checkAttendance(endpoint: .checkAttendance)
            saveCheckAttendanceToLocale(with: data)
        } catch {
            print("Check Attendance ERR")
        }
    }
    
    func checkHowManyAbsentToday() {
        let data = prefs.getDataFromLocal(CheckAttendanceResponseModel.self, with: .checkAttendance)
        self.numberOfAbsencesToday = data?.data?.jumlahAbsenHariIni ?? 0
    }
    
    func getCheckInTime() {
        let data = prefs.getDataFromLocal(CheckAttendanceResponseModel.self, with: .checkAttendance)
        guard let time = data?.data?.jamHadir?.tanggal else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: time) else { return }
        self.checkInTime = timeString(date: date)
    }
    
    func getCheckOutTime() {
        let data = prefs.getDataFromLocal(CheckAttendanceResponseModel.self, with: .checkAttendance)
        guard let time = data?.data?.jamPulang?.tanggal else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: time) else { return }
        self.checkOutTime = timeString(date: date)
    }
    
    private func saveCheckAttendanceToLocale(with data: CheckAttendanceResponseModel) {
        prefs.setDataToLocal(data.self, with: .checkAttendance)
    }
    
}
