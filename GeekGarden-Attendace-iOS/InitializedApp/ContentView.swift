//
//  ContentView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import SwiftUI

struct ContentView: View {
    @State var isLoggedIn: Bool = true
    var body: some View {
        NavigationView {
            Group {
                if isLoggedIn {
                    TabBarView()
                        .navigationTitle("GeekGarden Attendance")
                        .navigationBarTitleDisplayMode(.inline)
                } else {
                    Text("LoginView")
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
