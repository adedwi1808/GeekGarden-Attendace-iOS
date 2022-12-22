//
//  DataPegawaiModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 22/12/22.
//

import Foundation

struct DataPegawaiModel: Codable {
    let idPegawai: Int?
    let nama, jenisKelamin, nomorHP, email: String?
    let jabatan: String?
    let fotoProfile: JSONNull?

    enum CodingKeys: String, CodingKey {
        case idPegawai = "id_pegawai"
        case nama
        case jenisKelamin = "jenis_kelamin"
        case nomorHP = "nomor_hp"
        case email, jabatan
        case fotoProfile = "foto_profile"
    }
}
