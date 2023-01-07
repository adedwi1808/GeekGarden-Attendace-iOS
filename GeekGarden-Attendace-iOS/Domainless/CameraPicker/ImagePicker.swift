//
//  CameraPicker.swift
//  GeekGarden-Attendace-iOS
//
//  Created by Ade Dwi Prayitno on 26/12/22.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var allowEdit: Bool = false
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = allowEdit
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                if parent.allowEdit {
                    let sideLength = min(
                        image.size.width,
                        image.size.height
                    )

                    // Determines the x,y coordinate of a centered
                    // sideLength by sideLength square
                    let sourceSize = image.size
                    let xOffset = (sourceSize.width - sideLength) / 2.0
                    let yOffset = (sourceSize.height - sideLength) / 2.0

                    // The cropRect is the rect of the image to keep,
                    // in this case centered
                    let cropRect = CGRect(
                        x: xOffset,
                        y: yOffset,
                        width: sideLength,
                        height: sideLength
                    ).integral

                    // Center crop the image
                    let sourceCGImage = image.cgImage!
                    let croppedCGImage = sourceCGImage.cropping(
                        to: cropRect
                    )!
                    parent.selectedImage = UIImage(cgImage: croppedCGImage)
                } else {
                    parent.selectedImage = image
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

