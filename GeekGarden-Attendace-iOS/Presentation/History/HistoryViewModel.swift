//
//  HistoryViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 29/12/22.
//

import Foundation

class HistoryViewModel: ObservableObject {
    @Published var attendanceHistory: [AttendanceHistoryModel] = []
    
    private var historyServices: HistoryServicesProtocol
    private var prefs = UserDefaults()
    
    init(historyServices: HistoryServicesProtocol = HistoryServices()) {
        self.historyServices = historyServices
    }
    
    func getAttendanceHistory() async {
        do {
            let data = try await historyServices.getAttendanceHistory(endpoint: .getAttendanceHistory)
            saveAttendanceHistoryToLocale(with: data)
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dates) else { return "-"}
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    
    func dateStringToMonth(_ dates: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dates) else { return "-"}
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    
    func dateStringToTime(_ dates: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dates) else { return "-"}
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
