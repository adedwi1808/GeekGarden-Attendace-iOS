//
//  LoginViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    
    func userLogin() {
        if self.email == "email", self.password == "123" {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            print("login")
            self.isLoggedIn = true
        }
    }
}
