//
//  CheckInViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 10/01/23.
//

@testable import GeekGarden_Attendace_iOS
import XCTest

final class CheckInViewModel_Test: XCTestCase {

    let expectedCheckInResponse: CheckInResponseModel = CheckInResponseModel(code: 200, message: "res", data: Attendance(idAbsensi: 1, idPegawai: 1, tempat: "atlantis", status: "status", longitude: "123", latitude: "123", foto: "foto", tanggal: "2022-12-03"))
    
    
    func testCheckInResponse() async {
        let service: CheckInServicesProtocol = CheckInServicesMock(checkInResponse: expectedCheckInResponse)
        let vm: CheckInViewModel = CheckInViewModel(checkInServices: service)
        
        do {
            let response = try await service.postCheckIn(endpoint: .postCheckIn(tempat: "", status: "", long: "", lat: "", image: Data()))
            XCTAssertNotNil(response)
            XCTAssertEqual(response.data?.tempat, "atlantis")
        } catch {
            XCTAssertNil(error)
        }
        XCTAssertTrue(!vm.isLoading)
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
