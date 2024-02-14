//
//  ChipsModel.swift
//  chipscomponent
//
//  Created by Nikita Shubin on 30.01.2024.
//

import UIKit

struct ChipsModel: Identifiable {
    let id = UUID()
    let isDeletable: Bool
    let isUnselectable: Bool
    let isSelected: Bool
    let name: String
    let icon: String?
    let primaryColor: UIColor
    let secondaryColor: UIColor
    
    init(isSelected: Bool = false, name: String, isDeletable: Bool = false, isUnselectable: Bool = false, icon: String? = nil, primaryColor: UIColor = .systemBlue, secondaryColor: UIColor = .white) {
        self.name = name
        self.isSelected = isSelected
        self.isDeletable = isDeletable
        self.isUnselectable = isUnselectable
        self.icon = icon
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
}
