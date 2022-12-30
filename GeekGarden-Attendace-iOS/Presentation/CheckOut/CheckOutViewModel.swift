//
//  CheckOutViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 29/12/22.
//

import Foundation

class CheckOutViewModel: ObservableObject {
    @Published var showPicker: Bool = false
    @Published var source: Picker.Source = .library
    @Published var cameraError: Picker.CameraErrorType?
    @Published var showCameraAlert: Bool = false
    @Published var progressPegawai: String = ""
    private var checkOutServices: CheckOutServicesProtocol
    
    init(checkOutServices: CheckOutServicesProtocol = CheckOutServices()) {
        self.checkOutServices = checkOutServices
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
    
    func postCheckOut(long: String, lat: String, tempat: Bool, foto: Data, prog: String) async {
        do {
            let data = try await checkOutServices.postCheckOut(endpoint: .postCheckOut(tempat: tempat ? "Diluar Kantor" : "Dikantor", status: "Pulang", prog: progressPegawai, long: long, lat: lat, image: foto))
        } catch  {
            print("Checkout ERR: \(error)")
        }
    }
}
