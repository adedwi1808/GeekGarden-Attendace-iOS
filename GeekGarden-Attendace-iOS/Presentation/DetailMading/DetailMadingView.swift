//
//  DetailMadingView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 09/01/23.
//

import SwiftUI

struct DetailMadingView: View {
    
    var mading: MadingGeekGardenModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: "https://\(Constans().baseURL)/storage/public/mading/\(mading.foto ?? "")")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 355, height: 240)
                .cornerRadius(8)
                
                Color.gray
                    .frame(height: 1)
                    .padding(.horizontal, 15)
                
                Text(mading.judul ?? "")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                Text(mading.informasi ?? "")
                
                Spacer()
                HStack {
                    Image(systemName: "clock")
                    Text(mading.createAt ?? "")
                        .font(.system(size: 18))
                }
//                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.gray)
            }
            .padding(15)
        }
        .background(.white)
    }
}

struct DetailMadingView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMadingView(mading: MadingGeekGardenModel(idMading: 1,
                                                       idAdmin: 1,
                                                       judul: "Perpisahan Peserta Magang Ade DP",
                                                       informasi: "Sesungguhnya, perihnya perpisahan tidaklah seberapa dibanding dengan bahagianya pertemuan. Apalagi pertemuan baru setelah perpisahan itu.",
                                                       foto: "1403280_72428469_709727936183540_5779971284881339048_n.jpg",
                                                       createAt: "2022-08-24 14:36:03"))
    }
}
