//
//  PhotoPickerView.swift
//  photoPicker
//
//  Created by Печик Ирина on 02.02.2024.
//

import SwiftUI

struct PhotoPickerView: View {
    @Binding var avatarImage: UIImage?
    var body: some View {
        if let avatarImage = avatarImage {
            Image(uiImage: avatarImage)
                .resizable()
                .scaledToFill()
                .photoPickerCustomStyle()
                .foregroundColor(.red)
        } else {
            ZStack {
                // Добавляем circle снизу, чтобы весь кружок был кликабельным, а не только стрлочка и обводка.
                Circle().foregroundStyle(.white)
                Image(systemName: "arrow.down.to.line")
                    .scaleEffect(1.7)
                    .foregroundStyle(.black)
                    .photoPickerCustomStyle()
                    .overlay(
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                            .foregroundColor(.black)
                    )
            }
        }
    }
}

struct photoPickerViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 228, height: 228)
            .clipShape(Circle())
    }
}

extension View {
    func photoPickerCustomStyle() -> some View {
        modifier(photoPickerViewModifier())
    }
}
