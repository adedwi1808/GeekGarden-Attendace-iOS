//
//  MoreView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 30/12/22.
//

import SwiftUI

struct MoreView: View {
    @StateObject private var moreVM: MoreViewModel = MoreViewModel()
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                MiniProfilPegawaiView(pegawaiInitials: $moreVM.pegawaiInitials,
                                      pegawaiName: $moreVM.pegawaiName,
                                      pegawaiJabatan: $moreVM.pegawaiJabatan)
                    .environmentObject(moreVM)
                DataKehadiranPegawaiView(hadir: $moreVM.hadirStats,
                                         izin: $moreVM.izinStats,
                                         lembur: $moreVM.lemburStats,
                                         cuti: $moreVM.cutiStats)
            }
            .padding(.horizontal, 15)
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
