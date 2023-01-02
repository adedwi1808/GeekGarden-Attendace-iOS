//
//  NetworkFactory.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 19/12/22.
//

import Foundation
import SwiftUI

enum NetworkFactory {
    //AUTH
    case loginPegawai(email: String, password: String)
    
    case getMadingGeekGarden
    
    //ATTENDANCE
    case postCheckIn(tempat: String, status: String, long: String, lat: String, image: Data)
    case postCheckOut(tempat: String, status: String, prog: String, long: String, lat: String, image: Data)
    case checkAttendance
    case getAttendanceStats
    case getAttendanceHistory
}

extension NetworkFactory {
    
    // MARK: URL PATH API
    var path: String {
        switch self {
        case .loginPegawai:
            return "/api/login-pegawai"
        case .getMadingGeekGarden:
            return "/api/madings"
        case .postCheckIn:
            return "/api/absensi-hadir-ios"
        case .checkAttendance:
            return "/api/cek-absensi"
        case .postCheckOut:
            return "/api/absensi-pulang-ios"
        case .getAttendanceStats:
            return "/api/data-absensi"
        case .getAttendanceHistory:
            return "/api/riwayat-absensi"
        }
    }
    
    // MARK: URL QUERY PARAMS / URL PARAMS
    var queryItems: [URLQueryItem] {
        switch self {
        case .loginPegawai:
            return []
        case .checkAttendance, .getAttendanceStats, .getAttendanceHistory:
            return []
        case .getMadingGeekGarden:
            return []
        case .postCheckIn, .postCheckOut:
            return []
        }
    }
    
    // MARK: BASE URL API
    var baseApi: String? {
        switch self {
        default:
            return "d8c5-182-253-183-4.ap.ngrok.io"
        }
    }
    
    // MARK: URL LINK
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseApi
        let finalParams: [URLQueryItem] = self.queryItems
        components.path = path
        components.queryItems = finalParams
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    // MARK: HTTP METHOD
    var method: RequestMethod {
        switch self {
        case .loginPegawai:
            return .post
        case .postCheckIn, .postCheckOut:
            return .post
        default:
            return .get
        }
    }
    
    enum RequestMethod: String {
        case delete = "DELETE"
        case get = "GET"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
    }
    
    // MARK: BODY PARAMS API
    var bodyParam: [String: Any]? {
        switch self {
        case .loginPegawai(let email, let password):
            return ["email": email,
                    "password": password]
        case .postCheckIn(let tempat, let status, let long, let lat, _):
            return ["tempat": tempat, "status": status, "longitude": long, "latitude": lat]
        case .postCheckOut(let tempat, let status, let prog, let long, let lat, _):
            return ["tempat": tempat, "status":status, "progress_hari_ini": prog, "longitude":long, "latitude":lat]
        default:
            return [:]
        }
    }
    
    // MARK: MULTIPART DATA
    var data: Data? {
        switch self {
        case .postCheckIn(_, _, _, _, let image):
            return image as Data?
        case .postCheckOut(_, _, _, _, _, let image):
            return image as Data?
        default:
            return Data()
        }
    }
    
    // MARK: HEADER API
    var headers: [String: String]? {
        switch self {
        case .loginPegawai:
            return getHeaders(type: .anonymous)
        case .getMadingGeekGarden, .checkAttendance, .getAttendanceStats, .getAttendanceHistory:
            return getHeaders(type: .appToken)
        case .postCheckIn:
            return getHeaders(type: .multiPart)
        case .postCheckOut:
            return getHeaders(type: .multiPart)
        }
    }
    
    // MARK: TYPE OF HEADER
    enum HeaderType {
        case anonymous
        case appToken
        case multiPart
    }
    
    func getBoundary() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    fileprivate func getHeaders(type: HeaderType) -> [String: String] {
        
        let appToken = UserDefaults.standard.getDataFromLocal(String.self, with: .appToken)
        
        var header: [String: String]
        
        switch type {
        case .anonymous:
            header = ["Content-Type": "application/json"]
        case .appToken:
            header = ["Content-Type": "application/json",
                      "Accept": "*/*",
                      "Authorization": "Bearer \(appToken ?? "")"]
        case .multiPart:
            header = ["Accept": "*/*",
                      "Authorization": "Bearer \(appToken ?? "")"]
        }
        return header
    }
    
    func createBodyWithParameters(parameters: [String: Any], imageDataKey: Data?, boundary: String)  -> Data {
        var body = Data()
        let filePath = "image"
        let fileName = "imagggee.jpg"
        let mimetype = "image/jpeg"
        let lineBreak = "\r\n"
        for (key, value) in parameters {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
            body.append("\(value)")
            body.append("\(lineBreak)")
        }
        
        body.append("\r\n--\(boundary)\r\n")
        
        if let imageDataKey {
            body.append("Content-Disposition: form-data; name=\"\(filePath)\"; filename=\"\(fileName)\"\r\n")
            body.append("Content-Type: \(mimetype)\r\n\r\n")
            body.append(imageDataKey)
            body.append("\r\n--\(boundary)--\r\n")
        }
        return body
    }
    
    var urlRequestMultipart: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = method.rawValue
        let boundary = getBoundary()
        
        if let headers = headers {
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            headers.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let bodyParam, let data {
            urlRequest.httpBody =  createBodyWithParameters(parameters: bodyParam,
                                                            imageDataKey: data,
                                                            boundary: boundary)
        }
        return urlRequest
    }
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        var bodyData: Data?
        urlRequest.httpMethod = method.rawValue
        if let header = headers {
            header.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let bodyParam = bodyParam, method != .get {
            do {
                bodyData = try JSONSerialization.data(withJSONObject: bodyParam, options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            } catch {
                // swiftlint:disable disable_print
#if DEBUG
                print(error)
#endif
                // swiftlint:enable disable_print
            }
        }
        return urlRequest
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
}
