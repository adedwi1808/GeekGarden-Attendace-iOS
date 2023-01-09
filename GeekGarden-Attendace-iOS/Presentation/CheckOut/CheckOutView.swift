//
//  CheckOutView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 29/12/22.
//

import AlertToast
import SwiftUI

struct CheckOutView: View {
    private enum Field: Int, CaseIterable {
        case progress
    }
    @StateObject var checkOutVM: CheckOutViewModel = CheckOutViewModel()
    @State private var selectedImageData: UIImage?
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) var dismiss
    let latitude: String
    let longitude: String
    let tempat: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Button {
                    checkOutVM.source = .camera
                    checkOutVM.showPhotoPicker()
                } label: {
                    if let selectedImageData  {
                        Image(uiImage: selectedImageData)
                            .resizable()
                            .scaledToFill()
                            .frame(width:350 ,height: 400)
                            .cornerRadius(20)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.8)
                            .foregroundColor(.white)
                            .frame(width:350 ,height: 400)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(20)
                    }
                }
                .fullScreenCover(isPresented: $checkOutVM.showPicker) {
                    ImagePicker(sourceType: .camera, allowEdit: false, selectedImage: $selectedImageData)
                        .ignoresSafeArea()
                }
                .alert("Error", isPresented: $checkOutVM.showCameraAlert, presenting: checkOutVM.cameraError, actions: { cameraError in
                    cameraError.button
                }, message: { cameraError in
                    Text(cameraError.message)
                })
                
                TextField("Progress Hari Ini", text: $checkOutVM.progressPegawai, axis: .vertical)
                    .focused($focusedField, equals: .progress)
                    .lineLimit(2, reservesSpace: true)
                    .padding(15)
                    .frame(width:350)
                    .background(.white)
                    .cornerRadius(20)
                
                Button {
                    Task {
                        try await checkOutVM.postCheckOut(long:longitude,
                                                          lat:latitude,
                                                          tempat: tempat,
                                                          foto:selectedImageData?.jpegData(compressionQuality: 0.5) ?? Data(),
                                                          prog: checkOutVM.progressPegawai)
                    }
                } label: {
                    ZStack {
                        Text("Check Out")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                    }
                }
                .frame(width:300 ,height: 80)
                .background(.green)
                .cornerRadius(20)
            }
            .padding(.top, 60)
        }
        .onChange(of: checkOutVM.attendanceSuccess, perform: { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                dismiss()
            }
        })
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    focusedField = nil
                }
            }
        }
        .navigationTitle("Check Out")
        .toast(isPresenting: $checkOutVM.showAlert) {
            checkOutVM.attendanceSuccess ?
            AlertToast(displayMode: .banner(.pop), type: .complete(.green), title: "Success",subTitle: checkOutVM.alertMessage)
            :
            AlertToast(displayMode: .banner(.pop),
                       type: .error(.red),
                       title: "Upss",
                       subTitle: checkOutVM.alertMessage)
        }
        .toast(isPresenting: $checkOutVM.isLoading) {
            AlertToast(type: .loading, title: "Loading")
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(latitude: "", longitude: "", tempat: false)
    }
}
