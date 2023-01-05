//
//  ListReportStatusView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import SwiftUI

struct ListReportStatusView: View {
    @StateObject private var listReportStatusVM: ListReportStatusViewModel = ListReportStatusViewModel()
    var body: some View {
        ZStack(alignment: .top) {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            
            ScrollView(.vertical) {
                ForEach(listReportStatusVM.reportStatusData, id: \.idPengaduanAbsensi) { item in
                    ReportStatusItemView(date: listReportStatusVM.dateStringToDay(item.tanggalPengaduan ?? ""),
                                         month: listReportStatusVM.dateStringToMonth(item.tanggalPengaduan ?? ""),
                                         status: item.statusPengaduan ?? "",
                                         fullDate: listReportStatusVM.dateStringToDateOnly(item.tanggalAbsen ?? ""),
                                         adminName: item.admin?.nama ?? "-")
                }
            }
        }
        .onAppear {
            Task {
                await listReportStatusVM.getReportStatusData()
            }
            listReportStatusVM.getReportStatusDataFromLocale()
        }
        .navigationTitle("Pengaduan Absensi")
    }
}

struct ListReportStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ListReportStatusView()
    }
}
