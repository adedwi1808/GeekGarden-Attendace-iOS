//
//  ContentView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navigationViewModel: NavigationViewModel = NavigationViewModel()
    var body: some View {
        NavigationView {
            Group {
                if navigationViewModel.getUserLoginStatus() {
                    TabBarView()
                        .navigationTitle("GeekGarden Attendance")
                        .navigationBarTitleDisplayMode(.inline)
                } else {
                    LoginView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
