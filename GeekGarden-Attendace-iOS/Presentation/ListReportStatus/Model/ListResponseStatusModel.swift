//
//  ListResponseStatusModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import Foundation

struct ListReportAttendanceResponseModel: Codable {
    let code: Int
    let message: String
    let data: [ReportAttendanceModel]
}
