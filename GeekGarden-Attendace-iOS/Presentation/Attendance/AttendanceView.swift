//
//  AttendanceView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 24/12/22.
//

import SwiftUI
import CoreLocation

struct AttendanceView: View {
    @StateObject var attendanceVM: AttendanceViewModel = AttendanceViewModel()
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                Text(attendanceVM.timeString(date: attendanceVM.date))
                    .font(.system(size: 72, weight: .semibold))
                    .foregroundColor(Color("PrimaryColor"))
                Text(attendanceVM.dateString(date: attendanceVM.date))
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(Color("PrimaryColor"))
                
                if attendanceVM.numberOfAbsencesToday < 1 {
                    NavigationLink(destination: CheckInView(
                        latitude: attendanceVM.latitude,
                        longitude: attendanceVM.longitude,
                        tempat: attendanceVM.tempat
                    )) {
                        AttendanceButtonView()
                    }
                } else {
                    NavigationLink(destination: CheckOutView(
                        latitude: attendanceVM.latitude,
                        longitude: attendanceVM.longitude,
                        tempat: attendanceVM.tempat
                    )) {
                        AttendanceButtonView()
                    }
                }
                
                NavigationLink(destination: MapView()) {
                    HStack {
                        Image(systemName: "mappin")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(height: 24)
                        Text(attendanceVM.reversedGeoCodeLoc)
                            .lineLimit(1)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color("PrimaryColor"))
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)
                }
                
                
                HStack(alignment: .center, spacing: 60) {
                    VStack {
                        Image("CheckInSymbol")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                        Text(attendanceVM.checkInTime)
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
                        Text(attendanceVM.checkOutTime)
                    }
                }
                .font(.system(size: 24))
                .foregroundColor(Color("PrimaryColor"))
                .padding(.top, 20)
            }
        }
        .onAppear {
            attendanceVM.updateTimer
            attendanceVM.getReversedGeoCodeLoc()
            Task {
                await attendanceVM.checkAttendance()
            }
            attendanceVM.checkHowManyAbsentToday()
            attendanceVM.getCheckInTime()
            attendanceVM.getCheckOutTime()
        }
    }
}

struct AttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceView()
    }
}

struct AttendanceButtonView: View {
    var body: some View {
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
}
