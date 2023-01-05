//
//  UpdateProfileViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 02/01/23.
//

import Foundation

class UpdateProfileViewModel: ObservableObject {
    @Published var showPicker = false
    @Published var source: ImagePickerFactory.Source = .library
    @Published var cameraError: ImagePickerFactory.CameraErrorType?
    @Published var showCameraAlert = false
    @Published var pegawaiName: String = ""
    @Published var pegawaiInitials: String = ""
    @Published var pegawaiEmail: String = ""
    @Published var pegawaiPhoneNumber: String = ""
    @Published var pegawaiPassword: String = ""
    @Published var pegawaiPhotoProfileURL: String = ""
    
    private var prefs = UserDefaults()
    private var updateProfileServices: UpdateProfileServiceProtocol
    
    init(updateProfileServices: UpdateProfileServiceProtocol = UpdateProfileServices()) {
        self.updateProfileServices = updateProfileServices
    }
    
    func updatePegawaiProfile() {
        if pegawaiEmail.count > 6, pegawaiPhoneNumber.count > 10 {
            if pegawaiPassword.count > 1,
               pegawaiPassword.count < 6 {
            } else {
                Task {
                    try await postUpdateProfile()
                }
            }
        }
        print("form not valid")
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
    
    func postUpdatePhotoProfile(image: Data) async {
        do {
            let data = try await updateProfileServices.updatePegawaiPhotoProfile(endpoint:
                    .updatePegawaiPhotoProfile(image: image))
            saveUpdateData(using: data.data)
        } catch {
            print("ERR while post update profile")
        }
    }
    
    func postUpdateProfile() async throws{
        do {
            let data = try await updateProfileServices.updateDataPegawai(endpoint:
                    .updateDataPegawai(email: pegawaiEmail,
                                       noHP: pegawaiPhoneNumber,
                                       password: pegawaiPassword))
            saveUpdateData(using: data.data)
        } catch let err as NetworkError {
            print(err.localizedDescription)
        }
    }
    
    func saveUpdateData(using data: DataPegawaiModel) {
        DispatchQueue.main.async {
            self.prefs.setDataToLocal(data.self, with: .dataPegawai)
        }
    }

}

//MARK: - Setup Data
extension UpdateProfileViewModel {
    func setUserDataBefore() {
        let data = getDataPegawai()
        setPegawaiInitials()
        self.pegawaiName = data.nama ?? ""
        self.pegawaiEmail = data.email ?? ""
        self.pegawaiPhoneNumber = data.nomorHP ?? ""
        self.pegawaiPhotoProfileURL = data.fotoProfile ?? ""
    }
    
    private func getDataPegawai() -> DataPegawaiModel {
        guard let dataPegawai = prefs.getDataFromLocal(DataPegawaiModel.self, with: .dataPegawai) else { return DataPegawaiModel(idPegawai: 0, nama: "-", jenisKelamin: "-", nomorHP: "-", email: "-", jabatan: "-", fotoProfile: "") }
        return dataPegawai
    }
    
    private func setPegawaiInitials() {
        let name = getDataPegawai().nama
        let initials = name?.components(separatedBy: " ") ?? ["", ""]
        var res = [String]()
        for initial in initials {
            res.append(initial.first.map(String.init)!)
        }
        self.pegawaiInitials = res.joined()
    }

}
