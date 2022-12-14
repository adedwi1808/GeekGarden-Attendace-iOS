//
//  LoginView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Image("LoginVector")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth:  .infinity)
                
                Text("Login")
                    .font(.system(size: 45, weight: .black))
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .foregroundColor(Color("PrimaryColor"))
                
                HStack {
                    Image(systemName: "envelope")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("PrimaryColor"))
                    VStack {
                        TextField("Email", text: $email)
                        Color("PrimaryColor")
                            .frame(height: 2)
                    }
                }
                
                HStack {
                    Image(systemName: "lock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("PrimaryColor"))
                    VStack {
                        TextField("Password", text: $password)
                        Color("PrimaryColor")
                            .frame(height: 2)
                    }
                }
                HStack {
                    Text("Lupa Password ?")
                        .foregroundColor(Color("PrimaryColor"))
                    
                    Text("Klik Disini")
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button {
                    //
                } label: {
                    Text("Login")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.all)
                        .frame(maxWidth: .infinity)
                }
                .foregroundColor(.white)
                .background(.green)
                .cornerRadius(15)

            }
            .padding(15)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
