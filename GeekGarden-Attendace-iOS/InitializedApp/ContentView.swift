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
                } else {
                    LoginView()
                }
            }
        }
        .navigationViewStyle(.stack)
        .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
