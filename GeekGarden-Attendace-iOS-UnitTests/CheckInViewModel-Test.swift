//
//  CheckInViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 10/01/23.
//

@testable import GeekGarden_Attendace_iOS
import XCTest

final class CheckInViewModel_Test: XCTestCase {

    private var expectedCheckInResponse: CheckInResponseModel!
    private var sut: CheckInViewModel!
    private var networkService: CheckInServicesMock!
    
    override func setUp() async throws {
        expectedCheckInResponse = CheckInResponseModel(code: 200, message: "res", data: Attendance(idAbsensi: 1, idPegawai: 1, tempat: "atlantis", status: "status", longitude: "123", latitude: "123", foto: "foto", tanggal: "2022-12-03"))
        networkService = CheckInServicesMock(checkInResponse: expectedCheckInResponse)
        sut = CheckInViewModel(checkInServices: networkService)
        try await super.setUp()
    }
    
    func testCheckInResponse() async {
        do {
            let response = try await networkService.postCheckIn(endpoint: .postCheckIn(tempat: "", status: "", long: "", lat: "", image: Data()))
            XCTAssertNotNil(response)
            XCTAssertEqual(response.data?.tempat, "atlantis")
        } catch {
            XCTAssertNil(error)
        }
        XCTAssertTrue(!sut.isLoading)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        networkService = nil
        expectedCheckInResponse = nil
        try super.tearDownWithError()
    }
    
}

class CheckInServicesMock: CheckInServicesProtocol {
    var networker: NetworkerProtocol
    
    let checkInResponse: CheckInResponseModel?
    
    init(checkInResponse: CheckInResponseModel?, networker: NetworkerProtocol = Networker()) {
        self.checkInResponse = checkInResponse
        self.networker = networker
    }
    
    func postCheckIn(endpoint: NetworkFactory) async throws -> GeekGarden_Attendace_iOS.CheckInResponseModel {
        return self.checkInResponse!
    }
    
    
}
