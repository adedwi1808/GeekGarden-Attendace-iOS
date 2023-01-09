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
    case signOut
    
    //FORGOT PASSWORD
    case forgotPassword(email: String)
    
    //MADING
    case getMadingGeekGarden
    
    //ATTENDANCE
    case postCheckIn(tempat: String, status: String, long: String, lat: String, image: Data)
    case postCheckOut(tempat: String, status: String, prog: String, long: String, lat: String, image: Data)
    case checkAttendance
    case getAttendanceStats
    case getAttendanceHistory
    //Permit
    case workPermit(jenisIzin: String, tanggalMulai: String, tanggalSelesai: String, alasanIzin: String, suratIzin: Data)
    case getWorkPermitStatus
    //Report
    case postReportAttendance(tanggal: String, keteranganLaporan: String)
    case getReportStatus
    //Profile
    case updatePegawaiPhotoProfile(image: Data)
    case updateDataPegawai(email: String, noHP: String, password: String)
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
        case .updatePegawaiPhotoProfile:
            return "/api/foto-pegawai-ios"
        case .updateDataPegawai:
            return "/api/update-pegawai-ios"
        case .workPermit:
            return "/api/pengajuan-izin-ios"
        case .postReportAttendance:
            return "/api/pengaduan-absensi"
        case .getReportStatus:
            return "/api/riwayat-pengaduan-absensi"
        case .getWorkPermitStatus:
            return "/api/riwayat-pengajuan-izin"
        case .signOut:
            return "/api/logout-pegawai"
        case .forgotPassword:
            return "/api/lupa-password"
        }
    }
    
    // MARK: URL QUERY PARAMS / URL PARAMS
    var queryItems: [URLQueryItem] {
        switch self {
        case .loginPegawai, .signOut:
            return []
        case .checkAttendance, .getAttendanceStats, .getAttendanceHistory:
            return []
        case .getMadingGeekGarden:
            return []
        case .postCheckIn, .postCheckOut:
            return []
        case .updatePegawaiPhotoProfile:
            return []
        case .updateDataPegawai:
            return []
        case .workPermit:
            return []
        case .postReportAttendance:
            return []
        case .getReportStatus:
            return []
        case .getWorkPermitStatus:
            return []
        case .forgotPassword:
            return []
        }
    }
    
    // MARK: BASE URL API
    var baseApi: String? {
        switch self {
        default:
            return Constans().baseURL
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
        case .loginPegawai, .signOut:
            return .post
        case .postCheckIn, .postCheckOut:
            return .post
        case .updateDataPegawai:
            return .post
        case .updatePegawaiPhotoProfile:
            return .post
        case .workPermit:
            return .post
        case .postReportAttendance:
            return .post
        case .forgotPassword:
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
        case .updateDataPegawai(let email, let noHP, let password):
            return ["email": email,
                    "nomor_hp": noHP,
                    "password": password]
        case .workPermit(let jenisIzin, let tanggalMulai, let tanggalSelesai, let alasanIzin, _):
            return ["jenis_izin": jenisIzin,
                    "tanggal_mulai_izin": tanggalMulai,
                    "tanggal_selesai_izin": tanggalSelesai,
                    "alasan_izin": alasanIzin,
                    "status_izin": "diAjukan"]
        case .postReportAttendance(let tanggal, let keterangan):
            return ["tanggal_absen" : tanggal,
                    "keterangan_pengaduan" : keterangan]
        case .forgotPassword(let email):
            return ["email":email]
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
        case .updatePegawaiPhotoProfile(let image):
            return image as Data?
        case .workPermit( _, _, _, _, let image):
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
        case .updatePegawaiPhotoProfile(image: _):
            return getHeaders(type: .multiPart)
        case .updateDataPegawai(email: _, noHP: _, password: _):
            return getHeaders(type: .multiPart)
        case .workPermit:
            return getHeaders(type: .multiPart)
        case .postReportAttendance:
            return getHeaders(type: .appToken)
        case .getReportStatus:
            return getHeaders(type: .appToken)
        case .getWorkPermitStatus:
            return getHeaders(type: .appToken)
        case .signOut:
            return getHeaders(type: .appToken)
        case .forgotPassword:
            return getHeaders(type: .anonymous)
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
        
        if let imageDataKey, imageDataKey != Data() {
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
