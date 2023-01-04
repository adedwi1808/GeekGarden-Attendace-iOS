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
    
    private var reportAttendanceServices: ReportAttendanceServicesProtocol
    
    init(reportAttendanceServices: ReportAttendanceServices = ReportAttendanceServices()) {
        self.reportAttendanceServices = reportAttendanceServices
    }
    
    private var remoteDateFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
    
    func postReportAttendance() async {
        if reportDec.count < 5 {
            print("Silahkan Isi Form Terlebih Dahulu")
            return
        }
        
        do {
            _ = try await reportAttendanceServices.postReportAttendance(endPoint:
                    .postReportAttendance(tanggal: remoteDateFormat.string(from: attendanceDate),
                                          keteranganLaporan: reportDec))
        } catch  {
            print("ERR while post report attendance")
        }
    }
}
