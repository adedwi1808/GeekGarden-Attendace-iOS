//
//  HomeViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 22/12/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var hadirStats: String = "0"
    @Published var izinStats: String = "0"
    @Published var cutiStats: String = "0"
    @Published var lemburStats: String = "0"
    @Published  var pegawaiInitials: String = ""
    @Published  var pegawaiName: String = ""
    @Published  var pegawaiJabatan: String = ""
    @Published  var pegawaiPhotoProfileURL: String = ""
    
    private let prefs: UserDefaults = UserDefaults()
    private var homeServices: HomeServicesProtocol
    
    init(homeServices: HomeServicesProtocol = HomeServices()) {
        self.homeServices = homeServices
    }
}

//MARK: - Mini Profile & Attendance Stats
extension HomeViewModel {
    func getAttendanceStats() async {
        do {
            let data = try await homeServices.getAttendanceStats(endpoint: .getAttendanceStats)
            saveAttendanceStatsToLocale(data)
        } catch {
            print("err while do login")
        }
    }
    
    func saveAttendanceStatsToLocale(_ data: AttendanceStatsResponseModel) {
        prefs.setDataToLocal(data.self, with: .attendanceStats)
    }
    
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
        self.pegawaiPhotoProfileURL = data.fotoProfile ?? ""
        setPegawaiInitials()
    }
}
//MARK: - Mading
extension HomeViewModel {
    func getMadingGeekGarden() async {
        do {
            let data = try await homeServices.getMadingGeekGarden(endpoint: .getMadingGeekGarden)
            saveMadingGeekGardenLocale(data)
        } catch {
            print("err while do login")
        }
    }
    
    func saveMadingGeekGardenLocale(_ data: MadingGeekGardenModel) {
        prefs.setDataToLocal(data.self, with: .madingGeekGarden)
    }
    
    func getMadingGeekGardenFromLocale() -> MadingGeekGardenModel {
        guard let mading = prefs.getDataFromLocal(MadingGeekGardenModel.self, with: .madingGeekGarden) else { return MadingGeekGardenModel(code: nil, message: nil, data: nil)}
        return mading
    }
}
