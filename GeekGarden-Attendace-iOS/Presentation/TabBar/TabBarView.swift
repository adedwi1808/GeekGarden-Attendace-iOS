//
//  TabBarView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import SwiftUI
import CoreLocation

struct TabBarView: View {
    init() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("PrimaryColor"))]

            //Use this if NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("PrimaryColor"))]
        }

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
            
            AttendanceView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.clipboard.fill")
                        Text("Attendance")
                    }
                }
            
            HistoryView()
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
