//
//  Data.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 28/12/22.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
