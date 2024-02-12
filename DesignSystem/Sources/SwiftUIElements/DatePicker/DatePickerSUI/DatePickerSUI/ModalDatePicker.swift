import SwiftUI

struct ModalDatePicker: View {
    @Binding var isPresented: Bool
    @Binding var selectedDate: Date
    var backgroundColor: Color
    var onConfirm: (Date) -> Void
    @State private var draftDate: Date

    init(isPresented: Binding<Bool>, selectedDate: Binding<Date>, backgroundColor: Color, onConfirm: @escaping (Date) -> Void) {
        self._isPresented = isPresented
        self._selectedDate = selectedDate
        self.backgroundColor = backgroundColor
        self.onConfirm = onConfirm
        self._draftDate = State(initialValue: selectedDate.wrappedValue)
    }

    var body: some View {
        VStack {
            DatePicker("", selection: $draftDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            Spacer()

            HStack(spacing: 100) {
                Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(.white)
                .font(Font.system(size: 20))
                .padding(.vertical, 20)
                .padding(.horizontal, 20)

                Button("OK") {
                    onConfirm(draftDate)
                    isPresented = false
                }
                .foregroundColor(.white)
                .font(Font.system(size: 20))
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 20)
        }
        .background(backgroundColor)
        .cornerRadius(12)
        .shadow(radius: 10)
        .padding(.top, 40)
    }
}
