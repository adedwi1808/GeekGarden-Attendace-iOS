//
//  UpdateProfileViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 02/01/23.
//

import Foundation

class UpdateProfileViewModel: ObservableObject {
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    @Published var cameraError: Picker.CameraErrorType?
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
    
    func setUserDataBefore() {
        let data = getDataPegawai()
        setPegawaiInitials()
        self.pegawaiName = data.nama ?? ""
        self.pegawaiEmail = data.email ?? ""
        self.pegawaiPhoneNumber = data.nomorHP ?? ""
        self.pegawaiPhotoProfileURL = data.fotoProfile ?? ""
    }
    
    private func getDataPegawai() -> DataPegawaiModel {
        guard let dataPegawai = prefs.getDataFromLocal(LoginPegawaiResponseModel.self, with: .dataPegawai) else { return DataPegawaiModel(idPegawai: 0, nama: "-", jenisKelamin: "-", nomorHP: "-", email: "-", jabatan: "-", fotoProfile: "") }
        return dataMapper(data: dataPegawai)
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
    
    private func dataMapper(data: LoginPegawaiResponseModel)  -> DataPegawaiModel{
        let res: DataPegawaiModel = DataPegawaiModel(
            idPegawai: data.data?.idPegawai,
            nama: data.data?.nama,
            jenisKelamin: data.data?.jenisKelamin,
            nomorHP: data.data?.nomorHP,
            email: data.data?.email,
            jabatan: data.data?.jabatan,
            fotoProfile: data.data?.fotoProfile)
        return res
    }
}
