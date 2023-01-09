//
//  ForgotPasswordViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 09/01/23.
//

import Foundation

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isLoading: Bool = false
    @Published var submitSuccess: Bool =  false
    @Published var showAlert: Bool =  false
    @Published var alertMessage: String =  ""
    
    private var forgotPasswordServices: ForgotPasswordServicesProtocol
    
    init(forgotPasswordServices: ForgotPasswordServicesProtocol = ForgotPasswordServices()) {
        self.forgotPasswordServices = forgotPasswordServices
    }
    
    func postForgotPasswordRequest() async throws {
        DispatchQueue.main.async {
            self.isLoading.toggle()
        }
        
        do {
            let data = try await forgotPasswordServices.postForgotPassword(endpoint: .forgotPassword(email: self.email))
            DispatchQueue.main.async {
                self.isLoading.toggle()
                self.alertMessage = data.message
                self.showAlert.toggle()
                self.submitSuccess.toggle()
            }
        } catch let err as NetworkError {
            DispatchQueue.main.async {
                self.isLoading.toggle()
                self.alertMessage = err.localizedDescription
                self.showAlert.toggle()
            }
        }
    }
    
}
