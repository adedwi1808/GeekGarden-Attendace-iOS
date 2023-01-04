//
//  WorkPermitStatusItemView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import SwiftUI

struct WorkPermitStatusItemView: View {
    
    var date: String
    var month: String
    var status: String
    var permitStart: String
    var permitEnd: String
    var permitReason: String
    var adminName: String
    
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                Text(date)
                Text(month.prefix(3))
            }
            .fontWeight(.semibold)
            .frame(width: 50)
            .foregroundColor(Color("PrimaryColor"))
            .cornerRadius(10)
            
            VStack {
                Text(permitStart)
                    .frame(width: 100)
                    .foregroundColor(Color("PrimaryColor"))
                Text(permitEnd)
                    .frame(width: 100)
                    .foregroundColor(Color("PrimaryColor"))
            }
            
            Text(permitReason)
                .lineLimit(1)
                .frame(width: 40)
                .foregroundColor(Color("PrimaryColor"))
            
            Text(status)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(status == "Diajukan" ? .blue : status == "Diterima" ? .green : .red)
                .cornerRadius(20)
                .frame(width: 85, height: 40)
                .foregroundColor(.white)
            
            Text(adminName)
                .lineLimit(1)
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

struct WorkPermitStatusItemView_Previews: PreviewProvider {
    static var previews: some View {
        WorkPermitStatusItemView(date: "26", month: "AUG", status: "Diterima", permitStart: "22/08/2022", permitEnd: "23/08/2022", permitReason: "Keperluan Lainnya", adminName: "Ade Dwi Prayitno")
    }
}
