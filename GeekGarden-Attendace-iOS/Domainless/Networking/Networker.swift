//
//  Networker.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 19/12/22.
//

import Foundation


protocol NetworkerProtocol: AnyObject {
    func taskAsync<T>(type: T.Type,
                      endPoint: NetworkFactory,
                      isMultipart: Bool
    ) async throws -> T where T: Decodable
}

final class Networker: NetworkerProtocol {
    func taskAsync<T>(type: T.Type, endPoint: NetworkFactory, isMultipart: Bool) async throws -> T where T: Decodable {
        let (data, response) = try await URLSession.shared.data(for: isMultipart ? endPoint.urlRequestMultipart: endPoint.urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.middlewareError(code: 500, message: "Connection Error")
        }
        
        // swiftlint:disable disable_print
        #if DEBUG || NETFOX
//        let dataString = String(decoding: data, as: UTF8.self)
//        print("Response : \(dataString)")
        #endif
        // swiftlint:enable disable_print
        
        guard 200..<300 ~= httpResponse.statusCode else {
            let res  = try JSONDecoder().decode(NetworkHandle.self, from: data)
            let error = self.mapHTTPError(with: res.code, errorMessage: res.message)
            throw error
        }
        
        do {
            let decoder = JSONDecoder()
            let dataNew = try decoder.decode(type, from: data)
            return dataNew
        } catch let decodingError as DecodingError {
            // swiftlint:disable disable_print
            #if DEBUG || NETFOX
            print(decodingError)
            #endif
            // swiftlint:enable disable_print
            throw NetworkError.middlewareError(code: 500, message: decodingError.errorDescription)
        }
    }
}

extension Networker {
    private func mapHTTPError(with code: Int, errorMessage: String) -> NetworkError {
        let error: NetworkError
        switch code {
        default:
            error = .middlewareError(code: code, message: errorMessage)
        }
        return error
    }
}

