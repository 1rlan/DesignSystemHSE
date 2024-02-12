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
