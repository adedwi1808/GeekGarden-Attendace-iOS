//
//  MarkerModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 27/12/22.
//

import MapKit
import SwiftUI

struct Marker: Identifiable {
    let id = UUID()
    var location: MapMarker
}
