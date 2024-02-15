//
//  CircularSlider.swift
//  CircularSlider
//
//  Created by Юлия Гудошникова on 05.02.2024.
//

import Foundation
import SwiftUI

//MARK: круглый слайдер для выбора значения или диапазона
// Для работы необходимо минимум указать factor для диапазона:[0, factor)
// При указании startRange == nil на слайдере можно крутить только 1 круг, иначе 2

struct CircularSlider: View {
    // Связывает начальное значение диапазона. Опциональный Int, так как начальное значение может быть nil.
    @Binding var startRange: Int?
    // Связывает конечное значение диапазона. (или число, если startRange = nil)
    @Binding var endRange: Int
    // Определяет максимальное значение для диапазона.
    var factor: Int
    
    // Ширина линии кругового слайдера.
    var widthCircle: CGFloat = 40
    //  Размер кругового слайдера.
    var size: CGFloat = UIScreen.main.bounds.width / 2
    // Цвет фона кругового слайдера.
    var backgroundColor: Color = .gray
    // Цвет заливки для области прогресса.
    var progressColor: Color = .blue
    // Цвет ползунков.
    var draggableColor: Color = .white
    

    @State private var startProgressLine: CGFloat = 0
    @State private var startAngle: Double = 0
    @State private var endProgressLine: CGFloat = 0
    @State private var endAngle: Double = 0
    
    // Проверяет входные данные на валидность и в случае невалидных условий возвращает nil.
    init?(startRange: Binding<Int?>, endRange: Binding<Int>, factor: Int, widthCircle: CGFloat = 40, size: CGFloat =  UIScreen.main.bounds.width / 2, backgroundColor: Color = .gray, progressColor: Color = .blue, draggableColor: Color = .white) {
        if let startValue = startRange.wrappedValue, startValue < endRange.wrappedValue, startValue < factor, endRange.wrappedValue < factor {
            self._startRange = startRange
            self._endRange = endRange
            self.widthCircle = widthCircle
            self.size = size
            self.factor = factor
            self.backgroundColor = backgroundColor
            self.progressColor = progressColor
            self.draggableColor = draggableColor
        } else {
            if endRange.wrappedValue > factor {
                return nil
            }
            self._startRange = startRange
            self._endRange = endRange
            self.widthCircle = widthCircle
            self.size = size
            self.factor = factor
            self.backgroundColor = backgroundColor
            self.progressColor = progressColor
            self.draggableColor = draggableColor
        }
    }
    

    var body: some View {
        ZStack {
            backgroundCircle
            progressCircle(from: startProgressLine, to: endProgressLine, color: progressColor)
            if let startRange = startRange, startRange != factor - 1 {
                draggableCircle(range: startRange, angle: startAngle, circleIndex: 1)
            }
            draggableCircle(range: endRange, angle: endAngle, circleIndex: 2)
            if let startRange = startRange, startRange == factor - 1 {
                draggableCircle(range: startRange, angle: startAngle, circleIndex: 1)
            }
        }
        .onAppear {
            initializeValues()
        }
    }

    private var backgroundCircle: some View {
        Circle()
            .stroke(backgroundColor, style: StrokeStyle(lineWidth: widthCircle, lineCap: .round, lineJoin: .round))
            .frame(width: size, height: size)
            .rotationEffect(.degrees(-90))
    }

    private func progressCircle(from start: CGFloat, to end: CGFloat, color: Color) -> some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(color, style: StrokeStyle(lineWidth: widthCircle, lineCap: .butt, lineJoin: .round))
            .frame(width: size, height: size)
            .rotationEffect(.degrees(-90))
    }

    private func draggableCircle(range: Int, angle: Double, circleIndex: Int) -> some View {
        Circle()
            .fill(Color.white)
            .frame(width: widthCircle, height: widthCircle)
            .offset(x: size / 2)
            .rotationEffect(.degrees(angle))
            .gesture(DragGesture().onChanged { value in
                onDrag(value: value, circleIndex: circleIndex)
            })
            .rotationEffect(.degrees(-90))
    }

    private func initializeValues() {
        startProgressLine = Double((startRange ?? 0)) / Double(factor)
        endProgressLine = Double(endRange) / Double(factor)
        startAngle = Double(startProgressLine * 360)
        endAngle = Double(endProgressLine * 360)
    }
    
    func onDrag(value: DragGesture.Value, circleIndex: Int) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy - widthCircle / 2, vector.dx - widthCircle / 2)
        var angle = radians * 180 / .pi
        if angle < 0 {
            angle += 360
        }
        
        withAnimation(Animation.linear(duration: 0.15)) {
            let progress = angle / 360
            
            switch circleIndex {
            case 1:
                if progress <= endProgressLine {
                    self.startProgressLine = progress
                    self.startAngle = Double(angle)
                    self.startRange = Int(progress * Double(factor))
                }
            case 2:
                if progress >= startProgressLine {
                    self.endProgressLine = progress
                    self.endAngle = Double(angle)
                    self.endRange = Int(progress *  Double(factor))
                }
            default:
                break
            }
        }
        
    }
}
