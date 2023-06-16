//
//  WorkPermitViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 05/06/23.
//

@testable import GeekGarden_Attendace_iOS
import XCTest

final class WorkPermitViewModel_Test: XCTestCase {

    private var expectedWorkPermitResponse: WorkPermitResponseModel!
    private var sut: WorkPermitViewModel!
    private var networkServices: WorkPermitServicesMock!
    
    override func setUp() async throws {
        expectedWorkPermitResponse = WorkPermitResponseModel(code: 200, message: "success",
                                                             data: WorkPermitModel(idPengajuanIzin: 1, idPegawai: 1, idAdmin: 1, jenisIzin: "Sakit", tanggalMulaiIzin: "", tanggalSelesaiIzin: "", alasanIzin: "demam", keteranganAdmin: "Di Izinkan", suratIzin: "", statusIzin: "Diterima", tanggalMengajukanIzin: "2022-2-20", admin: .none))
        networkServices = WorkPermitServicesMock(permitResponse: expectedWorkPermitResponse)
        self.sut = WorkPermitViewModel(workPermitServices: networkServices)
        try await super.setUp()
    }
    
    func testPostPermitResponse() async {
        do {
            let response = try await networkServices.postWorkPermit(endPoint: .workPermit(jenisIzin: "", tanggalMulai: "", tanggalSelesai: "", alasanIzin: "", suratIzin: Data()))
            XCTAssertNotNil(response)
            XCTAssertEqual(response.data.keteranganAdmin, "Di Izinkan")
        } catch {
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(!sut.isLoading)
    }
    
    
    override func tearDownWithError() throws {
        sut = nil
        networkServices = nil
        expectedWorkPermitResponse = nil
        try super.tearDownWithError()
    }
}

final class WorkPermitServicesMock: WorkPermitServicesProtocol {
    
    var networker: NetworkerProtocol
    
    let permitResponse: WorkPermitResponseModel?
    
    init(permitResponse: WorkPermitResponseModel?, networker: NetworkerProtocol = Networker()) {
        self.permitResponse = permitResponse
        self.networker = networker
    }
    
    func postWorkPermit(endPoint endpoint: GeekGarden_Attendace_iOS.NetworkFactory) async throws -> WorkPermitResponseModel {
        return self.permitResponse!
    }
    
    
}
