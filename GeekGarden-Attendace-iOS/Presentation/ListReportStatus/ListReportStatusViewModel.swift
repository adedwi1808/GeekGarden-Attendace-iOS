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
    
    func getReportStatusData() async {
        do {
            let data = try await listReportStatusServices.getListReportStatus(endpoint: .getReportStatus)
            DispatchQueue.main.async {
                self.reportStatusData.append(contentsOf: data.data)
            }
        } catch {
            print("ERR while get list report status")
        }
    }
}

extension ListReportStatusViewModel {
    
    private var remoteDateFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    func dateStringToDateOnly(_ dates: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dates) else { return "?"}
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    func dateStringToDay(_ dates: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dates) else { return "?"}
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    
    func dateStringToMonth(_ dates: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dates) else { return "?"}
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
}
