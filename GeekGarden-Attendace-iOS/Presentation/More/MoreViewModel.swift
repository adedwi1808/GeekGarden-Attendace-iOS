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
    @Published var pegawaiInitials: String = ""
    @Published var pegawaiName: String = ""
    @Published var pegawaiJabatan: String = ""
    var destion: [CustomMoreButtonModel] = [
        CustomMoreButtonModel(buttonName: "Pengajuan Izin", buttonSymbol: "TaskAddSymbol"),
        CustomMoreButtonModel(buttonName: "Pengaduan Absensi", buttonSymbol: "TaskReportSymbol"),
        CustomMoreButtonModel(buttonName: "Status Pengajuan Izin", buttonSymbol: "TaskHistorySymbol"),
        CustomMoreButtonModel(buttonName: "Status Pengaduan", buttonSymbol: "TaskRepairSymbol")]
    
    private let prefs: UserDefaults = UserDefaults()
        
}

//MARK: - Mini Profile & Attendance Stats
extension MoreViewModel {
    func setAttendanceStatsFromLocale() {
        guard let data = prefs.getDataFromLocal(AttendanceStatsResponseModel.self, with: .attendanceStats)?.data else {return}
        self.cutiStats = "\(data.cuti ?? 0)"
        self.hadirStats = "\(data.hadir ?? 0)"
        self.lemburStats = "\(data.lembur ?? 0)"
        self.izinStats = "\(data.izin ?? 0)"
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
    
    func setMiniProfile() {
        let data = getDataPegawai()
        self.pegawaiName = data.nama ?? ""
        self.pegawaiJabatan = data.jabatan ?? ""
        setPegawaiInitials()
    }
}

//MARK: - Custom Button
extension MoreViewModel {
    func destionView(name: String) {
        
    }
}
