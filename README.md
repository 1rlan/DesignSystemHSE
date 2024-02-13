# PromIOS Development course 2024
Репозиторий представляет из себя дизайн-систему, созданную студентами курса.\
Ниже вы можете ознакомиться с `UIKit` и `SwiftUI` представлениями и их использованием. 

### ProgressBar
UI-компонент, отвечающий за статус загрузки.
Оба реализации имеет общую сигнатуру инициализации и выставления прогресса для `UIKit` и `SwiftUI` моделей:

```swift
import SwiftUIElements // or import UIKitElements

let style = HSEStyle(...)
let progressBar = ProgressBar(style: style)
progressBar.setProgress(value: 0.8)
```

<img src="Sources/progressBar.gif" width="250">

### Tailwind card
UI-компонент, отвечающий за отображение карточки с информацией, а также дает возможность выбирать карточку, при нажатии на нее. Тут, также, работает анимация плавного перехода при выборе карточки.

Для примера, я объединил карточки в ленту, чтобы показать, как они могут использоваться вместе.

<img src="Sources/Tailwind Card.png" width="250">

Чтобы использовать компонент SwiftUI у себя в коде, достаточно создать экземпляр `TailwindCard` и передать в него необходимые параметры:
```swift
SwiftUICardView(
    title: "Заголовок",
    mainText: "Основной текст",
    footerText: "Информационная строка снизу",
    backgroundColor: .blue
)
```
Пример на UIKit:
```swift
let cardView = UIKitCardView(
    title: "Заголовок",
    mainText: "Основной текст",
    footerText: "Текст в подвале",
    imageBackgroundColor: .lightGray
)
```
