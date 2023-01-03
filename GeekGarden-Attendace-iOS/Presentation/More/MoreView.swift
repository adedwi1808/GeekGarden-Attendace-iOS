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
                                      pegawaiJabatan: $moreVM.pegawaiJabatan, pegawaiPhotoProfileURL: $moreVM.pegawaiPhotoProfileURL)
                Section {
                    DataKehadiranPegawaiView(hadir: $moreVM.hadirStats,
                                             izin: $moreVM.izinStats,
                                             lembur: $moreVM.lemburStats,
                                             cuti: $moreVM.cutiStats)
                } header: {
                    Text("Detail Kehadiran Anda")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color("PrimaryColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Section {
                    VStack(spacing: 4) {
                        ForEach(moreVM.destion, id: \.id) { item in
                            CustomMoreButtonView(buttonName: item.buttonName ?? "",
                                                 buttonSymbol: item.buttonSymbol ?? "",
                                                 destionation: Text("Hello World"))
                        }
                    }
                } header: {
                    Text("Layanan Lainnya")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color("PrimaryColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal, 15)
            .onAppear {
                moreVM.setMiniProfile()
                moreVM.setAttendanceStatsFromLocale()
            }
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}

