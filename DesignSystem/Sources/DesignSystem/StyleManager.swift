//
//  StyleManager.swift
//
//  Created by Irlan Abushakhmanov on 16.01.2024.
//

#if os(iOS)
import UIKit

extension UIView {
    func add(style: HSEStyle) {
        backgroundColor = UIColor(hex: style.backgroundColor)
        borderColor = UIColor(hex: style.borderColor)
        cornerRadius = style.cornerRadius
        borderWidth = style.borderWidth
    }
}

extension UIButton {
    override func add(style: HSEStyle) {
        super.add(style: style)
        
        if let font = UIFont(name: style.fontName, size: style.fontSize) {
            titleLabel?.font = font
        } else {
            titleLabel?.font = UIFont.systemFont(ofSize: style.fontSize/*TODO:, weight: */)
        }
        tintColor = UIColor(hex: style.tintColor)
        textColor = style.textColor
    }
}

extension UILabel {
    override func add(style: HSEStyle) {
        super.add(style: style)
        
        if let font = UIFont(name: style.fontName, size: style.fontSize) {
            titleLabel?.font = font
        } else {
            titleLabel?.font = UIFont.systemFont(ofSize: style.fontSize/*TODO:, weight: */)
        }
        
        tintColor = UIColor(hex: style.tintColor)
        textColor = style.textColor
    }
}
#endif
