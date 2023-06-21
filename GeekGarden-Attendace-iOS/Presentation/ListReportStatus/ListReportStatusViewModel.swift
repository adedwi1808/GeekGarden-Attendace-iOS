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
    private var prefs = UserDefaults()
    
    init(listReportStatusServices: ListReportStatusServicesProtocol = ListReportStatusServices()) {
        self.listReportStatusServices = listReportStatusServices
    }
    
    @MainActor
    func getReportStatusData() async {
        do {
            let data = try await listReportStatusServices.getListReportStatus(endpoint: .getReportStatus)
                self.reportStatusData = data.data
        } catch {
            print("ERR while get list report status")
        }
    }
}

extension ListReportStatusViewModel {
    func dateStringToDateOnly(_ dates: String) -> String {
        DateFormatter.stringDateFromDateOnlyFormat(using: dates)
    }
    
    func dateStringToDay(_ dates: String) -> String {
        DateFormatter.stringDay(using: dates)
    }
    
    func dateStringToMonth(_ dates: String) -> String {
        DateFormatter.stringMonth(using: dates)
    }
}
