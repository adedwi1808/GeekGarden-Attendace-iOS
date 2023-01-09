//
//  ListWorkPermitStatusView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import SwiftUI

struct ListWorkPermitStatusView: View {
    @StateObject private var listWorkPermitVM: ListWorkPermitStatusViewModel = ListWorkPermitStatusViewModel()
    var body: some View {
        ZStack(alignment: .top) {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                ForEach(listWorkPermitVM.workPermitData, id: \.idPengajuanIzin) { item in
                    NavigationLink {
                        DetaiListWorkPermitView(workPermit: item)
                    } label: {
                        WorkPermitStatusItemView(date: listWorkPermitVM.dateStringToDay(item.tanggalMengajukanIzin),
                                                 month: listWorkPermitVM.dateStringToMonth(item.tanggalMengajukanIzin),
                                                 status: item.statusIzin,
                                                 permitStart: listWorkPermitVM.dateStringToDateOnly(item.tanggalMulaiIzin),
                                                 permitEnd: listWorkPermitVM.dateStringToDateOnly(item.tanggalSelesaiIzin),
                                                 permitReason: item.jenisIzin,
                                                 adminName: item.admin?.nama ?? "-")
                    }
                }
            }
            .onAppear {
                Task {
                    await listWorkPermitVM.getListWorkPermitStatus()
                }
        }
        }
        .navigationTitle("Pengajuan Izin")
    }
}

struct ListWorkPermitStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ListWorkPermitStatusView()
    }
}
