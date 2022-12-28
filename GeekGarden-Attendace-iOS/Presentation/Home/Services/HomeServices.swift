//
//  HomeServices.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 23/12/22.
//

import Foundation

protocol HomeServicesProtocol: AnyObject {
    var networker: NetworkerProtocol {get}
    func getMadingGeekGarden(endpoint: NetworkFactory) async throws -> MadingGeekGardenModel
    func getAttendanceStats(endpoint: NetworkFactory) async throws -> AttendanceStatsResponseModel
}

final class HomeServices: HomeServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()){
        self.networker = networker
    }
    
    func getMadingGeekGarden(endpoint: NetworkFactory) async throws -> MadingGeekGardenModel {
        return try await networker.taskAsync(type: MadingGeekGardenModel.self, endPoint: endpoint, isMultipart: false)
    }
    
    func getAttendanceStats(endpoint: NetworkFactory) async throws -> AttendanceStatsResponseModel {
        return try await networker.taskAsync(type: AttendanceStatsResponseModel.self, endPoint: endpoint, isMultipart: false)
    }
}
