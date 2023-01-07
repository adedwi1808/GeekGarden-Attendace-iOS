//
//  CustomMoreButtonModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 30/12/22.
//

import SwiftUI

struct CustomMoreButtonModel: Identifiable{
    var id = UUID()
    let buttonName: String?
    let buttonSymbol: String?
    let destination: AnyView?
}
