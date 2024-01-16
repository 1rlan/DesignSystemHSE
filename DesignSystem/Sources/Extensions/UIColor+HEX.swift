//
//  UIColor+HEX.swift
//
//  Created by Irlan Abushakhmanov on 16.01.2024.
//

import UIKit

public extension UIColor {
    convenience init?(hex: String?) {
        guard let hex else {
            return nil
        }
        
        var stringWithoutHash = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        // Clean our string for future operations
        if stringWithoutHash.hasPrefix("#") {
            stringWithoutHash.remove(at: stringWithoutHash.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        // Преобразуем 16-ричное представление строки в Int64
        Scanner(string: stringWithoutHash).scanHexInt64(&rgbValue)

        // bitmask: 0xRRGGBB
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1
        )
    }
}
