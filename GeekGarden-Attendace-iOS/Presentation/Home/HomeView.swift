//
//  HomeView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    MiniProfilPegawaiView(pegawaiInitials: $homeViewModel.pegawaiInitials,
                                          pegawaiName: $homeViewModel.pegawaiName,
                                          pegawaiJabatan: $homeViewModel.pegawaiJabatan, pegawaiPhotoProfileURL:$homeViewModel.pegawaiPhotoProfileURL)
                    
                    Section {
                        DataKehadiranPegawaiView(hadir: $homeViewModel.hadirStats,
                                                 izin: $homeViewModel.izinStats,
                                                 lembur: $homeViewModel.lemburStats,
                                                 cuti: $homeViewModel.cutiStats)
                    } header: {
                        Text("Detail Kehadiran Anda")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color("PrimaryColor"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                if homeViewModel.madingDataOfflineReady {
                                    ForEach(homeViewModel.getMadingGeekGardenFromLocale().data!, id: \.idMading) { mading in
                                        NavigationLink {
                                            DetailMadingView(mading: mading)
                                        } label: {
                                            MadingGeekGardenView(
                                                judulMading: mading.judul ?? "",
                                                isiMading: mading.informasi ?? "",
                                                fotoMading: mading.foto ?? "", tanggalMading: mading.createAt ?? "")
                                        }
                                        .tint(.black)
                                    }
                                } else {
                                    ForEach(homeViewModel.madingData, id: \.idMading) { mading in
                                        NavigationLink {
                                            DetailMadingView(mading: mading)
                                        } label: {
                                            MadingGeekGardenView(
                                                judulMading: mading.judul ?? "",
                                                isiMading: mading.informasi ?? "",
                                                fotoMading: mading.foto ?? "", tanggalMading: mading.createAt ?? "")
                                        }
                                        .tint(.black)
                                    }
                                }
                            }
                        }
                    } header: {
                        Text("Mading GeekGarden")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color("PrimaryColor"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                }
                .padding(.horizontal, 15)
            }
        }
        .onAppear {
            Task {
                if !homeViewModel.madingDataOfflineReady {
                    await homeViewModel.getMadingGeekGarden()
                }
                await homeViewModel.getAttendanceStats()
            }
            homeViewModel.setAttendanceStatsFromLocale()
            homeViewModel.setMiniProfile()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
