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
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var updateSuccess: Bool = false
    @Published var updatePhotoProfileSuccess: Bool = false
    
    private var prefs = UserDefaults()
    private var updateProfileServices: UpdateProfileServiceProtocol
    
    init(updateProfileServices: UpdateProfileServiceProtocol = UpdateProfileServices()) {
        self.updateProfileServices = updateProfileServices
    }
    
    func updatePegawaiProfile() {
        if pegawaiPassword.count > 1,
           pegawaiPassword.count < 6 {
            DispatchQueue.main.async {
                self.showAlert.toggle()
                self.alertMessage = "Password not valid"
            }
        } else {
            Task {
                try await postUpdateProfile()
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
    
    func postUpdatePhotoProfile(image: Data) async throws{
        DispatchQueue.main.async {
            self.isLoading.toggle()
        }
        do {
            let data = try await updateProfileServices.updatePegawaiPhotoProfile(endpoint:
                    .updatePegawaiPhotoProfile(image: image))
            saveUpdateData(using: data.data)
            DispatchQueue.main.async {
                self.isLoading.toggle()
                self.updatePhotoProfileSuccess.toggle()
                self.showAlert.toggle()
                self.alertMessage = "Berhasil mengubah foto profil"
            }
        } catch let err as NetworkError {
            DispatchQueue.main.async {
                self.isLoading.toggle()
                self.showAlert.toggle()
                self.alertMessage = err.localizedDescription
            }
        }
    }
    
    func postUpdateProfile() async throws{
        DispatchQueue.main.async {
            self.isLoading.toggle()
        }
        do {
            let data = try await updateProfileServices.updateDataPegawai(endpoint:
                    .updateDataPegawai(email: pegawaiEmail,
                                       noHP: pegawaiPhoneNumber,
                                       password: pegawaiPassword))
            saveUpdateData(using: data.data)
            DispatchQueue.main.async {
                self.isLoading.toggle()
                self.updateSuccess.toggle()
                self.showAlert.toggle()
                self.alertMessage = "Berhasil mengupdate profil"
            }
        } catch let err as NetworkError {
            DispatchQueue.main.async {
                self.isLoading.toggle()
                self.showAlert.toggle()
                self.alertMessage = err.localizedDescription
            }
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
