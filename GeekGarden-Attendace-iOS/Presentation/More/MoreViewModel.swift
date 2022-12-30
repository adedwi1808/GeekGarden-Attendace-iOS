//
//  MoreViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 30/12/22.
//

import Foundation

class MoreViewModel: ObservableObject {
    @Published var hadirStats: String = "0"
    @Published var izinStats: String = "0"
    @Published var cutiStats: String = "0"
    @Published var lemburStats: String = "0"
    @Published  var pegawaiInitials: String = ""
    @Published  var pegawaiName: String = ""
    @Published  var pegawaiJabatan: String = ""
    
    private let prefs: UserDefaults = UserDefaults()
    
    func getDataPegawai() -> DataPegawaiModel {
        guard let dataPegawai = prefs.getDataFromLocal(LoginPegawaiResponseModel.self, with: .dataPegawai) else { return DataPegawaiModel(idPegawai: 0, nama: "-", jenisKelamin: "-", nomorHP: "-", email: "-", jabatan: "-", fotoProfile: "") }
        return dataMapper(data: dataPegawai)
    }
    
    func getPegawaiInitials()  {
        let name = getDataPegawai().nama
        let initials = name?.components(separatedBy: " ") ?? ["", ""]
        var res = [String]()
        for initial in initials {
            res.append(initial.first.map(String.init)!)
        }
        self.pegawaiInitials = res.joined()
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
}
