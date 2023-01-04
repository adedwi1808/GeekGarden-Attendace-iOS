//
//  WorkPermitView.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 04/01/23.
//

import SwiftUI

struct WorkPermitView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var workPermitVM: WorkPermitViewModel = WorkPermitViewModel()
    
    @State private var selectedImageData: UIImage?
    var body: some View {
        ZStack(alignment: .top) {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                List {
                    Section {
                        Picker("" , selection: $workPermitVM.selectedReason) {
                            ForEach(PermitReasons.allCases) { item in
                                Text(item.rawValue).tag(item)
                            }
                        }
                        .pickerStyle(.segmented)
                        .menuIndicator(.hidden)
                        
                    } header: {
                        Text("Jenis Izin :")
                            .foregroundColor(.white)
                    }
                    
                    
                    Section {
                        DatePicker("Start", selection: $workPermitVM.permitDateStart, in: Date()..., displayedComponents: .date)
                        DatePicker("End", selection: $workPermitVM.permitDateEnd, in: workPermitVM.permitDateStart..., displayedComponents: .date)
                    } header: {
                        Text("Tanggal Izin")
                            .foregroundColor(.white)
                    }
                    
                    Section {
                        TextField("Alasan", text: $workPermitVM.permitReasonDec, axis: .vertical)
                            .lineLimit(3, reservesSpace: true)
                    } header: {
                        Text("Alasan Izin")
                            .foregroundColor(.white)
                    }
                    
                    Section {
                        Button {
                            workPermitVM.isShowActionSheet.toggle()
                        } label: {
                            Text(selectedImageData != nil ? "Sudah memilih" : "Silahkan Pilih")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    } header: {
                        Text("Surat Izin")
                            .foregroundColor(.white)
                    }
                }
                .frame(maxHeight: 500)
                .background(Color("PrimaryColor"))
                .scrollContentBackground(.hidden)
                .cornerRadius(20)
                
                Spacer()
                Button {
                    Task {
                        await workPermitVM.postWorkPermit(image: selectedImageData?.jpegData(compressionQuality: 0.4))
                    }
                } label: {
                    Text("Submit")
                        .font(.system(size: 23, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: 200, height: 60)
                .background(.green)
                .cornerRadius(20)
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 15)
            .actionSheet(isPresented: $workPermitVM.isShowActionSheet) {
                ActionSheet(title: Text("Camera / Galery"),
                                    message: Text("Silahkan Pilih Source Foto"),
                                    buttons: [
                                        .cancel(),
                                        .default(Text("Camera"),action: {
                                            workPermitVM.source = .camera
                                            workPermitVM.showPhotoPicker()
                                        }),
                                        .default(Text("Photo Galery"), action: {
                                            workPermitVM.source = .library
                                            workPermitVM.showPhotoPicker()
                                        })
                                    ])
            }
            .fullScreenCover(isPresented: $workPermitVM.showPicker) {
                ImagePicker(sourceType: workPermitVM.source == .camera ? .camera : .photoLibrary, allowEdit: true, selectedImage: $selectedImageData)
                    .ignoresSafeArea()
            }
        }
        .navigationTitle("Form Izin")
    }
}

struct WorkPermitView_Previews: PreviewProvider {
    static var previews: some View {
        WorkPermitView()
    }
}

enum PermitReasons: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case sakit = "Sakit"
    case cuti = "Cuti"
    case lainnya = "Keperluan Lainnya"
}
