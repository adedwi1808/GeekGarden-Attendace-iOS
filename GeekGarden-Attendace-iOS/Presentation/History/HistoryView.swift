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
                        HStack(alignment: .center) {
                            VStack {
                                Text(historyVM.dateStringToDay(item.tanggal ?? ""))
                                Text(historyVM.dateStringToMonth(item.tanggal ?? "")
                                    .prefix(3))
                            }
                            .fontWeight(.semibold)
                            .padding(5)
                            .frame(width: 50)
                            .background(.white)
                            .foregroundColor(Color("PrimaryColor"))
                            .cornerRadius(10)
                            
                            Text(item.status ?? "")
                                .frame(width: 60)
                                .foregroundColor(.gray)
                            
                            Text(historyVM.dateStringToTime(item.tanggal ?? ""))
                                .frame(width: 50)
                                .foregroundColor(.gray)
                            
                            Text(item.tempat ?? "")
                                .frame(width: 150)
                                .foregroundColor(.gray)
                        }
                        .padding(5)
                        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                        .background(Color("SecondaryColor"))
                        Color(.gray)
                            .frame(height: 1)
                    }
                }
                
            }
            .onAppear {
                Task {
                    await historyVM.getAttendanceHistory()
                }
                historyVM.setAttendanceHistoryData()
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
