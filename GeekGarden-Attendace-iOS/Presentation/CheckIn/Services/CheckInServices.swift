//
//  CheckInServices.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 27/12/22.
//

import Foundation

protocol CheckInServicesProtocol: AnyObject {
    var networker: NetworkerProtocol {get}
    func postCheckIn(endpoint: NetworkFactory) async throws -> CheckInResponseModel
}

final class CheckInServices: CheckInServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()){
        self.networker = networker
    }
    
    func postCheckIn(endpoint: NetworkFactory) async throws -> CheckInResponseModel {
        return try await networker.taskAsync(type: CheckInResponseModel.self, endPoint: endpoint, isMultipart: true)
    }
}
