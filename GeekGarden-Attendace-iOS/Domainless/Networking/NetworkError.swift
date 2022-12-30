//
//  NetworkError.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 19/12/22.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    
    case middlewareError(code: Int, message: String?)
    
    var localizedDescription: String {
        switch self {
            case .middlewareError(_, let message):
                return message ?? ""
        }
    }
}

struct NetworkHandle: Decodable, Error, LocalizedError {
    let success: Bool
    let data: NetworkHandleData
    let message: String
    let code: Int
    let codeName: String
    
    enum CodingKeys: String, CodingKey {
        case success, data, message, code
        case codeName = "code_name"
    }
}

// MARK: - DataClass
struct NetworkHandleData: Decodable {
}
