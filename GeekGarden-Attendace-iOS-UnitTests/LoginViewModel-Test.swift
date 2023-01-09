//
//  LoginViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 10/01/23.
//

@testable import GeekGarden_Attendace_iOS
import XCTest

final class LoginViewModel_Test: XCTestCase {
    
    let expectedLoginPegawaiResponse: LoginPegawaiResponseModel = LoginPegawaiResponseModel(data: DataClass(idPegawai: 1, nama: "Ade", jenisKelamin: "Laki-laki", nomorHP: "08123456", email: "test@mail.com", jabatan: "Tokek", fotoProfile: "foto"), token: "ini token")
    
    func testLoginResponse() async {
        let services: LoginServicesProtocol = LoginPegawaiServicesMock(dataPegawai: expectedLoginPegawaiResponse)
        let VM: LoginViewModel = LoginViewModel(loginServices: services)
        
        do {
            let data = try await services.loginPegawai(endpoint: .loginPegawai(email: "", password: ""))
            XCTAssertNotNil(data)
            XCTAssertEqual(data.data?.nama, "Ade")
        } catch {
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(!VM.isLoading)
    }
    
}

class LoginPegawaiServicesMock: LoginServicesProtocol {
    var networker: NetworkerProtocol
    
    let dataPegawai: LoginPegawaiResponseModel?
    
    init(dataPegawai: LoginPegawaiResponseModel?, networker: NetworkerProtocol = Networker()) {
        self.dataPegawai = dataPegawai
        self.networker = networker
    }
    
    func loginPegawai(endpoint: GeekGarden_Attendace_iOS.NetworkFactory) async throws -> LoginPegawaiResponseModel {
        return self.dataPegawai!
    }
    
    
}
