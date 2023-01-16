//
//  UpdateProfileViewModel-Test.swift
//  GeekGarden-Attendace-iOS-UnitTests
//
//  Created by Ade Dwi Prayitno on 16/01/23.
//

import XCTest
@testable import GeekGarden_Attendace_iOS

final class UpdateProfileViewModel_Test: XCTestCase {
    
    var sut: UpdateProfileViewModel!
    var networkServices: UpdateProfileServicesMock!
    var expectedUpdateProfileResponse: UpdateDataPegawaiResponse!
    
    override func setUpWithError() throws {
        expectedUpdateProfileResponse =
        UpdateDataPegawaiResponse(code: 200,
                                  message: "",
                                  data: DataPegawaiModel(idPegawai: 1, nama: "ade",
                                                         jenisKelamin: "Laki-laki",
                                                         nomorHP: "09",
                                                         email: "ade@gmail.com",
                                                         jabatan: "Mobile Engineer",
                                                         fotoProfile: ""))
        networkServices = UpdateProfileServicesMock(updateDataPegawaiResponse: expectedUpdateProfileResponse)
        sut = UpdateProfileViewModel(updateProfileServices: networkServices)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        networkServices = nil
        expectedUpdateProfileResponse = nil
        try super.tearDownWithError()
    }
    
    func test_UpdatePegawaiPhotoProfile() async throws {
        sut.isLoading.toggle()
        do {
            let data = try await networkServices.updatePegawaiPhotoProfile(endpoint: .updatePegawaiPhotoProfile(image: Data()))
            sut.isLoading.toggle()
            XCTAssertNotNil(data.data)
            XCTAssertEqual(data.data.nama, "ade")
        } catch let err as NetworkError {
            XCTAssertNil(err)
        }
        XCTAssertFalse(sut.isLoading)
    }
    
    func test_UpdateDataPegawai() async throws {
        sut.isLoading.toggle()
        do {
            let data = try await networkServices.updateDataPegawai(endpoint: .updateDataPegawai(email: "",
                                                                                     noHP: "",
                                                                                     password: ""))
            sut.isLoading.toggle()
            XCTAssertNotNil(data)
            XCTAssertEqual(data.data.nama, "ade")
        } catch let err as NetworkError {
            sut.isLoading.toggle()
            XCTAssertNil(err)
        }
        XCTAssertFalse(sut.isLoading)
    }
    
}

class UpdateProfileServicesMock: UpdateProfileServiceProtocol {
    var networker: NetworkerProtocol
    
    let updateDataPegawaiResponse: UpdateDataPegawaiResponse?
    
    init(updateDataPegawaiResponse: UpdateDataPegawaiResponse?,
         networker: NetworkerProtocol = Networker()) {
        self.networker = networker
        self.updateDataPegawaiResponse = updateDataPegawaiResponse
    }
    
    func updatePegawaiPhotoProfile(endpoint: GeekGarden_Attendace_iOS.NetworkFactory) async throws -> GeekGarden_Attendace_iOS.UpdateDataPegawaiResponse {
        return self.updateDataPegawaiResponse!
    }
    
    func updateDataPegawai(endpoint: GeekGarden_Attendace_iOS.NetworkFactory) async throws -> GeekGarden_Attendace_iOS.UpdateDataPegawaiResponse {
        return self.updateDataPegawaiResponse!
    }
}
