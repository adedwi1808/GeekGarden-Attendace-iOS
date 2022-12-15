//
//  NavigationViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 15/12/22.
//

import Foundation

class NavigationViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    func getUserLoginStatus() -> Bool{
//        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
}
