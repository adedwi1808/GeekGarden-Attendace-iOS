//
//  ContentView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                LoginView()
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
