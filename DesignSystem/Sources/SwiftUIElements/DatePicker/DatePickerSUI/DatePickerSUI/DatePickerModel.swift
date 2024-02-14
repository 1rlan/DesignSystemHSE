import Foundation

class DatePickerModel: ObservableObject {
    @Published var selectedDate: Date
    init(initialDate: Date = Date()) {
        self.selectedDate = initialDate
    }
}
