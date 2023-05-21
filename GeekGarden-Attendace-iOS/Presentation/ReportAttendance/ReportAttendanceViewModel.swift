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
    
    @MainActor
    func postReportAttendance() async throws {
            self.isLoading.toggle()
        do {
            let data = try await reportAttendanceServices.postReportAttendance(endPoint:
                    .postReportAttendance(tanggal: DateFormatter.dateTimeFormat.string(from: attendanceDate),
                                          keteranganLaporan: reportDec))
                self.isLoading.toggle()
                self.reportSuccess.toggle()
                self.showAlert.toggle()
                self.alertMessage = data.message
        } catch let err as NetworkError {
                self.isLoading.toggle()
                self.showAlert.toggle()
                self.alertMessage = err.localizedDescription
        }
    }
}
