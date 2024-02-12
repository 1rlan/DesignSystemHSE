import SwiftUI

struct ContentView: View {
    @State private var showModal = false
    @State private var selectedDate = Date()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Button("Choose Date: \(formattedDate(selectedDate))") {
                    showModal = true
                }
                .padding()
                .position(x: geometry.size.width / 2, y: geometry.size.height - 500)
                Spacer()
            }
        }
        .sheet(isPresented: $showModal) {
            ModalDatePicker(
                            isPresented: $showModal,
                            selectedDate: $selectedDate,
                            backgroundColor: Color.green.opacity(0.3),
                            onConfirm: { date in
                                selectedDate = date
                                showModal = false
                            }
                        )
                        .presentationDetents([.medium])
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
