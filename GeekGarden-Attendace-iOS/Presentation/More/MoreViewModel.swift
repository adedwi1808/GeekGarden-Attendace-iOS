//
//  MoreViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 30/12/22.
//

import Foundation
import SwiftUI

class MoreViewModel: ObservableObject {
    @Published var hadirStats: String = "0"
    @Published var izinStats: String = "0"
    @Published var cutiStats: String = "0"
    @Published var lemburStats: String = "0"
    @Published var pegawaiInitials: String = ""
    @Published var pegawaiName: String = ""
    @Published var pegawaiJabatan: String = ""
    @Published var pegawaiPhotoProfileURL: String = ""
    
    @Published var isLoading: Bool = false
    @Published var signOutSuccess: Bool = false
    
    private let prefs: UserDefaults = UserDefaults()
    private var moreServices: MoreServicesProtocol
    var destion: [CustomMoreButtonModel] = [
        CustomMoreButtonModel(buttonName: "Pengajuan Izin",
                              buttonSymbol: "TaskAddSymbol",
                              destination: AnyView(WorkPermitView())),
        
        CustomMoreButtonModel(buttonName: "Pengaduan Absensi",
                              buttonSymbol: "TaskReportSymbol",
                              destination: AnyView(ReportAttendanceView())),
        
        CustomMoreButtonModel(buttonName: "Status Pengajuan Izin",
                              
                              buttonSymbol: "TaskHistorySymbol",
                              destination: AnyView(ListWorkPermitStatusView())),
        CustomMoreButtonModel(buttonName: "Status Pengaduan",
                              buttonSymbol: "TaskRepairSymbol",
                              destination: AnyView(ListReportStatusView()))]
    
    init(moreServices: MoreServicesProtocol = MoreServices()) {
        self.moreServices = moreServices
    }
        
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

//MARK: - Custom Button
extension MoreViewModel {
    func signOut() async throws {
        DispatchQueue.main.async {
            self.isLoading.toggle()
        }
        do {
            try await moreServices.signOut(endpoint: .signOut)
            DispatchQueue.main.async {
                self.isLoading.toggle()
                self.signOutSuccess.toggle()
            }
        } catch let err as NetworkError {
            DispatchQueue.main.async {
                self.isLoading.toggle()
            }
            print(err)
        }
    }
}
