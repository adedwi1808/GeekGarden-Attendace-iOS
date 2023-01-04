//
//  ReportStatusItemView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import SwiftUI

struct ReportStatusItemView: View {
    var date: String
    var month: String
    var status: String
    var fullDate: String
    var adminName: String
    
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                Text(date)
                Text(month.prefix(3))
            }
            .fontWeight(.semibold)
            .padding(5)
            .frame(width: 60)
            .foregroundColor(Color("PrimaryColor"))
            .cornerRadius(10)
            
            Text(fullDate)
                .frame(width: 120)
                .foregroundColor(Color("PrimaryColor"))
            
            Text(status)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(status == "Diajukan" ? .blue : status == "Diterima" ? .green : .red)
                .cornerRadius(20)
                .frame(width: 85, height: 40)
                .foregroundColor(.white)
                .padding(.trailing, 5)
            
            Text(adminName.prefix(3))
                .frame(width: 50)
                .foregroundColor(Color("PrimaryColor"))
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: 110, alignment: .center)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 2, y: 1)
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
    }
}

struct ReportStatusItemView_Previews: PreviewProvider {
    static var previews: some View {
        ReportStatusItemView(date: "25", month: "Agustus", status: "Diterima", fullDate: "25/08/2022", adminName: "Ade")
    }
}
