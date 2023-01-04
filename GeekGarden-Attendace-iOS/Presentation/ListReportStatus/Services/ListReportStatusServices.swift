//
//  ListReportStatusServices.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import Foundation

protocol ListReportStatusServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    
    func getListReportStatus(endpoint: NetworkFactory) async throws -> ListReportAttendanceResponseModel
}

final class ListReportStatusServices: ListReportStatusServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func getListReportStatus(endpoint: NetworkFactory) async throws -> ListReportAttendanceResponseModel {
        return try await networker.taskAsync(type: ListReportAttendanceResponseModel.self, endPoint: endpoint, isMultipart: false)
    }  
}
