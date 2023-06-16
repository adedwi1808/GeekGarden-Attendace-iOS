//
//  ReportAttendanceViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 05/06/23.
//

@testable import GeekGarden_Attendace_iOS
import XCTest

final class ReportAttendanceViewModel_Test: XCTestCase {

    private var expectedResponse: ReportAttendanceResponseModel!
    private var sut: ReportAttendanceViewModel!
    private var networkServices: ReportAttendanceServicesMock!
    
    override func setUp() async throws {
        expectedResponse = ReportAttendanceResponseModel(code: 200, message: "success", data: [
            ReportAttendanceModel(idPengaduanAbsensi: 0, idPegawai: 0, idAdmin: 0, tanggalAbsen: "2023-08-18", keteranganPengaduan: "Saya hadir bro", keteranganAdmin: "Okedeh", tanggalPengaduan: "2022-09-01", statusPengaduan: "Diterima", admin: .none)])
        networkServices = ReportAttendanceServicesMock(response: expectedResponse)
        self.sut = ReportAttendanceViewModel(reportAttendanceServices: networkServices)
        try await super.setUp()
    }
    
    func testPostPermitResponse() async {
        do {
            let response = try await networkServices.postReportAttendance(endPoint: .postReportAttendance(tanggal: "", keteranganLaporan: ""))
            XCTAssertNotNil(response)
            XCTAssertEqual(response.data.first!.statusPengaduan, "Diterima")
        } catch {
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(!sut.isLoading)
    }
    
    
    override func tearDownWithError() throws {
        sut = nil
        networkServices = nil
        expectedResponse = nil
        try super.tearDownWithError()
    }
}

final class ReportAttendanceServicesMock: ReportAttendanceServicesProtocol {
    
    var networker: NetworkerProtocol
    
    let response: ReportAttendanceResponseModel?
    
    init(response: ReportAttendanceResponseModel?, networker: NetworkerProtocol = Networker()) {
        self.response = response
        self.networker = networker
    }
    
    func postReportAttendance(endPoint: GeekGarden_Attendace_iOS.NetworkFactory) async throws -> ReportAttendanceResponseModel {
        return self.response!
    }
    
    
}
