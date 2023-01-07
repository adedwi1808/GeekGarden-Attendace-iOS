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
    
    private var remoteDateFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
    
    
    func postWorkPermit(image: Data) async throws{
        DispatchQueue.main.async {
            self.isLoading.toggle()
        }
        
        do {
            _ = try await workPermitServices.postWorkPermit(endPoint: .workPermit(jenisIzin: selectedReason.rawValue, tanggalMulai: remoteDateFormat.string(from: permitDateStart), tanggalSelesai: remoteDateFormat.string(from: permitDateEnd), alasanIzin: permitReasonDec, suratIzin: image))
            DispatchQueue.main.async {
                self.isLoading.toggle()
                self.permitSuccess.toggle()
            }
        } catch let err as NetworkError {
            DispatchQueue.main.async {
                self.alertMessage = err.localizedDescription
                self.isLoading.toggle()
                self.showAlert.toggle()
            }
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
