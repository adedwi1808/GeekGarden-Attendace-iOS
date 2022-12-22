//
//  HomeViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 22/12/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    func getDataPegawai() -> DataPegawaiModel? {
        do {
            if let data = UserDefaults.standard.data(forKey: "dataPegawai") {
                return try JSONDecoder().decode(DataPegawaiModel.self, from: data)
            }
        } catch {
            print(error)
        }
        return nil
    }
}
