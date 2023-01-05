//
//  LoginView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    
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
                
                LoginForm(type: "Email", value: $loginViewModel.email)
                
                LoginForm(type: "Password", value: $loginViewModel.password)
                
                HStack {
                    Text("Lupa Password ?")
                        .foregroundColor(Color("PrimaryColor"))
                    
                    Text("Klik Disini")
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                NavigationLink(destination: TabBarView(), isActive: $loginViewModel.isLoggedIn, label: {EmptyView()})
                
                Button {
                    Task {
                        try await loginViewModel.loginPegawai()
                    }
                } label: {
                    Text("Login")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.all)
                        .frame(maxWidth: .infinity)
                }
                .foregroundColor(.white)
                .background(.green)
                .cornerRadius(15)
                .padding(.horizontal, 20)
            }
            .onAppear {
                loginViewModel.resetLocalStorage()
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
