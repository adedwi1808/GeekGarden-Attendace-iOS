//
//  ListWorkPermitStatusViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import Foundation

class ListWorkPermitStatusViewModel: ObservableObject {
    @Published var workPermitData: [WorkPermitModel] = []
    @Published var isWorkPermitHistoryLoaded: Bool = false
    private var listWorkPermitStatusServices: ListWorkPermitStatusServicesProtocol
    private var prefs = UserDefaults()
    
    init(listWorkPermitStatusServices: ListWorkPermitStatusServicesProtocol = ListWorkPermitStatusServices()) {
        self.listWorkPermitStatusServices = listWorkPermitStatusServices
    }
    
    @MainActor
    func getListWorkPermitStatus() async throws{
        do {
            let data = try await listWorkPermitStatusServices.getListWorkPermitStatus(endpoint: .getWorkPermitStatus)
                self.workPermitData.append(contentsOf: data.data)
            isWorkPermitHistoryLoaded = true
        } catch {
            print("ERR while get list work permit status")
        }
    }
}

extension ListWorkPermitStatusViewModel {
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
