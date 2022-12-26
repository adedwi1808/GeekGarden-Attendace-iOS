//
//  CheckInView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 24/12/22.
//

import PhotosUI
import SwiftUI

struct CheckInView: View {
    
    @StateObject var checkInViewModel: CheckInViewModel = CheckInViewModel()
    @State private var selectedImageData: UIImage?
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Button {
                    checkInViewModel.source = .camera
                    checkInViewModel.showPhotoPicker()
                } label: {
                    if let selectedImageData  {
                        Image(uiImage: selectedImageData)
                            .resizable()
                            .scaledToFill()
                            .frame(width:350 ,height: 420)
                            .cornerRadius(20)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.8)
                            .foregroundColor(.white)
                            .frame(width:350 ,height: 420)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(20)
                    }
                }
                .fullScreenCover(isPresented: $checkInViewModel.showPicker) {
                    ImagePicker(sourceType: .camera , selectedImage: $selectedImageData)
                }
                .alert("Error", isPresented: $checkInViewModel.showCameraAlert, presenting: checkInViewModel.cameraError, actions: { cameraError in
                    cameraError.button
                }, message: { cameraError in
                    Text(cameraError.message)
                })
                
                
                Button {
                    //
                } label: {
                    ZStack {
                        Text("Check In")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                    }
                }
                .frame(width:300 ,height: 80)
                .background(.green)
                .cornerRadius(20)
            }.padding(.top, 60)
        }
        .navigationTitle("Check In")
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView()
    }
}
