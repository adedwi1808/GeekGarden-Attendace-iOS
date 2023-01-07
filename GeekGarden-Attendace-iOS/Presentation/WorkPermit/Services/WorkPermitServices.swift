//
//  WorkPermitServices.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import Foundation

protocol WorkPermitServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    
    func postWorkPermit(endPoint: NetworkFactory) async throws -> WorkPermitResponseModel
}

final class WorkPermitServices: WorkPermitServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func postWorkPermit(endPoint: NetworkFactory) async throws -> WorkPermitResponseModel {
        return try await networker.taskAsync(type: WorkPermitResponseModel.self, endPoint: endPoint, isMultipart: true)
    }
    
    
}
