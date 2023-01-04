//
//  WorkPermitViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import Foundation

class WorkPermitViewModel: ObservableObject {
    @Published var showPicker = false
    @Published var source: ImagePickerFactory.Source = .library
    @Published var cameraError: ImagePickerFactory.CameraErrorType?
    @Published var showCameraAlert = false
    
    @Published var selectedReason: PermitReasons = .sakit
    @Published var permitReasonDec: String = ""
    @Published var permitDateStart: Date = Date()
    @Published var permitDateEnd: Date = Date()
    @Published var isShowActionSheet: Bool = false
    @Published var isShowAlert: Bool = false
    
    
    func showPhotoPicker() {
        do {
            if source == .camera {
                try ImagePickerFactory.checkPermissions()
            }
            showPicker = true
        } catch {
            showCameraAlert = true
            cameraError = ImagePickerFactory.CameraErrorType(error: error as! ImagePickerFactory.PickerError)
        }
    }
}
