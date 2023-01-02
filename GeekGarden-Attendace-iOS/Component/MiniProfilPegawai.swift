//
//  MiniProfilPegawai.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 19/12/22.
//

import SwiftUI

struct MiniProfilPegawaiView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Binding var pegawaiInitials: String
    @Binding var pegawaiName: String
    @Binding var pegawaiJabatan: String
    
    var body: some View {
        NavigationLink(destination: {
            UpdateProfileView()
        }, label: {
            HStack {
                AsyncImage(url: URL(string: "https")) { Image in
                    Image
                        .resizable()
                        .scaledToFit()
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
//        MiniProfilPegawaiView()
//    }
//}
