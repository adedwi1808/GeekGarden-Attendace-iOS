//
//  CheckInView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 24/12/22.
//

import SwiftUI

struct CheckInView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
        }
        .navigationTitle("Check In")
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView()
    }
}
