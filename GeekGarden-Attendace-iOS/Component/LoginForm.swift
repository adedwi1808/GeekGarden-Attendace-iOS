//
//  LoginForm.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import SwiftUI

struct LoginForm: View {
    var type: String
    @Binding var value: String
    @State var isSecured: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: type == "Email" ? "envelope" : "lock")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(Color("PrimaryColor"))
            VStack {
                if type == "Email" {
                    TextField(type, text: $value)
                        .autocapitalization(.none)
                } else {
                    if isSecured {
                        SecureField("Enter Password", text: $value)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .frame(height: 20)
                    } else {
                        TextField("Enter Password", text: $value)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .frame(height: 20)
                    }
                }
                Color("PrimaryColor")
                    .frame(height: 2)
            }
            
            if type == "Password" {
                Button {
                    isSecured.toggle()
                } label: {
                    Image(systemName: isSecured ? "eye" : "eye.slash")
                        .foregroundColor(Color("PrimaryColor"))
                }

            }
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm(type: "Password", value: .constant("12312"))
    }
}
