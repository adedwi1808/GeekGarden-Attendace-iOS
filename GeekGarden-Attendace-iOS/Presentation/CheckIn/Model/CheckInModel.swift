//
//  CheckInModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 27/12/22.
//

import Foundation

struct CheckInResponseModel: Codable {
    let code: Int
    let message: String
    let data: Attendance?
}

// MARK: - DataClass
struct Attendance: Codable {
    let idAbsensi, idPegawai: Int?
    let tempat, status, longitude, latitude: String?
    let foto: String?
    let tanggal: String?

    enum CodingKeys: String, CodingKey {
        case idAbsensi = "id_absensi"
        case idPegawai = "id_pegawai"
        case tempat, status, longitude, latitude, foto, tanggal
    }
}

