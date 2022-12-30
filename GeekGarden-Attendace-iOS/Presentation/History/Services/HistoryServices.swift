//
//  HistoryServices.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 29/12/22.
//

import Foundation

protocol HistoryServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getAttendanceHistory(endpoint: NetworkFactory) async throws -> AttendanceHistoryResponseModel
}

final class HistoryServices: HistoryServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func getAttendanceHistory(endpoint: NetworkFactory) async throws -> AttendanceHistoryResponseModel {
        return try await networker.taskAsync(type: AttendanceHistoryResponseModel.self, endPoint: endpoint, isMultipart: false)
    }
}
