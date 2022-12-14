//
//  TabBarView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
            
            Text("Attendance")
                .tabItem {
                    VStack {
                        Image(systemName: "list.clipboard.fill")
                        Text("Attendance")
                    }
                }
            
            Text("History")
                .tabItem {
                    VStack {
                        Image(systemName: "clock.fill")
                        Text("History")
                    }
                }
            
            Text("More")
                .tabItem {
                    VStack {
                        Image(systemName: "line.3.horizontal")
                        Text("More")
                    }
                }
        }
        .navigationTitle("GeekGarden Attendance")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
