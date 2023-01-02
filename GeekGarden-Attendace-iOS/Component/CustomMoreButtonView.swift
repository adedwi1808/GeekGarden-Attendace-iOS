//
//  CustomMoreButtonView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 02/01/23.
//

import SwiftUI

struct CustomMoreButtonView<T: View>: View {
    var buttonName: String
    var buttonSymbol: String
    var destionation: T
    var body: some View {
        NavigationLink {
            destionation
        } label: {
            HStack {
                Image(buttonSymbol)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                Text(buttonName)
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(Color("PrimaryColor"))
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(10)
            .background(.white)
            .cornerRadius(10)
            .shadow(radius: 2, y: 1)
            .padding(3)
        }
    }
}

struct CustomMoreButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomMoreButtonView(buttonName: "Custom Button", buttonSymbol: "", destionation: EmptyView())
    }
}
