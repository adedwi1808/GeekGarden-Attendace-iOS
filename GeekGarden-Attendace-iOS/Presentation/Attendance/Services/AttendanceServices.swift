//
//  AttendanceServices.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 29/12/22.
//

import Foundation

protocol AttendanceServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func checkAttendance(endpoint: NetworkFactory) async throws -> CheckAttendanceResponseModel
}

final class AttendanceServices: AttendanceServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func checkAttendance(endpoint: NetworkFactory) async throws -> CheckAttendanceResponseModel {
        return try await networker.taskAsync(type: CheckAttendanceResponseModel.self, endPoint: endpoint, isMultipart: false)
    }
}
