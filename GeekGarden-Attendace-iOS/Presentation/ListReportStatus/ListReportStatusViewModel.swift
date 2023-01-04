//
//  ListReportStatusViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import Foundation

class ListReportStatusViewModel: ObservableObject {
    @Published var reportStatusData: [ReportAttendanceModel] = []
    
    private var listReportStatusServices: ListReportStatusServicesProtocol
    
    init(listReportStatusServices: ListReportStatusServicesProtocol = ListReportStatusServices()) {
        self.listReportStatusServices = listReportStatusServices
    }
    
    func getReportStatusData() async {
        do {
            let data = try await listReportStatusServices.getListReportStatus(endpoint: .getReportStatus)
            DispatchQueue.main.async {
                self.reportStatusData = data.data
            }
        } catch {
            print("ERR while get list report status")
        }
    }
}
