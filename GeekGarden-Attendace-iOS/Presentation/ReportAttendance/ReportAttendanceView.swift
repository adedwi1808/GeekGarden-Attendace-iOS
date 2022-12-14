//
//  ReportAttendanceView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import AlertToast
import SwiftUI

struct ReportAttendanceView: View {
    @Environment(\.dismiss) var dismiss
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
                        try await reportAttendanceVM.postReportAttendance()
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
        .toast(isPresenting: $reportAttendanceVM.isLoading) {
            AlertToast(type: .loading, title: "Loading")
        }
        .toast(isPresenting: $reportAttendanceVM.showAlert) {
            reportAttendanceVM.reportSuccess ?
            AlertToast(displayMode: .banner(.pop), type: .complete(.green), title: "Success",subTitle: reportAttendanceVM.alertMessage)
            :
            AlertToast(displayMode: .banner(.pop),
                       type: .error(.red),
                       title: "Upss",
                       subTitle: reportAttendanceVM.alertMessage)
        }
        .onChange(of: reportAttendanceVM.reportSuccess) { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                dismiss()
            }
        }
    }
}

struct ReportAttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        ReportAttendanceView()
    }
}
