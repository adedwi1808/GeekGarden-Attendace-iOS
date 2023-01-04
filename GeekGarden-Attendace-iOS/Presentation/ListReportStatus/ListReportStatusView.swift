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
        ScrollView(.vertical) {
            ForEach(listReportStatusVM.reportStatusData, id: \.idPengaduanAbsensi) { item in
                Text(item.statusPengaduan)
            }
        }
        .onAppear {
            Task {
                await listReportStatusVM.getReportStatusData()
            }
        }
    }
}

struct ListReportStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ListReportStatusView()
    }
}
