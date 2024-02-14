import SwiftUI

class DatePickerViewController: ObservableObject {
    @Published var model: DatePickerModel
    init(model: DatePickerModel) {
        self.model = model
    }
    
    func updateDate(date: Date) {
        model.selectedDate = date
    }
}
