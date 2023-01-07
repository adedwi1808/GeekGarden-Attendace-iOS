//
//  ReportAttendanceServices.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import Foundation

protocol ReportAttendanceServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    
    func postReportAttendance(endPoint: NetworkFactory) async throws -> ReportAttendanceResponseModel
}

final class ReportAttendanceServices: ReportAttendanceServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func postReportAttendance(endPoint: NetworkFactory) async throws -> ReportAttendanceResponseModel {
        return try await networker.taskAsync(type: ReportAttendanceResponseModel.self, endPoint: endPoint, isMultipart: false)
    }
}
