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
    
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var permitSuccess: Bool = false
    
    private var workPermitServices: WorkPermitServicesProtocol
    
    init(workPermitServices: WorkPermitServicesProtocol = WorkPermitServices()) {
        self.workPermitServices = workPermitServices
    }
    
    @MainActor
    func postWorkPermit(image: Data) async throws{
            self.isLoading.toggle()
        
        do {
            let data = try await workPermitServices
                .postWorkPermit(endPoint: .workPermit(jenisIzin: selectedReason.rawValue,
                                                      tanggalMulai: DateFormatter.dateTimeFormat.string(from: permitDateStart),
                                                      tanggalSelesai: DateFormatter.dateTimeFormat.string(from: permitDateEnd),
                                                      alasanIzin: permitReasonDec, suratIzin: image))
                self.alertMessage = data.message
                self.isLoading.toggle()
                self.showAlert.toggle()
                self.permitSuccess.toggle()
        } catch let err as NetworkError {
                self.alertMessage = err.localizedDescription
                self.isLoading.toggle()
                self.showAlert.toggle()
        }
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
}
