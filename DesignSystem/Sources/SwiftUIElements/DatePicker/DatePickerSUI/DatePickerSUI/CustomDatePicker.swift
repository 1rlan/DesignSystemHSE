import SwiftUI

struct CustomDatePickerView: View {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool
    var accentColor: Color
    var onDateSelected: (Date) -> Void
    var onCancel: () -> Void

    var body: some View {
        VStack {
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()

            HStack {
                Button(action: {
                    onCancel()
                    isPresented = false
                }) {
                    Text("Cancel")
                        .foregroundColor(accentColor)
                }
                
                Spacer()
                
                Button(action: {
                    onDateSelected(selectedDate)
                    isPresented = false
                }) {
                    Text("OK")
                        .foregroundColor(accentColor)
                }
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(maxWidth: 300)
        .transition(.slide)
    }
}
