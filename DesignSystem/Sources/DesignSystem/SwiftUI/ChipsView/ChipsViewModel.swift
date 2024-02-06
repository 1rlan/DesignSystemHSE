//
//  ChipsViewModel.swift
//  chipscomponent
//
//  Created by Nikita Shubin on 30.01.2024.
//

import SwiftUI

class ChipsViewModel: ObservableObject {
    @Published var chipsArray: [ChipsModel]
    
    init(chipsArray: [ChipsModel]) {
        self.chipsArray = chipsArray
    }
    
    func addChip(model: ChipsModel) {
        self.chipsArray.append(model)
    }
    
    func addChip(chipsArray: [ChipsModel]) {
        self.chipsArray.append(contentsOf: chipsArray)
    }
}
