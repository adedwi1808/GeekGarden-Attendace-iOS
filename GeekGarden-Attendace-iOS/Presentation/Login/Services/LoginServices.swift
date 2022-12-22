//
//  LoginServices.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 22/12/22.
//

import Foundation

protocol LoginServicesProtocol: AnyObject {
    var networker: NetworkerProtocol {get}
    func loginPegawai(endpoint: NetworkFactory) async throws -> LoginPegawaiResponseModel
}

final class LoginPegawaiServices: LoginServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()){
        self.networker = networker
    }
    
    func loginPegawai(endpoint: NetworkFactory) async throws -> LoginPegawaiResponseModel {
        return try await networker.taskAsync(type: LoginPegawaiResponseModel.self, endPoint: endpoint, isMultipart: false)
    }
}
