//
//  HistoryViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 13/01/23.
//

import XCTest
@testable import GeekGarden_Attendace_iOS

final class HistoryViewModel_Test: XCTestCase {
    
    private var sut: HistoryViewModel!
    private var networkServices: HistoryServicesMock!
    private var expectedAttendanceHistoryResponse: AttendanceHistoryResponseModel!
    
    override func setUpWithError() throws {
        expectedAttendanceHistoryResponse =
        AttendanceHistoryResponseModel(code: 200,
                                       message: "",
                                       data:
                                        [AttendanceHistoryModel(idAbsensi: 1,
                                                                idPegawai: 1,
                                                                tempat: "Diluar Kantor",
                                                                status: "Hadir",
                                                                longitude: "",
                                                                latitude: "",
                                                                foto: "",
                                                                tanggal: "")])
        networkServices = HistoryServicesMock(attendanceHistoryResponse: expectedAttendanceHistoryResponse)
        sut = HistoryViewModel(historyServices: networkServices)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        networkServices = nil
        expectedAttendanceHistoryResponse = nil
        try super.tearDownWithError()
    }
    
    func testGetAttendanceHistory() async throws {
        do {
            let data = try await networkServices.getAttendanceHistory(endpoint: .getAttendanceHistory)
            XCTAssertNotNil(data)
            XCTAssertEqual(data.data?.count, 1)
            XCTAssertEqual(data.data![0].tempat, "Diluar Kantor")
        } catch let err as NetworkError {
            XCTAssertNil(err)
        }
    }
    
    
}


class HistoryServicesMock: HistoryServicesProtocol {
    var networker: NetworkerProtocol
    
    let attendanceHistoryResponse: AttendanceHistoryResponseModel?
    
    init(attendanceHistoryResponse: AttendanceHistoryResponseModel?,
         networker: NetworkerProtocol = Networker()) {
        self.attendanceHistoryResponse = attendanceHistoryResponse
        self.networker = networker
    }
    
    func getAttendanceHistory(endpoint: NetworkFactory) async throws -> AttendanceHistoryResponseModel {
        return self.attendanceHistoryResponse!
    }
    
    
}
