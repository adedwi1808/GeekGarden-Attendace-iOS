//
//  WorkPermitResponseModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import Foundation

struct WorkPermitResponseModel: Codable {
    let code: Int
    let message: String
    let data: WorkPermitModel
}

// MARK: - DataClass
struct WorkPermitModel: Codable {
    let idPengajuanIzin, idPegawai: Int
    let idAdmin: String?
    let jenisIzin, tanggalMulaiIzin, tanggalSelesaiIzin, alasanIzin: String
    let keteranganAdmin: String?
    let suratIzin, statusIzin, tanggalMengajukanIzin: String

    enum CodingKeys: String, CodingKey {
        case idPengajuanIzin = "id_pengajuan_izin"
        case idPegawai = "id_pegawai"
        case idAdmin = "id_admin"
        case jenisIzin = "jenis_izin"
        case tanggalMulaiIzin = "tanggal_mulai_izin"
        case tanggalSelesaiIzin = "tanggal_selesai_izin"
        case alasanIzin = "alasan_izin"
        case keteranganAdmin = "keterangan_admin"
        case suratIzin = "surat_izin"
        case statusIzin = "status_izin"
        case tanggalMengajukanIzin = "tanggal_mengajukan_izin"
    }
}
