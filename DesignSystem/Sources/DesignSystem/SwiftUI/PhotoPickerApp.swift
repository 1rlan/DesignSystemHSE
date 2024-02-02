//
//  photoPickerApp.swift
//  photoPicker
//
//  Created by Печик Ирина on 01.02.2024.
//

import SwiftUI

@main
struct PhotoPickerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
