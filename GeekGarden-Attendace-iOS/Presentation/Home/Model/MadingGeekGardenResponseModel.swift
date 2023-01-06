//
//  MadingGeekGardenModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 23/12/22.
//

import Foundation


// MARK: - MadingGeekGardenModel
struct MadingGeekGardenResponseModel: Codable {
    let code: Int?
    let message: String?
    let data: [MadingGeekGardenModel]?
}

// MARK: - Datum
struct MadingGeekGardenModel: Codable {
    let idMading, idAdmin: Int?
    let judul, informasi, foto, createAt: String?

    enum CodingKeys: String, CodingKey {
        case idMading = "id_mading"
        case idAdmin = "id_admin"
        case judul, informasi, foto
        case createAt = "create_at"
    }
}
