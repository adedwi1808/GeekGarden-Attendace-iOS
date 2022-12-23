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
}

final class HomeServices: HomeServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()){
        self.networker = networker
    }
    
    func getMadingGeekGarden(endpoint: NetworkFactory) async throws -> MadingGeekGardenModel {
        return try await networker.taskAsync(type: MadingGeekGardenModel.self, endPoint: endpoint, isMultipart: false)
    }
}
