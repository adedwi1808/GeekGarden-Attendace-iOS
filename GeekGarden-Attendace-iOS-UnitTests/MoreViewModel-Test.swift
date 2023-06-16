//
//  MoreViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 04/06/23.
//

@testable import GeekGarden_Attendace_iOS
import XCTest

final class MoreViewModel_Test: XCTestCase {

    private var expectedSignOutResponse: SignOutResponseModel!
    private var sut: MoreViewModel!
    private var networkServices: MoreServicesMock!
    
    override func setUp() async throws {
        expectedSignOutResponse = SignOutResponseModel(code: 200, message: "success")
        networkServices = MoreServicesMock(logoutResponse: expectedSignOutResponse)
        self.sut = MoreViewModel(moreServices: networkServices)
        try await super.setUp()
    }
    
    func testSignoutResponse() async {
        do {
            let response = try await networkServices.signOut(endpoint: .signOut)
            XCTAssertNotNil(response)
            XCTAssertEqual(response.message, "success")
        } catch {
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(!sut.isLoading)
    }
    
    
    override func tearDownWithError() throws {
        sut = nil
        networkServices = nil
        expectedSignOutResponse = nil
        try super.tearDownWithError()
    }
}

class MoreServicesMock: MoreServicesProtocol {
    var networker: NetworkerProtocol
    
    let logoutResponse: SignOutResponseModel?
    
    init(logoutResponse: SignOutResponseModel?, networker: NetworkerProtocol = Networker()) {
        self.logoutResponse = logoutResponse
        self.networker = networker
    }
    
    func signOut(endpoint: GeekGarden_Attendace_iOS.NetworkFactory) async throws -> SignOutResponseModel {
        return self.logoutResponse!
    }
}
