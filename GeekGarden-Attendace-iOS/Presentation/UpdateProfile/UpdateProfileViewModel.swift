//
//  UpdateProfileViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 02/01/23.
//

import Foundation

class UpdateProfileViewModel: ObservableObject {
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    @Published var cameraError: Picker.CameraErrorType?
    @Published var showCameraAlert = false
    @Published var pegawaiName: String = "Ade Dwi Prayitno"
    @Published var pegawaiEmail: String = "adedwip1808@gmail.com"
    @Published var pegawaiPhoneNumber: String = "082255275887"
    @Published var pegawaiPassword: String = "123123"
    
    private var updateProfileServices: UpdateProfileServiceProtocol
    
    init(updateProfileServices: UpdateProfileServiceProtocol = UpdateProfileServices()) {
        self.updateProfileServices = updateProfileServices
    }
    
    func showPhotoPicker() {
        do {
            if source == .camera {
                try Picker.checkPermissions()
            }
            showPicker = true
        } catch {
            showCameraAlert = true
            cameraError = Picker.CameraErrorType(error: error as! Picker.PickerError)
        }
    }
}
