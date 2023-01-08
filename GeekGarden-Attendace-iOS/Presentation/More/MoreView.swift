//
//  MoreView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 30/12/22.
//

import AlertToast
import SwiftUI

struct MoreView: View {
    @Environment(\.dismiss) var dismiss
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
                                                 destionation: item.destination)
                        }
                    }
                } header: {
                    Text("Layanan Lainnya")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color("PrimaryColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Button {
                    Task {
                        try await moreVM.signOut()
                    }
                } label: {
                    Text("Sign Out")
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: 180, minHeight: 40)
                        .padding(10)
                        .background(.red)
                        .cornerRadius(10)
                        .shadow(radius: 1, y: 1)
                        .padding(2)
                }
                .padding(.top, 10)
                
            }
            .padding(.horizontal, 15)
            .onAppear {
                moreVM.setMiniProfile()
                moreVM.setAttendanceStatsFromLocale()
            }
            .onChange(of: moreVM.signOutSuccess, perform: { newValue in
                dismiss()e
            })
            .toast(isPresenting: $moreVM.isLoading) {
                AlertToast(type: .loading, title: "Signing Out..")
            }
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}

