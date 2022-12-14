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
    
    var body: some View {
        HStack {
            Image(systemName: type == "Email" ? "envelope" : "lock")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(Color("PrimaryColor"))
            VStack {
                TextField(type, text: $value)
                    .autocapitalization(.none)
                Color("PrimaryColor")
                    .frame(height: 2)
            }
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm(type: "Email", value: .constant("email"))
    }
}
