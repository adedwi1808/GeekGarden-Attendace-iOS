//
//  CheckInViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 26/12/22.
//

import Foundation

class CheckInViewModel: ObservableObject {
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    @Published var cameraError: Picker.CameraErrorType?
    @Published var showCameraAlert = false
    private var checkInServices: CheckInServicesProtocol
    
    init(checkInServices: CheckInServicesProtocol = CheckInServices()) {
        self.checkInServices = checkInServices
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
    
    func postCheckIn(lat: String, long: String, tempat: Bool, foto: Data) async {
        do {
            let data = try await checkInServices.postCheckIn(
                endpoint: .postCheckIn(tempat: tempat ? "Diluar Kantor" : "Dikantor", status: "Hadir", long: long, lat: lat, image: foto))
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
    }
}
