//
//  CheckOutServices.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 29/12/22.
//

import Foundation

protocol CheckOutServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func postCheckOut(endpoint: NetworkFactory) async throws -> CheckOutResponseModel
}

final class CheckOutServices: CheckOutServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func postCheckOut(endpoint: NetworkFactory) async throws -> CheckOutResponseModel {
        return try await networker.taskAsync(type: CheckOutResponseModel.self, endPoint: endpoint, isMultipart: true)
    }
}
