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
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    private let prefs = UserDefaults()
    
    private var loginServices: LoginServicesProtocol
    
    init(loginServices: LoginServicesProtocol = LoginPegawaiServices()) {
        self.loginServices = loginServices
    }
    
    @MainActor
    func loginPegawai() async throws{
            self.isLoading.toggle()
        do {
            let data = try await loginServices.loginPegawai(endpoint: .loginPegawai(email: self.email, password: self.password))
            saveLoginData(using: data)
        } catch let err as NetworkError {
                self.showAlert.toggle()
                self.alertMessage = err.localizedDescription
        }
            self.isLoading.toggle()
    }
    
    func saveLoginData(using data: LoginPegawaiResponseModel) {
        DispatchQueue.main.async {
            guard let appToken = data.token else { return }
            self.isLoggedIn = true
            self.prefs.setDataToLocal(data.data.self, with: .dataPegawai)
            self.prefs.setDataToLocal(appToken.self, with: .appToken)
        }
    }
    
    func resetLocalStorage() {
        prefs.resetLocale()
    }
}
