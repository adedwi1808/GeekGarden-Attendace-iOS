//
//  UpdateProfileViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 02/01/23.
//

import Foundation

class UpdateProfileViewModel: ObservableObject {
    @Published var pegawaiName: String = "Ade Dwi Prayitno"
    @Published var pegawaiEmail: String = "adedwip1808@gmail.com"
    @Published var pegawaiPhoneNumber: String = "082255275887"
    @Published var pegawaiPassword: String = "123123"
}
