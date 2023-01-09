//
//  UpdateProfileView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 02/01/23.
//

import AlertToast
import SwiftUI

struct UpdateProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var updateProfileVM: UpdateProfileViewModel = UpdateProfileViewModel()
    @State var isShowActionSheet: Bool = false
    @State var isShowAlert: Bool = false
    @State var selectedImageData: UIImage?
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                Button {
                    isShowActionSheet.toggle()
                } label: {
                    AsyncImage(url: URL(string: "https://\(Constans().baseURL)/storage/pegawai/\(updateProfileVM.pegawaiPhotoProfileURL)")) { Image in
                        Image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        if let selectedImageData{
                            Image(uiImage: selectedImageData)
                                .resizable()
                                .scaledToFill()
                        }
                        else {
                            ZStack {
                                Color("PrimaryColor")
                                Text(updateProfileVM.pegawaiInitials)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .frame(width: 120, height: 120)
                    .cornerRadius(60)
                    .padding(.trailing, 5)
                    .onChange(of: selectedImageData) { image in
                        Task {
                            try await updateProfileVM.postUpdatePhotoProfile(image: image!.jpegData(compressionQuality: 0.4)!)
                        }
                    }
                }

                
                Form {
                    Section("Profile") {
                        TextField("Nama", text: $updateProfileVM.pegawaiName)
                            .disabled(true)
                            .foregroundColor(.gray)
                        TextField("Email", text: $updateProfileVM.pegawaiEmail)
                        TextField("No. HP", text: $updateProfileVM.pegawaiPhoneNumber)
                    }
                    Section("Password") {
                        SecureField("Password", text: $updateProfileVM.pegawaiPassword)
                            .textContentType(.newPassword)
                    }
                }
                .background(.white)
            }
        }
        .accentColor(Color("PrimaryColor"))
        .onAppear {
            updateProfileVM.setUserDataBefore()
        }
        .actionSheet(isPresented: $isShowActionSheet) {
            ActionSheet(title: Text("Camera / Galery"),
                                message: Text("Silahkan Pilih Source Foto"),
                                buttons: [
                                    .cancel(),
                                    .default(Text("Camera"),action: {
                                        updateProfileVM.source = .camera
                                        updateProfileVM.showPhotoPicker()
                                    }),
                                    .default(Text("Photo Galery"), action: {
                                        updateProfileVM.source = .library
                                        updateProfileVM.showPhotoPicker()
                                    })
                                ])
        }
        .fullScreenCover(isPresented: $updateProfileVM.showPicker) {
            ImagePicker(sourceType: updateProfileVM.source == .camera ? .camera : .photoLibrary, allowEdit: true, selectedImage: $selectedImageData)
                .ignoresSafeArea()
        }
        .toolbar {
            Button {
                updateProfileVM.updatePegawaiProfile()
            } label: {
                Text("Done")
            }
        }
        .onChange(of: updateProfileVM.updateSuccess, perform: { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                dismiss()
            }
        })
        .toast(isPresenting: $updateProfileVM.isLoading) {
            AlertToast(type: .loading, title: "Loading")
        }
        .toast(isPresenting: $updateProfileVM.showAlert) {
            updateProfileVM.updateSuccess || updateProfileVM.updatePhotoProfileSuccess ?
            AlertToast(displayMode: .banner(.pop), type: .complete(.green), title: "Success",subTitle: updateProfileVM.alertMessage)
            :
            AlertToast(displayMode: .banner(.pop),
                       type: .error(.red),
                       title: "Upss",
                       subTitle: updateProfileVM.alertMessage)
        }
    }
}

struct UpdateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView()
    }
}
