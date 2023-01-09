//
//  MoreServices.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 09/01/23.
//

import Foundation

protocol MoreServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    
    func signOut(endpoint: NetworkFactory) async throws -> SignOutResponseModel
}

final class MoreServices: MoreServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func signOut(endpoint: NetworkFactory) async throws -> SignOutResponseModel {
        return try await networker.taskAsync(type: SignOutResponseModel.self, endPoint: endpoint, isMultipart: false)
    }
}
