//
//  StyleManager.swift
//
//  Created by Irlan Abushakhmanov on 16.01.2024.
//

import UIKit
import Extensions

extension UIView {
    func add(style: HSEStyle) {
        backgroundColor = UIColor(hex: style.backgroundColor)
        
        if let color = UIColor(hex: style.borderColor) {
            layer.borderColor = color.cgColor
        }
        
        if let cornerRadius = style.cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        
        if let borderWidth = style.borderWidth {
            layer.cornerRadius = borderWidth
        }
    }
}

extension UIButton {
    func addForButton(style: HSEStyle) {
        add(style: style)
        
        if let fontSize = style.fontSize {
            if let fontName = style.font, let font = UIFont(name: fontName, size: fontSize) {
                titleLabel?.font = font
            } else {
                titleLabel?.font = UIFont.systemFont(ofSize: fontSize /*TODO:, weight: */)
            }
        }

        tintColor = UIColor(hex: style.tintColor)
        setTitleColor(UIColor(hex: style.textColor), for: .normal)
    }
}

extension UILabel {
    func addForLabel(style: HSEStyle) {
        super.add(style: style)
        
        if let fontSize = style.fontSize {
            if let font = style.font, let font = UIFont(name: font, size: fontSize) {
                self.font = font
            } else {
                self.font = UIFont.systemFont(ofSize: fontSize/*TODO:, weight: */)
            }
        }
        
        tintColor = UIColor(hex: style.tintColor)
        textColor = UIColor(hex:style.textColor)
    }
}
