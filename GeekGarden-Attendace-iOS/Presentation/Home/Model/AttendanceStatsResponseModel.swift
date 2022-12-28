//
//  AttendanceStatsResponseModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 29/12/22.
//

import Foundation

struct AttendanceStatsResponseModel: Codable {
    let code: Int?
    let message: String?
    let data: AttendanceStatsModel?
}

// MARK: - DataClass
struct AttendanceStatsModel: Codable {
    let cuti, izin, lembur, hadir: Int?
}
