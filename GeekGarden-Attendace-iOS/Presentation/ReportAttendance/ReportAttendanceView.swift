//
//  ReportAttendanceView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import SwiftUI

struct ReportAttendanceView: View {
    
    @StateObject private var reportAttendanceVM: ReportAttendanceViewModel = ReportAttendanceViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                List {
                    Section {
                        DatePicker("Tanggal", selection: $reportAttendanceVM.attendanceDate, displayedComponents: .date)

                    } header: {
                        Text("Tanggal Yang Dilaporkan")
                            .foregroundColor(.white)
                    }
                    
                    Section {
                        TextField("Keterangan", text: $reportAttendanceVM.reportDec, axis: .vertical)
                            .lineLimit(3, reservesSpace: true)
                    } header: {
                        Text("Keterangan")
                            .foregroundColor(.white)
                    }
                    
                }
                .frame(maxHeight: 250)
                .background(Color("PrimaryColor"))
                .scrollContentBackground(.hidden)
                .cornerRadius(20)
                .scrollDisabled(true)
                
                Spacer()
                Button {
                    Task {
                        await reportAttendanceVM.postReportAttendance()
                    }
                } label: {
                    Text("Submit")
                        .font(.system(size: 23, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: 200, height: 60)
                .background(.yellow)
                .cornerRadius(20)
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 15)
        }
        .navigationTitle("Form Mengadukan Absensi")
    }
}

struct ReportAttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        ReportAttendanceView()
    }
}
