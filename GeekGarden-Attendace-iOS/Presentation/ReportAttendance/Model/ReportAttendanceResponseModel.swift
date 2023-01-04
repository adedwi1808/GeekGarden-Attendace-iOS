//
//  ReportAttendanceResponseModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import Foundation

// MARK: - ReportAttendanceResponseModel
struct ReportAttendanceResponseModel: Codable {
    let code: Int
    let message: String
    let data: [ReportAttendanceModel]
}

// MARK: - Datum
struct ReportAttendanceModel: Codable {
    let idPengaduanAbsensi, idPegawai: Int
    let idAdmin: Int?
    let tanggalAbsen, keteranganPengaduan: String
    let keteranganAdmin: String?
    let tanggalPengaduan, statusPengaduan: String
    let admin: AdminModel?

    enum CodingKeys: String, CodingKey {
        case idPengaduanAbsensi = "id_pengaduan_absensi"
        case idPegawai = "id_pegawai"
        case idAdmin = "id_admin"
        case tanggalAbsen = "tanggal_absen"
        case keteranganPengaduan = "keterangan_pengaduan"
        case keteranganAdmin = "keterangan_admin"
        case tanggalPengaduan = "tanggal_pengaduan"
        case statusPengaduan = "status_pengaduan"
        case admin
    }
}

// MARK: - Admin
struct AdminModel: Codable {
    let idAdmin: Int
    let nama, email: String

    enum CodingKeys: String, CodingKey {
        case idAdmin = "id_admin"
        case nama, email
    }
}
