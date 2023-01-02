//
//  AttendanceHistoryItemView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 02/01/23.
//

import SwiftUI

struct AttendanceHistoryItemView: View {
    var date: String
    var month: String
    var status: String
    var time: String
    var attendancePlace: String
    
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                Text(date)
                Text(month.prefix(3))
            }
            .fontWeight(.semibold)
            .padding(5)
            .frame(width: 50)
            .foregroundColor(Color("PrimaryColor"))
            .cornerRadius(10)
            
            Text(status)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .frame(width: 75)
                .foregroundColor(Color("PrimaryColor"))
                .cornerRadius(20)
                .padding(.trailing, 20)

            Text(time)
                .frame(width: 50)
                .foregroundColor(Color("PrimaryColor"))
            
            Text(attendancePlace)
                .frame(width: 130)
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

struct AttendanceHistoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceHistoryItemView(date: "28", month: "Agustus", status: "Pulang", time: "03.33", attendancePlace: "Dirumah")
    }
}
