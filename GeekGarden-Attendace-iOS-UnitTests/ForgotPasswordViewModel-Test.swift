//
//  ForgotPasswordViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 05/06/23.
//

@testable import GeekGarden_Attendace_iOS
import XCTest

final class ForgotPasswordViewModel_Test: XCTestCase {

    private var expectedResponse: ForgotPasswordResponseModel!
    private var sut: ForgotPasswordViewModel!
    private var networkServices: ForgotPasswordServicesMock!
    
    override func setUp() async throws {
        expectedResponse = ForgotPasswordResponseModel(code: 200, message: "Success", data: DataPegawaiModel(idPegawai: 1, nama: "ade", jenisKelamin: "Laki-laki", nomorHP: "08*******", email: "ade@gmail.com", jabatan: "CEO", fotoProfile: ""))
        networkServices = ForgotPasswordServicesMock(response: expectedResponse)
        self.sut = ForgotPasswordViewModel(forgotPasswordServices: networkServices)
        try await super.setUp()
    }
    
    func testpostForgotPasswordRequest() async {
        do {
            let response = try await networkServices.postForgotPassword(endpoint: .forgotPassword(email: ""))
            XCTAssertNotNil(response)
            XCTAssertEqual(response.message, "Success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    override func tearDownWithError() throws {
        sut = nil
        networkServices = nil
        expectedResponse = nil
        try super.tearDownWithError()
    }
}

final class ForgotPasswordServicesMock: ForgotPasswordServicesProtocol {
    var networker: NetworkerProtocol
    
    let response: ForgotPasswordResponseModel?
    
    init(response: ForgotPasswordResponseModel?, networker: NetworkerProtocol = Networker()) {
        self.response = response
        self.networker = networker
    }
    
    func postForgotPassword(endpoint: GeekGarden_Attendace_iOS.NetworkFactory) async throws -> ForgotPasswordResponseModel {
        return self.response!
    }

}
