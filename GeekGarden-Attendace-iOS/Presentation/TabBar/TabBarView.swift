//
//  TabBarView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import SwiftUI
import CoreLocation

struct TabBarView: View {
    
    @State var selectedTab: Tab = .home
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("PrimaryColor"))]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("PrimaryColor"))]
        
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                .tag(Tab.home)
            
            AttendanceView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.clipboard.fill")
                        Text("Attendance")
                    }
                }
                .tag(Tab.attendance)
            
            HistoryView()
                .tabItem {
                    VStack {
                        Image(systemName: "clock.fill")
                        Text("History")
                    }
                }
                .tag(Tab.history)
            
            MoreView()
                .tabItem {
                    VStack {
                        Image(systemName: "line.3.horizontal")
                        Text("More")
                    }
                }
                .tag(Tab.more)
        }
        .onAppear {
            LocationManager.shared.getLocation { (location:CLLocation?, error:NSError?) in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let location = location else {
                    return
                }
                print("Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude)")
            }
        }
        .navigationTitle(selectedTab.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .tint(Color("PrimaryColor"))
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

extension TabBarView {
    enum Tab: String {
        case home = "Home"
        case attendance = "Attendance"
        case history = "History"
        case more = "More"
    }
}
