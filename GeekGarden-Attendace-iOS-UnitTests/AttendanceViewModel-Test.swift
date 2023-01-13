//
//  AttendanceViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 13/01/23.
//

import XCTest
@testable import GeekGarden_Attendace_iOS

final class AttendanceViewModel_Test: XCTestCase {
    
    private var sut: AttendanceViewModel!
    private var networkServices: AttendanceServiceMock!
    private var expectedCheckAttendanceResponse: CheckAttendanceResponseModel!
    
    override func setUpWithError() throws {
        expectedCheckAttendanceResponse =
        CheckAttendanceResponseModel(code: 200,
                                     message: "",
                                     data: CheckAttendanceModel(jumlahAbsenHariIni: 2,
                                                                jamHadir: Jam(tanggal: "2020-10-10 08:08:08"),
                                                                jamPulang: Jam(tanggal: "2020-10-10 16:08:08")))
        networkServices = AttendanceServiceMock(checkAttendanceResponse: expectedCheckAttendanceResponse)
        sut = AttendanceViewModel(attendanceServices: networkServices)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        networkServices = nil
        expectedCheckAttendanceResponse = nil
        try super.tearDownWithError()
    }
    
    func testGetCheckAttendance() async throws {
        do {
            let data = try await networkServices.checkAttendance(endpoint: .checkAttendance)
            sut.showAlert.toggle()
            XCTAssertNotNil(data)
            XCTAssertEqual(data.data?.jumlahAbsenHariIni, 2)
        } catch let err as NetworkError {
            XCTAssertNil(err)
        }
        XCTAssertTrue(sut.showAlert)
    }
    
}

class AttendanceServiceMock: AttendanceServicesProtocol {
    var networker: NetworkerProtocol
    
    let checkAttendanceResponse: CheckAttendanceResponseModel?
    
    init(checkAttendanceResponse: CheckAttendanceResponseModel?,
         networker: NetworkerProtocol = Networker()) {
        self.checkAttendanceResponse = checkAttendanceResponse
        self.networker = networker
    }
    
    func checkAttendance(endpoint: GeekGarden_Attendace_iOS.NetworkFactory) async throws -> GeekGarden_Attendace_iOS.CheckAttendanceResponseModel {
        return try self.checkAttendanceResponse!
    }
    
    
}
