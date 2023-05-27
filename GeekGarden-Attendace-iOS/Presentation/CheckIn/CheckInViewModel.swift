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
    @Published var showCameraAlert: Bool = false
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    @Published var alertMessage: String = ""
    @Published var attendanceSuccess: Bool = false
    
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
    
    @MainActor
    func postCheckIn(lat: String, long: String, tempat: Bool, foto: Data) async throws{
            self.isLoading.toggle()
        do {
            let data = try await checkInServices.postCheckIn(
                endpoint: .postCheckIn(tempat: tempat ? "Diluar Kantor" : "Dikantor", status: "Hadir", long: long, lat: lat, image: foto))
                self.isLoading.toggle()
                self.attendanceSuccess.toggle()
                self.showAlert.toggle()
                self.alertMessage = data.message
        } catch let err as NetworkError {
                self.isLoading.toggle()
                self.showAlert.toggle()
                self.alertMessage = err.localizedDescription
        }
    }
}
