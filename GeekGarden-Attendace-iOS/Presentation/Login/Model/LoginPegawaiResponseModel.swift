//
//  LoginResponseModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 22/12/22.
//

import Foundation

// MARK: - LoginPegawaiResponseModel
struct LoginPegawaiResponseModel: Codable {
    let data: DataClass?
    let token: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    let idPegawai: Int?
    let nama, jenisKelamin, nomorHP, email: String?
    let jabatan: String?
    let fotoProfile: String?

    enum CodingKeys: String, CodingKey {
        case idPegawai = "id_pegawai"
        case nama
        case jenisKelamin = "jenis_kelamin"
        case nomorHP = "nomor_hp"
        case email, jabatan
        case fotoProfile = "foto_profile"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

