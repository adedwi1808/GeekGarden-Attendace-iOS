//
//  HomeViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 13/01/23.
//

import XCTest
@testable import GeekGarden_Attendace_iOS

final class HomeViewModel_Test: XCTestCase {
    
    private var sut: HomeViewModel!
    private var networkServices: HomeServicesMock!
    private var expectedMadingResponse: MadingGeekGardenResponseModel!
    private var expectedAttendanceStatsResponse: AttendanceStatsResponseModel!
    
    override func setUpWithError() throws {
        expectedMadingResponse = MadingGeekGardenResponseModel(code: 200,
                                                               message: "",
                                                               data: [
                                                                MadingGeekGardenModel(idMading: 1,
                                                                                      idAdmin: 1,
                                                                                      judul: "judul mading",
                                                                                      informasi: "informasi mading",
                                                                                      foto: "",
                                                                                      createAt: "")])
        
        expectedAttendanceStatsResponse = AttendanceStatsResponseModel(code: 200,
                                                                       message: "",
                                                                       data: AttendanceStatsModel(cuti: 2, izin: 2, lembur: 2, hadir: 2))
        
        networkServices = HomeServicesMock(getMadingResponse: expectedMadingResponse,
                                           getAttendanceStats: expectedAttendanceStatsResponse)
        sut = HomeViewModel(homeServices: networkServices)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        networkServices = nil
        expectedMadingResponse = nil
        expectedAttendanceStatsResponse = nil
        try super.tearDownWithError()
    }
    
    
    func testGetMadingGeekGarden() async throws {
        do {
            let data = try await networkServices.getMadingGeekGarden(endpoint: .getMadingGeekGarden)
            sut.madingDataOfflineReady.toggle()
            XCTAssertNotNil(data)
            XCTAssertEqual(data.data?.count, 1)
        } catch let err as NetworkError {
            XCTAssertNil(err)
        }
        XCTAssertTrue(sut.madingDataOfflineReady)
    }
    
    func testAttendanceStats() async throws {
        do {
            let data = try await networkServices.getAttendanceStats(endpoint: .getAttendanceStats)
            sut.madingDataOfflineReady.toggle()
            XCTAssertNotNil(data)
            XCTAssertNotEqual(data.data?.cuti, 0)
        } catch let err as NetworkError {
            XCTAssertNil(err)
        }
        XCTAssertTrue(sut.madingDataOfflineReady)
    }
    
}

class HomeServicesMock: HomeServicesProtocol {
    var networker: GeekGarden_Attendace_iOS.NetworkerProtocol
    
    let getMadingResponse: MadingGeekGardenResponseModel?
    let getAttendanceStats: AttendanceStatsResponseModel?
    
    init(getMadingResponse: MadingGeekGardenResponseModel?,
         getAttendanceStats: AttendanceStatsResponseModel?,
         networker: NetworkerProtocol = Networker()) {
        self.getMadingResponse = getMadingResponse
        self.getAttendanceStats = getAttendanceStats
        self.networker = networker
    }
    
    func getMadingGeekGarden(endpoint: GeekGarden_Attendace_iOS.NetworkFactory) async throws -> GeekGarden_Attendace_iOS.MadingGeekGardenResponseModel {
        self.getMadingResponse!
    }
    
    func getAttendanceStats(endpoint: GeekGarden_Attendace_iOS.NetworkFactory) async throws -> GeekGarden_Attendace_iOS.AttendanceStatsResponseModel {
        self.getAttendanceStats!
    }
}
