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
    
    private var workPermitServices: WorkPermitServicesProtocol
    
    init(workPermitServices: WorkPermitServicesProtocol = WorkPermitServices()) {
        self.workPermitServices = workPermitServices
    }
    
    private var remoteDateFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
    
    func checkForm() -> Bool {
        if permitReasonDec.count > 0 {
            return true
        }
        return false
    }
    
    func postWorkPermit(image: Data?) async {
        
        if checkForm() == false {
            print("check form")
            return
        }
        
        do {
            _ = try await workPermitServices.postWorkPermit(endPoint: .workPermit(jenisIzin: selectedReason.rawValue, tanggalMulai: remoteDateFormat.string(from: permitDateStart), tanggalSelesai: remoteDateFormat.string(from: permitDateEnd), alasanIzin: permitReasonDec, suratIzin: image ?? Data()))
        } catch  {
            print("ERR when post work permit")
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
