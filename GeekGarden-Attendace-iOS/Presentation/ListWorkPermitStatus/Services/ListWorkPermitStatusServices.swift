//
//  ListWorkPermitStatusServices.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import Foundation

protocol ListWorkPermitStatusServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    
    func getListWorkPermitStatus(endpoint: NetworkFactory) async throws -> ListWorkPermitStatusResponseModel
}

final class ListWorkPermitStatusServices: ListWorkPermitStatusServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()){
        self.networker = networker
    }
    
    func getListWorkPermitStatus(endpoint: NetworkFactory) async throws -> ListWorkPermitStatusResponseModel {
        return try await networker.taskAsync(type: ListWorkPermitStatusResponseModel.self, endPoint: endpoint, isMultipart: false)
    }
    
    
}
