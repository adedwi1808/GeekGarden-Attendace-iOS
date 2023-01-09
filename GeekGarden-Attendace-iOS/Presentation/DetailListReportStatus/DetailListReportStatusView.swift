//
//  DetailListReportStatusView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 09/01/23.
//

import SwiftUI

struct DetailListReportStatusView: View {
    
    var reportStatus: ReportAttendanceModel
    
    var body: some View {
        List {
            Section {
                Text(reportStatus.tanggalAbsen ?? "")
            } header: {
                Text("Tanggal Absen")
            }
            
            Section {
                Text(reportStatus.tanggalPengaduan ?? "")
            } header: {
                Text("Tanggal Pengaduan")
            }
            
            Section {
                Text(reportStatus.statusPengaduan ?? "")
            } header: {
                Text("Status Pengaduan")
            }
            
            Section {
                Text(reportStatus.keteranganPengaduan ?? "")

            } header: {
                Text("Keterangan")
            }
            
            if reportStatus.admin != nil {
                Section {
                    Text(reportStatus.keteranganAdmin ?? "")
                } header: {
                    Text("Keterangan Admin")
                }
                
                Section {
                    Text(reportStatus.admin?.nama ?? "")
                } header: {
                    Text("Konfirmator")
                }
            }
        }
        .navigationTitle("Detail Pengaduan Absensi")
    }
}

struct DetailListReportStatusView_Previews: PreviewProvider {
    static var previews: some View {
        DetailListReportStatusView(reportStatus: ReportAttendanceModel(idPengaduanAbsensi: 1, idPegawai: 1, idAdmin: 1, tanggalAbsen: "2022-03-23", keteranganPengaduan: "asdasdasfjn  aksnfjanfjansjfansjkfnaklf jansfjanfjkan sasda", keteranganAdmin: "asdasjdasidjaisjdaiosjda asd asd as das da", tanggalPengaduan: "2022-03-32", statusPengaduan: "qweqweq", admin: AdminModel(idAdmin: 2, nama: "ade", email: "asdasda@gmail.com")))
    }
}
