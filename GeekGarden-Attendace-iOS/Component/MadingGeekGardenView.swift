//
//  MadingGeekGardenView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 19/12/22.
//

import SwiftUI

struct MadingGeekGardenView: View {
    let judulMading: String
    let isiMading: String
    let fotoMading: String
    let tanggalMading: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: "https://4aa3-182-253-183-10.ap.ngrok.io/storage/mading/\(fotoMading)")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(height: 120)
            .cornerRadius(8)
            
            Color.gray
                .frame(height: 1)
                .padding(.horizontal, 5)
            
            Text(judulMading)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .lineLimit(1)
                .frame(height: 25, alignment: .leading)
            Text(isiMading)
                .lineLimit(3)
                .frame(height: 70, alignment: .topLeading)
            
            Spacer()
            HStack {
                Image(systemName: "clock")
                Text(tanggalMading)
                    .font(.system(size: 14))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.gray)
        }
        .frame(width: 300, height: 290)
        .padding(15)
        .background(.white)
        .cornerRadius(15)
        .shadow(radius: 2, x: 5, y: 3)
        .padding(5)
    }
}

struct MadingGeekGardenView_Previews: PreviewProvider {
    static var previews: some View {
        MadingGeekGardenView(judulMading: "Judul Mading", isiMading: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", fotoMading: "", tanggalMading: "asdasda")
    }
}
