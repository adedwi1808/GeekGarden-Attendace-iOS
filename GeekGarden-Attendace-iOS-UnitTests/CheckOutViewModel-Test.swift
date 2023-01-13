//
//  CheckOutViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 13/01/23.
//

import XCTest
@testable import GeekGarden_Attendace_iOS

final class CheckOutViewModel_Test: XCTestCase {
    
    private var sut: CheckOutViewModel!
    private var networkServices: CheckOutServicesMock!
    private var expectedPostCheckOutResponse: CheckOutResponseModel!

    override func setUpWithError() throws {
        expectedPostCheckOutResponse = CheckOutResponseModel(code: 200,
                                                             message: "",
                                                             data: CheckOutModel(idAbsensi: 1, idPegawai: 1, tempat: "Dikantor", status: "Pulang", longitude: "", latitude: "", foto: "", tanggal: ""))
        networkServices = CheckOutServicesMock(checkOutResponse: expectedPostCheckOutResponse)
        sut = CheckOutViewModel(checkOutServices: networkServices)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        networkServices = nil
        expectedPostCheckOutResponse = nil
        try super.tearDownWithError()
    }

    func testPostCheckOut() async throws {
        do {
            let data = try await networkServices.postCheckOut(endpoint: .postCheckOut(tempat: "", status: "", prog: "", long: "", lat: "", image: Data()))
            sut.attendanceSuccess.toggle()
            XCTAssertNotNil(data)
            XCTAssertEqual(data.data?.status, "Pulang")
        } catch let err as NetworkError {
            XCTAssertNil(err)
        }
        XCTAssertTrue(sut.attendanceSuccess)
    }

}

class CheckOutServicesMock: CheckOutServicesProtocol {
    var networker: NetworkerProtocol
    
    let checkOutResponse: CheckOutResponseModel?
    
    init(checkOutResponse: CheckOutResponseModel?,
         networker: NetworkerProtocol = Networker()) {
        self.checkOutResponse = checkOutResponse
        self.networker = networker
    }
    
    func postCheckOut(endpoint: NetworkFactory) async throws -> CheckOutResponseModel {
        return self.checkOutResponse!
    }
    
    
}
