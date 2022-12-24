//
//  AttendanceView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 24/12/22.
//

import SwiftUI

struct AttendanceView: View {
    @StateObject var attendanceViewModel: AttendanceViewModel = AttendanceViewModel()
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                Text(attendanceViewModel.timeString(date: attendanceViewModel.date))
                    .font(.system(size: 72, weight: .semibold))
                    .foregroundColor(Color("PrimaryColor"))
                Text(attendanceViewModel.dateString(date: attendanceViewModel.date))
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(Color("PrimaryColor"))
                
                NavigationLink(destination: CheckInView()) {
                    ZStack {
                        Circle()
                            .foregroundColor(.green)
                            .shadow(radius: 5)
                            .padding(5)
                        Image("touchSymbol")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.6)
                    }
                    .frame(height: 300)
                    .padding(.vertical, 20)
                }
                
                
                HStack {
                    Image(systemName: "mappin")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red)
                        .frame(height: 24)
                    Text("GeekGarden Office")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color("PrimaryColor"))
                }
                .padding(.bottom, 20)
                
                HStack(alignment: .center, spacing: 60) {
                    VStack {
                        Image("CheckInSymbol")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                        Text("22.0")
                    }
                    
                    VStack {
                        Image("WorkIntervalSymbol")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                        Text("22.0")
                    }
                    
                    VStack {
                        Image("CheckOutSymbol")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                        Text("22.0")
                    }
                }
                .font(.system(size: 24))
                .foregroundColor(Color("PrimaryColor"))
                .padding(.top, 20)
            }
        }
        .onAppear {
            attendanceViewModel.updateTimer
        }

    }
}

struct AttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceView()
    }
}
