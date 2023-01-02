//
//  UpdateProfileView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 02/01/23.
//

import SwiftUI

struct UpdateProfileView: View {
    @StateObject var updateProfileVM: UpdateProfileViewModel = UpdateProfileViewModel()
    @State var isShowActionSheet: Bool = false
    @State var selectedImageData: UIImage?
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                Button {
                    isShowActionSheet.toggle()
                } label: {
                    AsyncImage(url: URL(string: "https")) { Image in
                        Image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        if let selectedImageData{
                            Image(uiImage: selectedImageData)
                                .resizable()
                                .scaledToFill()
                        }
                        else {
                            ZStack {
                                Color("PrimaryColor")
                                Text("ADP")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .frame(width: 120, height: 120)
                    .cornerRadius(60)
                    .padding(.trailing, 5)
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
            ImagePicker(sourceType: updateProfileVM.source == .camera ? .camera : .photoLibrary , selectedImage: $selectedImageData)
                .ignoresSafeArea()
        }
        .toolbar {
            Button {
                //
            } label: {
                Text("Done")
            }
        }
        .accentColor(Color("PrimaryColor"))
    }
}

struct UpdateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView()
    }
}
