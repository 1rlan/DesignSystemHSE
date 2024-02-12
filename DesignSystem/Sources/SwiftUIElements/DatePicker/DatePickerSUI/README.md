# Использование CustomDatePicker в SwiftUI и UIKit

## SwiftUI версия

### Конфигурация

`ModalDatePicker` - это компонент SwiftUI для выбора даты с возможностью кастомизации. Поддерживает следующие параметры:

- **isPresented**: Управляет видимостью компонента.
- **selectedDate**: Связанная переменная для хранения выбранной даты.
- **backgroundColor**: Цвет фона компонента.
- **onConfirm**: Колбэк, вызываемый с выбранной датой при подтверждении.

### Как использовать

1. **Определите состояние в вашем `View` для отображения и хранения выбранной даты**:

    ```swift
    @State private var showModal = false
    @State private var selectedDate = Date()
    ```

2. **Добавьте `ModalDatePicker` в тело вашего `View`**:

    ```swift
    Button("Choose Date: \(formattedDate(selectedDate))") {
        showModal = true
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
    }
    ```

3. **Форматируйте выбранную дату для отображения**:

    ```swift
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    ```

## UIKit версия

### Конфигурация

`CustomDatePickerViewController` - это `UIViewController` для выбора даты с кастомизируемым фоном и обработчиком выбора.

### Как использовать

1. **Создайте и сконфигурируйте `CustomDatePickerViewController` в вашем `ViewController`**:

    ```swift
    let datePickerVC = CustomDatePickerViewController()
    datePickerVC.modalPresentationStyle = .overFullScreen
    datePickerVC.onConfirm = { selectedDate in
        print("Selected date: \(selectedDate)")
    }
    ```

2. **Отобразите `CustomDatePickerViewController`**:

    ```swift
    present(datePickerVC, animated: true)
    ```

Обе версии компонента позволяют легко интегрировать выбор даты в ваше приложение, предоставляя пользовательский интерфейс для выбора даты на платформах SwiftUI и UIKit.
