//
//  LoginViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 10/01/23.
//

@testable import GeekGarden_Attendace_iOS
import XCTest

final class LoginViewModel_Test: XCTestCase {
    
    private var expectedLoginPegawaiResponse: LoginPegawaiResponseModel!
    private var sut: LoginViewModel!
    private var networkServices: LoginPegawaiServicesMock!
    
    override func setUp() async throws {
        expectedLoginPegawaiResponse = LoginPegawaiResponseModel(data: DataClass(idPegawai: 1, nama: "Ade", jenisKelamin: "Laki-laki", nomorHP: "08123456", email: "test@mail.com", jabatan: "Tokek", fotoProfile: "foto"), token: "ini token")
        self.networkServices = LoginPegawaiServicesMock(dataPegawai: expectedLoginPegawaiResponse)
        self.sut = LoginViewModel(loginServices: networkServices)
        try await super.setUp()
    }
    
    func testLoginResponse() async {
        do {
            let data = try await networkServices.loginPegawai(endpoint: .loginPegawai(email: "", password: ""))
            XCTAssertNotNil(data)
            XCTAssertEqual(data.data?.nama, "Ade")
        } catch {
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(!sut.isLoading)
    }
    
    
    override func tearDownWithError() throws {
        sut = nil
        networkServices = nil
        expectedLoginPegawaiResponse = nil
        try super.tearDownWithError()
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
