import UIKit

class ChipsViewModel {
    var chipsArray: [ChipsModel] = []
    
    init(chipsArray: [ChipsModel] = []) {
        self.chipsArray = chipsArray
    }
    func addChip(model: ChipsModel) {
        chipsArray.append(model)
    }
    
    func addChips(chipsArray: [ChipsModel]) {
        self.chipsArray.append(contentsOf: chipsArray)
    }
    
    func removeChip(withId id: UUID) {
        chipsArray.removeAll { $0.id == id }
    }
}


