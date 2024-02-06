//
//  HSEStyle.swift
//
//  Created by Irlan Abushakhmanov on 16.01.2024.
//

import UIKit
import Extensions

public struct HSEStyle: Decodable {
    public var backgroundColor: String? = "#FFFFFF"
    public var foregroungColor: String? = "#000000"
    
    public var cornerRadius: CGFloat? = 0
    public var font: String? = "system"
    public var tintColor: String? = "#0000FF"
    public var fontSize: CGFloat? = 14
    public var borderWidth: CGFloat? = 0
    public var borderColor: String? = "#000000"
    public var textColor: String? = "#FF0000"
    public var fontWeight: String? = "regular"
    
    public init(
        backgroundColor: String? = nil,
        foregroungColor: String? = nil,
        cornerRadius: CGFloat? = nil,
        font: String? = nil,
        tintColor: String? = nil,
        fontSize: CGFloat? = nil,
        borderWidth: CGFloat? = nil,
        borderColor: String? = nil,
        textColor: String? = nil,
        fontWeight: String? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.foregroungColor = foregroungColor
        self.cornerRadius = cornerRadius
        self.font = font
        self.tintColor = tintColor
        self.fontSize = fontSize
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.textColor = textColor
        self.fontWeight = fontWeight
    }
    
    public var rawForegroungColor: UIColor? {
        UIColor(hex: foregroungColor)
    }
    
    public var rawBackgroungColor: UIColor? {
        UIColor(hex: backgroundColor)
    }
    
    public var rawBorderColor: UIColor? {
        UIColor(hex: borderColor)
    }
}
