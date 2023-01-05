//
//  CheckInViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 26/12/22.
//

import Foundation

class CheckInViewModel: ObservableObject {
    @Published var showPicker = false
    @Published var source: ImagePickerFactory.Source = .library
    @Published var cameraError: ImagePickerFactory.CameraErrorType?
    @Published var showCameraAlert = false
    private var checkInServices: CheckInServicesProtocol
    
    init(checkInServices: CheckInServicesProtocol = CheckInServices()) {
        self.checkInServices = checkInServices
    }
    
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
    
    func postCheckIn(lat: String, long: String, tempat: Bool, foto: Data) async {
        do {
            _ = try await checkInServices.postCheckIn(
                endpoint: .postCheckIn(tempat: tempat ? "Diluar Kantor" : "Dikantor", status: "Hadir", long: long, lat: lat, image: foto))
        } catch {
            print("error: ", error)
        }
    }
}
