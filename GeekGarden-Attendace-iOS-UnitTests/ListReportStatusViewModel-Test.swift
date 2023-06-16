//
//  ListReportStatusViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 05/06/23.
//

@testable import GeekGarden_Attendace_iOS
import XCTest

final class ListReportStatusViewModel_Test: XCTestCase {

    private var expectedResponse: ListReportAttendanceResponseModel!
    private var sut: ListReportStatusViewModel!
    private var networkServices: ListReportStatusServicesMock!
    
    override func setUp() async throws {
        expectedResponse = ListReportAttendanceResponseModel(code: 200, message: "success", data: [
            ReportAttendanceModel(idPengaduanAbsensi: 0, idPegawai: 0, idAdmin: 0, tanggalAbsen: "", keteranganPengaduan: "", keteranganAdmin: "", tanggalPengaduan: "", statusPengaduan: "Diterima", admin: .none)
        ])
        networkServices = ListReportStatusServicesMock(response: expectedResponse)
        self.sut = ListReportStatusViewModel(listReportStatusServices: networkServices)
        try await super.setUp()
    }
    
    func testPostPermitResponse() async {
        do {
            let response = try await networkServices.getListReportStatus(endpoint: .getReportStatus)
            XCTAssertNotNil(response)
            XCTAssertEqual(response.data.first!.statusPengaduan, "Diterima")
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

final class ListReportStatusServicesMock: ListReportStatusServicesProtocol {
    var networker: NetworkerProtocol
    
    let response: ListReportAttendanceResponseModel?
    
    init(response: ListReportAttendanceResponseModel?, networker: NetworkerProtocol = Networker()) {
        self.response = response
        self.networker = networker
    }
    
    func getListReportStatus(endpoint: GeekGarden_Attendace_iOS.NetworkFactory) async throws -> ListReportAttendanceResponseModel {
        return self.response!
    }

}
