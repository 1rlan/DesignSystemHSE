# ChipsView

## Конфигурация

Чипы имеют следующие параметры:
1. Активность по умолчанию (`isSelected`) (`false` by default)
2. Текст чипа (`name`)
3. Возмоность удаления чипа (`isDeletable`) (`false` by default)
4. Выключение взаимодействия с чипом (`isUnselectable`) (`false` by default)
5. Иконка чипа (`icon`) (`nil` by default)
6. Основной цвет (`primaryColor`) (`.blue` / `.systemBlue` by default)
7. Вторичный цвет (`secondaryColor`) (`.white` by default)

## Как использовать

Код для модельки чипа:
```
struct ChipsModel: Identifiable {
    let id = UUID()
    let isDeletable: Bool
    let isUnselectable: Bool
    let isSelected: Bool
    let name: String
    let icon: String?
    let primaryColor: UIColor // Color в SwiftUI
    let secondaryColor: UIColor // Color в SwiftUI
    
    init(isSelected: Bool = false, name: String, isDeletable: Bool = false, isUnselectable: Bool = false, icon: String? = nil, primaryColor: UIColor = .systemBlue, secondaryColor: UIColor = .white) {
        ...
    }
}
```

### UIKit
1. Создаём ViewModel (создаётся из массива чипов):
```
let viewModel = ChipsViewModel(chipsArray: [
    ChipsModel(name: "Deletable chip icon", isDeletable: true, icon: "heart.fill"),
])
```
2. Создаём ViewController:
```
let viewController = ChipContainerViewController()
viewController.viewModel = viewModel
```
3. Вставляем уже дальше куда нам нужно, результат:
<img src="https://github.com/1rlan/DesignSystemHSE/blob/NikitaShubin_ChipsElement/DesignSystem/Sources/DesignSystem/ChipsElement/gifs/uikit_chip.gif" width="40%" height="40%"/>

### SwiftUI
1. Создаём ViewModel (создаётся из массива чипов):
```
@StateObject var viewModel = ChipsViewModel(chipsArray: [
    ChipsModel(name: "deletable button", isDeletable: true, icon: "heart.fill"),
])
```
2. Добавляем куда-нибудь ChipContainerView (например в VStack):
```
VStack(spacing: 16) {
    ChipContainerView(viewModel: viewModel)
    Spacer()
}.padding(.horizontal, 16)
```
3. Результат:
<img src="https://github.com/1rlan/DesignSystemHSE/blob/NikitaShubin_ChipsElement/DesignSystem/Sources/DesignSystem/ChipsElement/gifs/swiftui_chip.gif" width="40%" height="40%"/>

## SwiftUI implementation preview
<img src="https://github.com/1rlan/DesignSystemHSE/blob/NikitaShubin_ChipsElement/DesignSystem/Sources/DesignSystem/ChipsElement/gifs/swiftui.gif" width="40%" height="40%"/>

## UIKit implementation preview
<img src="https://github.com/1rlan/DesignSystemHSE/blob/NikitaShubin_ChipsElement/DesignSystem/Sources/DesignSystem/ChipsElement/gifs/uikit.gif" width="40%" height="40%"/>

