//
//  CheckInView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 24/12/22.
//

import AlertToast
import PhotosUI
import SwiftUI

struct CheckInView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var checkInViewModel: CheckInViewModel = CheckInViewModel()
    @State private var selectedImageData: UIImage?
    let latitude: String
    let longitude: String
    let tempat: Bool
    
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
                    ImagePicker(sourceType: .camera, allowEdit: false, selectedImage: $selectedImageData)
                        .ignoresSafeArea()
                }
                .alert("Error", isPresented: $checkInViewModel.showCameraAlert, presenting: checkInViewModel.cameraError, actions: { cameraError in
                    cameraError.button
                }, message: { cameraError in
                    Text(cameraError.message)
                })
                .toast(isPresenting: $checkInViewModel.isLoading) {
                    AlertToast(type: .loading, title: "Loading")
                }
                .toast(isPresenting: $checkInViewModel.showAlert, duration: 3) {
                    AlertToast(displayMode: .banner(.pop),
                               type: .error(.red),
                               title: "Upss",
                               subTitle: checkInViewModel.alertMessage)
                }
                
                
                Button {
                    if let selectedImageData {
                        Task {
                            try await checkInViewModel.postCheckIn(lat: latitude, long: longitude, tempat: tempat, foto: (selectedImageData.jpegData(compressionQuality: 0.4))!)
                        }
                    }
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
        .onChange(of: checkInViewModel.attendanceSuccess, perform: { newValue in
            dismiss()
        })
        .navigationTitle("Check In")
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView(latitude: "", longitude: "", tempat: false)
    }
}
