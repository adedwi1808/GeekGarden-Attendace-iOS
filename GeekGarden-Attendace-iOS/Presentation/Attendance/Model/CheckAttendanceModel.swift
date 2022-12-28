//
//  CheckAttendanceModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 29/12/22.
//

import Foundation

struct CheckAttendanceResponseModel: Codable {
    let code: Int?
    let message: String?
    let data: DataClass?
}

struct CheckAttendanceModel: Codable {
    let jumlahAbsenHariIni: Int?
    let jamHadir, jamPulang: Jam?

    enum CodingKeys: String, CodingKey {
        case jumlahAbsenHariIni = "jumlah_absen_hari_ini"
        case jamHadir = "jam_hadir"
        case jamPulang = "jam_pulang"
    }
}

struct Jam: Codable {
    let tanggal: String?
}

