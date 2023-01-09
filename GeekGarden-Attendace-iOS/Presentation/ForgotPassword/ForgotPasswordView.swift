//
//  ForgotPasswordView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 09/01/23.
//

import AlertToast
import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var forgotPasswordVM: ForgotPasswordViewModel = ForgotPasswordViewModel()
    
    var body: some View {
        ZStack(alignment: .center) {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                Image("ForgotPasswordVector")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.9)
                    .frame(maxWidth:  .infinity)
                
                Text("Lupa Password")
                    .font(.system(size: 34, weight: .black))
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .foregroundColor(Color("PrimaryColor"))
                
                Text("Silahkan isi email akun anda")
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("PrimaryColor"))
                
                LoginForm(type: "Email", value: $forgotPasswordVM.email)
                
                
                Button {
                    Task {
                        try await forgotPasswordVM.postForgotPasswordRequest()
                    }
                } label: {
                    Text("Submit")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.all)
                        .frame(maxWidth: .infinity)
                }
                .foregroundColor(.white)
                .background(.green)
                .cornerRadius(15)
                .padding(.top, 15)
                .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity)
            .padding(15)
            .onChange(of: forgotPasswordVM.submitSuccess) {newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    dismiss()
                }
            }
            .toast(isPresenting: $forgotPasswordVM.isLoading) {
                AlertToast(type: .loading, title: "Loading")
            }
            .toast(isPresenting: $forgotPasswordVM.showAlert) {
                forgotPasswordVM.submitSuccess ?
                AlertToast(displayMode: .banner(.pop), type: .complete(.green), title: "Success",subTitle: forgotPasswordVM.alertMessage)
                :
                AlertToast(displayMode: .banner(.pop), type: .error(.red), title: "Upss",subTitle: forgotPasswordVM.alertMessage)
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
