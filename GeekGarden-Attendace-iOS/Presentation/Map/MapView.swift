//
//  MapView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 26/12/22.
//

import CoreLocationUI
import MapKit
import SwiftUI

struct MapView: View {
    @StateObject var mapViewModel: MapViewModel = MapViewModel()
    let markers = [Marker(location: MapMarker(coordinate: CLLocationCoordinate2D(latitude: -7.75561,longitude: 110.38478),tint: .red))]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $mapViewModel.region,
                showsUserLocation: true,
                annotationItems: markers) { marker in
                marker.location
            }
                .ignoresSafeArea()
            
            LocationButton(.currentLocation) {
                mapViewModel.getRegion()
            }
            .foregroundColor(.white)
            .cornerRadius(20)
                
        }
        .onAppear {
//            mapViewModel.getRegion()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
