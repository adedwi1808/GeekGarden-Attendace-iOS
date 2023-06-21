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
    @Published var attendanceInterval: String = "-"
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = "Anda Sudah Memenuhi Absent, Terima Kasih"
    
    private var checkInDate: Date?
    private var checkOutDate: Date?
    
    private var locA: CLLocation?
    private var prefs = UserDefaults()
    private var attendanceServices: AttendanceServicesProtocol
    
    init(attendanceServices: AttendanceServicesProtocol = AttendanceServices()) {
        self.attendanceServices = attendanceServices
    }
    
    var updateTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            self.date = Date()
        })
    }
    
    func timeString(date: Date) -> String {
        DateFormatter.stringTimeOnly.string(from: date)
    }
    
    func dateString(date: Date) -> String {
        DateFormatter.stringDayDateOnly.string(from: date)
    }
    
    func getReversedGeoCodeLoc() {
        LocationManager.shared.getCurrentReverseGeoCodedLocation { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
            
            if let error {
                print(error.localizedDescription)
                return
            }
            
            guard let location else {return}
            self.locA = location
            //            print("\(location.coordinate.latitude)")
            self.latitude = "\(location.coordinate.latitude)"
            self.longitude = "\(location.coordinate.longitude)"
            guard let placemark = placemark else { return }
            self.reversedGeoCodeLoc = "\(String(describing: placemark.description))"
            
            self.tempat = self.checkDistance()
        }
    }
    
    func checkDistance() -> Bool {
        guard let locA = self.locA else { return false}
        //MARK: Coordinat
        let locB = CLLocation(latitude: -7.75561, longitude: 110.38478)
        return locA.distance(from: locB) > 20
    }
    
    @MainActor
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
        if numberOfAbsencesToday == 0 {
            self.checkInTime = "-"
            self.checkOutTime = "-"
            self.attendanceInterval = "-"
        }
    }
    
    func getCheckInTime() {
        let data = prefs.getDataFromLocal(CheckAttendanceResponseModel.self, with: .checkAttendance)
        guard let time = data?.data?.jamHadir?.tanggal else { return }
        let date = DateFormatter.dateTimeFormat.date(from: time)!
        if Calendar.current.isDateInToday(date) {
            self.checkInDate = date
            self.checkInTime = timeString(date: date)
        }
    }
    
    func getCheckOutTime() {
        let data = prefs.getDataFromLocal(CheckAttendanceResponseModel.self, with: .checkAttendance)
        guard let time = data?.data?.jamPulang?.tanggal else { return }
        let date = DateFormatter.dateTimeFormat.date(from: time)!
        if Calendar.current.isDateInToday(date) {
            self.checkOutDate = date
            self.checkOutTime = timeString(date: date)
        }
    }
    
    func getAttendanceInterval(){
        guard let checkInDate, let checkOutDate else { return }
        
        let calendar = Calendar.current
        let totalComponents = calendar.dateComponents([.hour, .minute], from: checkInDate)
        let userWalkedComponents = calendar.dateComponents([.hour, .minute], from: checkOutDate)
        
        let difference = calendar.dateComponents([.minute], from: totalComponents, to: userWalkedComponents).minute!
        let differenceHour = difference / 60
        let differenceFloating = difference % 60
        self.attendanceInterval = "\(differenceHour).\(differenceFloating)"
    }
    
    private func saveCheckAttendanceToLocale(with data: CheckAttendanceResponseModel) {
        prefs.setDataToLocal(data.self, with: .checkAttendance)
    }
    
}
