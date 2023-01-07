//
//  ListWorkPermitStatusViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import Foundation

class ListWorkPermitStatusViewModel: ObservableObject {
    @Published var workPermitData: [WorkPermitModel] = []
    private var listWorkPermitStatusServices: ListWorkPermitStatusServicesProtocol
    private var prefs = UserDefaults()
    
    init(listWorkPermitStatusServices: ListWorkPermitStatusServicesProtocol = ListWorkPermitStatusServices()) {
        self.listWorkPermitStatusServices = listWorkPermitStatusServices
    }
    
    func getListWorkPermitStatus() async {
        do {
            let data = try await listWorkPermitStatusServices.getListWorkPermitStatus(endpoint: .getWorkPermitStatus)
            DispatchQueue.main.async {
                self.workPermitData.append(contentsOf: data.data)
            }
        } catch {
            print("ERR while get list work permit status")
        }
    }
}

extension ListWorkPermitStatusViewModel {
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
