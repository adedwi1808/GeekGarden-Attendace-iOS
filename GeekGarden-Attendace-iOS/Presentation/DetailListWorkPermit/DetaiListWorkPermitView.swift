//
//  DetaiListWorkPermitView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 09/01/23.
//

import SwiftUI

struct DetaiListWorkPermitView: View {
    var workPermit: WorkPermitModel
    var body: some View {
        List {
            Section {
                Text(workPermit.jenisIzin)
            } header: {
                Text("Jenis Izin :")
            }
            
            Section {
                Text(workPermit.statusIzin)
            } header: {
                Text("Status Izin")
            }
            
            Section {
                Text(workPermit.tanggalMengajukanIzin)
            } header: {
                Text("Tanggal Pengajuan")
            }
            
            Section {
                Text(workPermit.tanggalMulaiIzin)
                Text(workPermit.tanggalSelesaiIzin)
            } header: {
                Text("Tanggal Izin")
            }
            
            Section {
                Text(workPermit.alasanIzin)

            } header: {
                Text("Alasan Izin")
            }
            
            if workPermit.admin != nil {
                Section {
                    Text(workPermit.keteranganAdmin ?? "")
                } header: {
                    Text("Keterangan Admin")
                }
                
                Section {
                    Text(workPermit.admin?.nama ?? "")
                } header: {
                    Text("Konfirmator")
                }
            }
        }
        .navigationTitle("Detail Pengajuan Izin")
    }
}

struct DetaiListWorkPermitView_Previews: PreviewProvider {
    static var previews: some View {
        DetaiListWorkPermitView(workPermit: WorkPermitModel(idPengajuanIzin: 1,
                                                            idPegawai: 1,
                                                            idAdmin: 1,
                                                            jenisIzin: "Sakit",
                                                            tanggalMulaiIzin: "2022-14-22",
                                                            tanggalSelesaiIzin: "2022-14-22", alasanIzin: "sdafsdfasdfasdfasdfasdfasdfsadfasdfasdfsadfasdfsadfasdfsadfasdfasdfsadfasdfasdfasdfasdfasdfasdfasdsdafsdfasdfasdfasdfasdfasdfsadfasdfasdfsadfasdfsadfasdfsadfasdfasdfsadfasdfasdfasdfasdfasdfasdfasdsdafsdfasdfasdfasdfasdfasdfsadfasdfasdfsadfasdfsadfasdfsadfasdfasdfsadfasdfasdfasdfasdfasdfasdfasd",
                                                            keteranganAdmin: "",
                                                            suratIzin: "",
                                                            statusIzin: "Diajukan",
                                                            tanggalMengajukanIzin: "",
                                                            admin: AdminModel(idAdmin: 1,
                                                                              nama: "Ade",
                                                                              email: "adedwip1808@gmial.com")))
    }
}
