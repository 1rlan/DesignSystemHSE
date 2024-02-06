//
//  ProgressBar.swift
//
//  Created by Irlan Abushakhmanov on 28.01.2024.
//

import SwiftUI
import DesignSystem

public struct ProgressBar: View {
    // MARK: - Types
    
    private enum Constants {
        static let height = 30.0
    }
    
    // MARK: - Private properties
    
    @State private var progress = 0.0
    private let style: HSEStyle
    
    private var cornerRadius: CGFloat {
        guard let radius = style.cornerRadius else { return .zero }
        return radius
    }
    
    // MARK: - Initialization
    
    init(style: HSEStyle) {
        self.style = style
    }
    
    // MARK: - Public properties

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: Constants.height)
                    .foregroundColor(style.rawBackgroungColor.suiColor)

                Rectangle()
                    .frame(width: progress * geometry.size.width, height: Constants.height)
                    .foregroundColor(style.rawForegroungColor.suiColor)
                    .animation(.easeInOut, value: progress)
            }
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        style.rawBorderColor.suiColor ?? .clear,
                        lineWidth: style.borderWidth ?? .zero
                )
            )
        }
        .safeAreaPadding(.horizontal)
    }
    
    // MARK: - Public methods
    
    public func setProgress(value: CGFloat) {
        progress = max(min(value, 1), 0)
    }
}

#Preview {
    let style = HSEStyle(
        backgroundColor: "#e0c477",
        foregroungColor: "#fa8b02",
        cornerRadius: 15,
        borderWidth: 1,
        borderColor: "#575348"
    )
    return ProgressBar(style: style)
}

