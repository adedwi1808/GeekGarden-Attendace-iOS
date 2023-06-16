//
//  ListWorkPermitStatusViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 05/06/23.
//

@testable import GeekGarden_Attendace_iOS
import XCTest

final class ListWorkPermitStatusViewModel_Test: XCTestCase {

    private var expectedWorkPermitResponse: ListWorkPermitStatusResponseModel!
    private var sut: ListWorkPermitStatusViewModel!
    private var networkServices: ListWorkPermitStatusServicesMock!
    
    override func setUp() async throws {
        expectedWorkPermitResponse = ListWorkPermitStatusResponseModel(code: 200, message: "success", data: [
            WorkPermitModel(idPengajuanIzin: 0, idPegawai: 0, idAdmin: 0, jenisIzin: "Sakit", tanggalMulaiIzin: "2022-02-01", tanggalSelesaiIzin: "", alasanIzin: "", keteranganAdmin: "", suratIzin: "", statusIzin: "", tanggalMengajukanIzin: "", admin: .none)
        ])
        networkServices = ListWorkPermitStatusServicesMock(permitResponse: expectedWorkPermitResponse)
        self.sut = ListWorkPermitStatusViewModel(listWorkPermitStatusServices: networkServices)
        try await super.setUp()
    }
    
    func testPostPermitStatusResponse() async {
        do {
            let response = try await networkServices.getListWorkPermitStatus(endpoint: .getWorkPermitStatus)
            XCTAssertNotNil(response)
            XCTAssertNotNil(response.data.first)
            XCTAssertEqual(response.data.first!.jenisIzin, "Sakit")
            sut.isWorkPermitHistoryLoaded = true
        } catch {
            XCTAssertNotNil(error)
            sut.isWorkPermitHistoryLoaded = false
        }
        XCTAssertTrue(sut.isWorkPermitHistoryLoaded)
    }
    
    
    override func tearDownWithError() throws {
        sut = nil
        networkServices = nil
        expectedWorkPermitResponse = nil
        try super.tearDownWithError()
    }
}

final class ListWorkPermitStatusServicesMock: ListWorkPermitStatusServicesProtocol {
    var networker: NetworkerProtocol
    
    let permitResponse: ListWorkPermitStatusResponseModel?
    
    init(permitResponse: ListWorkPermitStatusResponseModel?, networker: NetworkerProtocol = Networker()) {
        self.permitResponse = permitResponse
        self.networker = networker
    }
    
    func getListWorkPermitStatus(endpoint: GeekGarden_Attendace_iOS.NetworkFactory) async throws -> ListWorkPermitStatusResponseModel {
        return self.permitResponse!
    }
    
    
}
