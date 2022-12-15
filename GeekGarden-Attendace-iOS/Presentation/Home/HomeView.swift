//
//  HomeView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                Group {
                    HStack {
                        AsyncImage(url: URL(string: "https")) { Image in
                            Image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 80, height: 80)
                        .cornerRadius(50)
                        .padding(.trailing, 5)
                        
                        VStack {
                            Text("asdasda")
                            Text("asdasda")
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                    .background(.blue)
                    .cornerRadius(15)
                }
                .foregroundColor(.white)
            }
            .padding(.horizontal, 15)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
