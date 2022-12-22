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
    private let prefs = UserDefaults()
    
    private var loginPegawaiServices: LoginServicesProtocol
    
    init(loginPegawaiServices: LoginServicesProtocol = LoginPegawaiServices()) {
        self.loginPegawaiServices = loginPegawaiServices
    }
    
    func loginPegawai() async {
        do {
            let data = try await loginPegawaiServices.loginPegawai(endpoint: .loginPegawai(email: self.email, password: self.password))
            saveLoginData(using: data)
        } catch {
            print("err while do login")
        }
    }
    
    func saveLoginData(using data: LoginPegawaiResponseModel) {
        DispatchQueue.main.async {
            self.isLoggedIn = true
            do {
                let encodedDataPegawai = try JSONEncoder().encode(data.data)
                self.prefs.setDataToLocal(encodedDataPegawai, with: .dataPegawai)
            } catch {
                print("encoded data pegawai error")
            }
            self.prefs.setDataToLocal(data.token, with: .appToken)
        }
    }
}
