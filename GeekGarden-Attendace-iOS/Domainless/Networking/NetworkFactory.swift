//
//  NetworkFactory.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 19/12/22.
//

import Foundation

enum NetworkFactory {
    case getPost(page: Int)
    case getUser
    case getHeroes
    case getHeroStats
    case loginPegawai(email: String, password: String)
    case getMadingGeekGarden
}

extension NetworkFactory {
    
    // MARK: URL PATH API
    var path: String {
        switch self {
        case .getPost(let page):
            return "/posts/page\(page)"
        case .getUser:
            return "/users"
        case .getHeroes:
            return "/api/heroes"
        case .getHeroStats:
            return "/api/heroStats"
        case .loginPegawai:
            return "/api/login-pegawai"
        case .getMadingGeekGarden:
            return "/api/madings"
        }
    }
    
    // MARK: URL QUERY PARAMS / URL PARAMS
    var queryItems: [URLQueryItem] {
        switch self {
        case .getPost, .getUser:
            return []
        case .getHeroes, .getHeroStats:
            return []
        case .loginPegawai:
            return []
        case .getMadingGeekGarden:
            return []
        }
    }
    
    // MARK: BASE URL API
    var baseApi: String? {
        switch self {
        default:
            return "5d38-182-253-183-13.ap.ngrok.io"
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
            return ["email": email, "password": password]
        default:
            return [:]
        }
    }
    
    // MARK: MULTIPART DATA
    var data: Data? {
        switch self {
        default:
            return Data()
        }
    }
    
    // MARK: HEADER API
    var headers: [String: String]? {
        switch self {
        case .getPost, .getUser:
            return getHeaders(type: .anonymous)
        case .getHeroes, .getHeroStats:
            return getHeaders(type: .anonymous)
        case .loginPegawai:
            return getHeaders(type: .anonymous)
        case .getMadingGeekGarden:
            return getHeaders(type: .appToken)
        }
    }
    
    // MARK: TYPE OF HEADER
    enum HeaderType {
        case anonymous
        case appToken
        case multiPart
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
            let boundary = generateBoundaryString()
            header = ["Content-Type": "multipart/form-data; boundary=\(boundary)",
                      "Accept": "*/*",
                      "x-lapakibu-token": "\(appToken ?? "")"]
        }
        return header
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
