//
//  HistoryViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 29/12/22.
//

import Foundation

class HistoryViewModel: ObservableObject {
    @Published var attendanceHistory: [AttendanceHistoryModel] = []
    
    @Published var isLoaded: Bool = false
    
    private var historyServices: HistoryServicesProtocol
    private var prefs = UserDefaults()
    
    init(historyServices: HistoryServicesProtocol = HistoryServices()) {
        self.historyServices = historyServices
    }
    
    func getAttendanceHistory() async {
        do {
            let data = try await historyServices.getAttendanceHistory(endpoint: .getAttendanceHistory)
            saveAttendanceHistoryToLocale(with: data)
            DispatchQueue.main.async {
                self.attendanceHistory.append(contentsOf: data.data!)
                self.isLoaded = true
            }
        } catch {
            print("ERR While get Attendance History")
        }
    }
    
    func saveAttendanceHistoryToLocale(with data: AttendanceHistoryResponseModel) {
        prefs.setDataToLocal(data.self, with: .attendanceHistory)
    }
    
    func setAttendanceHistoryData() {
        let data = prefs.getDataFromLocal(AttendanceHistoryResponseModel.self, with: .attendanceHistory)
        guard let data = data?.data else { return }
        self.attendanceHistory = data
    }
    
    func dateStringToDay(_ dates: String) -> String {
        DateFormatter.stringDay(using: dates)
    }
    
    func dateStringToMonth(_ dates: String) -> String {
        DateFormatter.stringMonth(using: dates)
    }
    
    func dateStringToTime(_ dates: String) -> String {
        DateFormatter.stringTime(using: dates)
    }
}
