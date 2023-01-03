//
//  UpdateProfilServices.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 03/01/23.
//

import Foundation

protocol UpdateProfileServiceProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    
    func updatePegawaiPhotoProfile(endpoint: NetworkFactory) async throws -> UpdateDataPegawaiResponse
    func updateDataPegawai(endpoint: NetworkFactory) async throws -> UpdateDataPegawaiResponse
}

final class UpdateProfileServices: UpdateProfileServiceProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()){
        self.networker = networker
    }
    
    func updatePegawaiPhotoProfile(endpoint: NetworkFactory) async throws -> UpdateDataPegawaiResponse {
        return try await networker.taskAsync(type: UpdateDataPegawaiResponse.self, endPoint: endpoint, isMultipart: true)
    }
    
    func updateDataPegawai(endpoint: NetworkFactory) async throws -> UpdateDataPegawaiResponse {
        return try await networker.taskAsync(type: UpdateDataPegawaiResponse.self, endPoint: endpoint, isMultipart: true)
    }
    
    
}
