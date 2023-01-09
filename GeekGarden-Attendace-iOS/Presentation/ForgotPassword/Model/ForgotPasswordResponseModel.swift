//
//  ForgotPasswordResponseModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 09/01/23.
//

import Foundation

struct ForgotPasswordResponseModel: Codable {
    let code: Int
    let message: String
    let data: DataPegawaiModel
}
