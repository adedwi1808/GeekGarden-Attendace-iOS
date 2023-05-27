//
//  CheckOutViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 29/12/22.
//

import Foundation

class CheckOutViewModel: ObservableObject {
    @Published var showPicker: Bool = false
    @Published var source: ImagePickerFactory.Source = .library
    @Published var cameraError: ImagePickerFactory.CameraErrorType?
    @Published var showCameraAlert: Bool = false
    @Published var progressPegawai: String = ""
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var attendanceSuccess: Bool = false
    private var checkOutServices: CheckOutServicesProtocol
    
    init(checkOutServices: CheckOutServicesProtocol = CheckOutServices()) {
        self.checkOutServices = checkOutServices
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
    func postCheckOut(long: String, lat: String, tempat: Bool, foto: Data, prog: String) async throws{
            self.isLoading.toggle()
        do {
            let data = try await checkOutServices.postCheckOut(endpoint: .postCheckOut(tempat: tempat ? "Diluar Kantor" : "Dikantor", status: "Pulang", prog: progressPegawai, long: long, lat: lat, image: foto))
                self.alertMessage = data.message ?? ""
                self.isLoading.toggle()
                self.attendanceSuccess.toggle()
                self.showAlert.toggle()
        } catch let err as NetworkError {
                self.alertMessage = err.localizedDescription
                self.isLoading.toggle()
                self.showAlert.toggle()
        }
    }
}
