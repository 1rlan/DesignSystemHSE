//
//  ContentView.swift
//  photoPicker
//
//  Created by Печик Ирина on 01.02.2024.
//

import SwiftUI
import PhotosUI


struct ContentView: View {
    @EnvironmentObject var vm: ViewModel
    @State private var actionSheetVisible = false
    
    var body: some View {
        VStack {
            PhotoPickerView(avatarImage: $vm.image)
                .onTapGesture {
                    actionSheetVisible = true
                }
        }
        .confirmationDialog("Choose photo", isPresented: self.$actionSheetVisible) {
            Button("Photo library") {
                vm.source = .library
                vm.showPicker = true
            }
            Button("Camera") {
                vm.source = .camera
                vm.showPhotoPicker()
            }
            Button("Delete photo", role: .destructive) {
                vm.showPicker = false
                vm.image = nil
            }
        }
        .sheet(isPresented: $vm.showPicker, content: {
            ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                .ignoresSafeArea()
        })
        .alert("Error", isPresented: $vm.showCameraAlert, presenting: vm.cameraError) { cameraError in
            cameraError.button
        } message: { cameraError in
            Text(cameraError.message)
        }

    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
