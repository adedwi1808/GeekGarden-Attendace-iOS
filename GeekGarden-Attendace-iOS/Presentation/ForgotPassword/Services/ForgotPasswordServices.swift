//
//  ForgotPasswordServices.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 09/01/23.
//

import Foundation

protocol ForgotPasswordServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    
    func postForgotPassword(endpoint: NetworkFactory) async throws -> ForgotPasswordResponseModel
}

final class ForgotPasswordServices: ForgotPasswordServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func postForgotPassword(endpoint: NetworkFactory) async throws -> ForgotPasswordResponseModel {
        return try await networker.taskAsync(type: ForgotPasswordResponseModel.self, endPoint: endpoint, isMultipart: false)
    }
}
