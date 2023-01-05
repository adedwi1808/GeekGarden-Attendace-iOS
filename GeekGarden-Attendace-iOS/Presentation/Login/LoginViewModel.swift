//
//  LoginViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = "adedwip1808@gmail.com"
    @Published var password: String = "123123"
    @Published var isLoggedIn: Bool = false
    @Published var isLoading: Bool = false
    private let prefs = UserDefaults()
    
    private var loginPegawaiServices: LoginServicesProtocol
    
    init(loginPegawaiServices: LoginServicesProtocol = LoginPegawaiServices()) {
        self.loginPegawaiServices = loginPegawaiServices
    }
    
    func loginPegawai() async throws{
        do {
            let data = try await loginPegawaiServices.loginPegawai(endpoint: .loginPegawai(email: self.email, password: self.password))
            saveLoginData(using: data)
        } catch let err as NetworkError {
//            print("err while do login")
            print(err.localizedDescription)
        }
    }
    
    func saveLoginData(using data: LoginPegawaiResponseModel) {
        DispatchQueue.main.async {
            guard let appToken = data.token else { return }
            self.isLoggedIn = true
            self.prefs.setDataToLocal(data.data.self, with: .dataPegawai)
            self.prefs.setDataToLocal(appToken.self, with: .appToken)
        }
    }
}
