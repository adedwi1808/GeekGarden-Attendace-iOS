//
//  ReportAttendanceViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import Foundation

class ReportAttendanceViewModel: ObservableObject {
    @Published var attendanceDate: Date = Date()
    @Published var reportDec: String = ""
    @Published var isLoading: Bool = false
    @Published var reportSuccess: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    private var reportAttendanceServices: ReportAttendanceServicesProtocol
    
    init(reportAttendanceServices: ReportAttendanceServices = ReportAttendanceServices()) {
        self.reportAttendanceServices = reportAttendanceServices
    }
    
    private var remoteDateFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
    
    func postReportAttendance() async throws {
        DispatchQueue.main.async {
            self.isLoading.toggle()
        }
        do {
            let data = try await reportAttendanceServices.postReportAttendance(endPoint:
                    .postReportAttendance(tanggal: remoteDateFormat.string(from: attendanceDate),
                                          keteranganLaporan: reportDec))
            DispatchQueue.main.async {
                self.isLoading.toggle()
                self.reportSuccess.toggle()
                self.showAlert.toggle()
                self.alertMessage = data.message
            }
        } catch let err as NetworkError {
            DispatchQueue.main.async {
                self.isLoading.toggle()
                self.showAlert.toggle()
                self.alertMessage = err.localizedDescription
            }
        }
    }
}
