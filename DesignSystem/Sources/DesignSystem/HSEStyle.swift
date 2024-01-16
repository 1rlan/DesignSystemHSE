//
//  HSEStyle.swift
//
//  Created by Irlan Abushakhmanov on 16.01.2024.
//

import Foundation

struct HSEStyle: Decodable {
    var backgroundColor: String? = "#FFFFFF"
    var foregroungColor: String? = "#000000"
    
    var cornerRadius: CGFloat? = 0
    var font: String? = "system"
    var tintColor: String? = "#0000FF"
    var fontSize: Int? = 14
    var borderWidth: Int? = 0
    var borderColor: String? = "#000000"
    var fontWeight: String? = "regular"
}
