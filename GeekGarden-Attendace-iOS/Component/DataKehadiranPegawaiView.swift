//
//  DataKehadiranPegawaiView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 19/12/22.
//

import SwiftUI

struct DataKehadiranPegawaiView: View {
    var body: some View {
        HStack {
            ZStack {
                Color(.white)
                    .cornerRadius(15)
                VStack {
                    Text("5")
                        .fontWeight(.bold)
                    Text("Hadir")
                }
            }
            
            ZStack {
                Color(.white)
                    .cornerRadius(15)
                VStack {
                    Text("5")
                        .fontWeight(.bold)
                    Text("Hadir")
                }
            }
            
            ZStack {
                Color(.white)
                    .cornerRadius(15)
                VStack {
                    Text("5")
                        .fontWeight(.bold)
                    Text("Hadir")
                }
            }
            
            ZStack {
                Color(.white)
                    .cornerRadius(15)
                VStack {
                    Text("5")
                        .fontWeight(.bold)
                    Text("Hadir")
                }
            }
        }
        .padding(10)
        .frame(minHeight: 100, maxHeight: 115, alignment: .center)
        .background(Color("PrimaryColor"))
        .cornerRadius(15)
    }
}

struct DataKehadiranPegawaiView_Previews: PreviewProvider {
    static var previews: some View {
        DataKehadiranPegawaiView()
    }
}
