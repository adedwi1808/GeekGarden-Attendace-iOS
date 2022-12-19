//
//  MadingGeekGardenView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 19/12/22.
//

import SwiftUI

struct MadingGeekGardenView: View {
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: "")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray
            }
            .frame(height: 140)
            .cornerRadius(15)
            
            Color.gray
                .frame(height: 1)
                .padding(.horizontal, 5)
            
            Text("Judul Mading")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad")
                .lineLimit(3)
            
            HStack {
                Image(systemName: "clock")
                Text("15 Desember 2022")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.gray)
        }
        .padding(15)
        .background(.white)
        .cornerRadius(15)
        .frame(width: 320, height: 340)
        .shadow(radius: 2, x: 5, y: 3)
    }
}

struct MadingGeekGardenView_Previews: PreviewProvider {
    static var previews: some View {
        MadingGeekGardenView()
    }
}
