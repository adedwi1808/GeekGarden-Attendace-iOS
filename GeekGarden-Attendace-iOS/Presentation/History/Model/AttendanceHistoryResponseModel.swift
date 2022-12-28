//
//  AttendanceHistoryResponseModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 29/12/22.
//

import Foundation

struct AttendanceHistoryResponseModel: Codable {
    let code: Int?
    let message: String?
    let data: [AttendanceHistoryModel]?
}

// MARK: - Datum
struct AttendanceHistoryModel: Codable {
    let idAbsensi, idPegawai: Int?
    let tempat: String?
    let status: String?
    let longitude, latitude: String?
    let foto: String?
    let tanggal: String?

    enum CodingKeys: String, CodingKey {
        case idAbsensi = "id_absensi"
        case idPegawai = "id_pegawai"
        case tempat, status, longitude, latitude, foto, tanggal
    }
}
