//
//  HomeViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 22/12/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    private let prefs: UserDefaults = UserDefaults()
    
    private var homeServices: HomeServicesProtocol
    
    init(homeServices: HomeServicesProtocol = HomeServices()) {
        self.homeServices = homeServices
    }
    
    func getDataPegawai() -> DataPegawaiModel {
        guard let dataPegawai = prefs.getDataFromLocal(LoginPegawaiResponseModel.self, with: .dataPegawai) else { return DataPegawaiModel(idPegawai: 0, nama: "-", jenisKelamin: "-", nomorHP: "-", email: "-", jabatan: "-", fotoProfile: "") }
        return dataMapper(data: dataPegawai)
    }
    
    func dataMapper(data: LoginPegawaiResponseModel) -> DataPegawaiModel {
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
    
    func getMadingGeekGarden() async {
        do {
            let data = try await homeServices.getMadingGeekGarden(endpoint: .getMadingGeekGarden)
            print(data)
            
        } catch {
            print("err while do login")
        }
    }
}
