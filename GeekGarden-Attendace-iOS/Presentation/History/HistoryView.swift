//
//  HistoryView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 29/12/22.
//

import SwiftUI

struct HistoryView: View {
    @StateObject private var historyVM: HistoryViewModel = HistoryViewModel()
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    ForEach(historyVM.attendanceHistory, id: \.idAbsensi) { item in
                        AttendanceHistoryItemView(date: historyVM.dateStringToDay(item.tanggal ?? ""),
                                                  month: historyVM.dateStringToMonth(item.tanggal ?? ""),
                                                  status: item.status ?? "",
                                                  time: historyVM.dateStringToTime(item.tanggal ?? ""),
                                                  attendancePlace: item.tempat ?? "")
                    }
                }
                
            }
            .onAppear {
                if !historyVM.isLoaded {
                    Task {
                        await historyVM.getAttendanceHistory()
                    }
                } else {
                    historyVM.setAttendanceHistoryData()
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

