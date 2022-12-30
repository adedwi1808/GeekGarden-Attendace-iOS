//
//  DataKehadiranPegawaiView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 19/12/22.
//

import SwiftUI

struct DataKehadiranPegawaiView: View {
    @Binding var hadir: String
    @Binding var izin: String
    @Binding var lembur: String
    @Binding var cuti: String
    
    var body: some View {
        HStack {
            ZStack {
                Color(.white)
                    .cornerRadius(15)
                VStack {
                    Text(hadir)
                        .fontWeight(.bold)
                    Text("Hadir")
                }
            }
            
            ZStack {
                Color(.white)
                    .cornerRadius(15)
                VStack {
                    Text(izin)
                        .fontWeight(.bold)
                    Text("Izin")
                }
            }
            
            ZStack {
                Color(.white)
                    .cornerRadius(15)
                VStack {
                    Text(cuti)
                        .fontWeight(.bold)
                    Text("Cuti")
                }
            }
            
            ZStack {
                Color(.white)
                    .cornerRadius(15)
                VStack {
                    Text(lembur)
                        .fontWeight(.bold)
                    Text("Lembur")
                }
            }
        }
        .padding(10)
        .frame(minHeight: 100, maxHeight: 115, alignment: .center)
        .foregroundColor(Color("PrimaryColor"))
        .background(Color("PrimaryColor"))
        .cornerRadius(15)
    }
}

//struct DataKehadiranPegawaiView_Previews: PreviewProvider {
//    static var previews: some View {
//        DataKehadiranPegawaiView(hadir: , izin: "", lembur: "", cuti: "")
//    }
//}
