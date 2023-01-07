//
//  MiniProfilPegawai.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 19/12/22.
//

import SwiftUI

struct MiniProfilPegawaiView: View {
    @Binding var pegawaiInitials: String
    @Binding var pegawaiName: String
    @Binding var pegawaiJabatan: String
    @Binding var pegawaiPhotoProfileURL: String
    
    var body: some View {
        NavigationLink(destination: {
            UpdateProfileView()
        }, label: {
            HStack {
                AsyncImage(url: URL(string: "https://\(Constans().baseURL)/storage/pegawai/\(pegawaiPhotoProfileURL)")) { Image in
                    Image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ZStack {
                        Color.white
                        Text(pegawaiInitials)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color("PrimaryColor"))
                    }
                }
                .frame(width: 80, height: 80)
                .cornerRadius(50)
                .padding(.trailing, 5)
                
                VStack(alignment: .leading) {
                    Text(pegawaiName)
                        .font(.system(size: 20, weight: .bold))
                    Text(pegawaiJabatan)
                        .font(.system(size: 20, weight: .medium))
                }
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
            .background(Color("PrimaryColor"))
            .cornerRadius(15)
        })
        .foregroundColor(.white)
    }
}

//struct MiniProfilPegawaiView_Previews: PreviewProvider {
//    static var previews: some View {
//        MiniProfilPegawaiView(pegawaiInitials: "ADEDP", pegawaiName: "Ade Dwi Prayitno", pegawaiJabatan: "Mobile Engineer")
//    }
//}
