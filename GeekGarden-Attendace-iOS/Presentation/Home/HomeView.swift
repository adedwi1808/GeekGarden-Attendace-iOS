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
                    MiniProfilPegawaiView()
                        .environmentObject(homeViewModel)
                    
                    Section {
                        DataKehadiranPegawaiView()
                    } header: {
                        Text("Detail Kehadiran Anda")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color("PrimaryColor"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                MadingGeekGardenView()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 350)
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
                await homeViewModel.getMadingGeekGarden()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
