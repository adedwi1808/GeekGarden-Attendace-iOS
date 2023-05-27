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
    @Published var madingData: [MadingGeekGardenModel] = []
    @Published var madingDataOfflineReady: Bool = false
    
    private let prefs: UserDefaults = UserDefaults()
    private var homeServices: HomeServicesProtocol
    
    init(homeServices: HomeServicesProtocol = HomeServices()) {
        self.homeServices = homeServices
    }
}

//MARK: - Mini Profile & Attendance Stats
extension HomeViewModel {
    @MainActor
    func getAttendanceStats() async {
        do {
            let data = try await homeServices.getAttendanceStats(endpoint: .getAttendanceStats)
            saveAttendanceStatsToLocale(data)
        } catch {
            print("err while do get attendance stats")
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
    @MainActor
    func getMadingGeekGarden() async {
        do {
            let data = try await homeServices.getMadingGeekGarden(endpoint: .getMadingGeekGarden)
                self.madingData.append(contentsOf: data.data!)
                self.saveMadingGeekGardenLocale(data)
        } catch {
            print("err while do getmading geek garden")
            print(error.localizedDescription)
        }
    }
    
    func saveMadingGeekGardenLocale(_ data: MadingGeekGardenResponseModel) {
        prefs.setDataToLocal(data.self, with: .madingGeekGarden)
        self.madingDataOfflineReady = true
    }
    
    func getMadingGeekGardenFromLocale() -> MadingGeekGardenResponseModel {
        guard let mading = prefs.getDataFromLocal(MadingGeekGardenResponseModel.self, with: .madingGeekGarden) else { return MadingGeekGardenResponseModel(code: nil, message: nil, data: nil)}
        return mading
    }
}
