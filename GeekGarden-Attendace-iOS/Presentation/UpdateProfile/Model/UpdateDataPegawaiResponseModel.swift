//
//  UpdateDataPegawaiResponseModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 03/01/23.
//

import Foundation

struct UpdateDataPegawaiResponse: Codable {
    let code: Int
    let message: String
    let data: DataPegawaiModel
}
