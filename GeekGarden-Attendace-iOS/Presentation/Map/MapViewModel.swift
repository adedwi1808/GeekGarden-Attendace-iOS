//
//  MapViewModel.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 27/12/22.
//

import CoreLocation
import MapKit

class MapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -7.7999017, longitude: 110.3709304), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    @MainActor
    func getRegion() {
        LocationManager.shared.getLocation { location, error in
            guard let location else { return }
                self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.05))
        }
    }
}
