//
//  File.swift
//
//
//  Created by Илья on 01.02.2024.
//

import SwiftUI

@available(iOS 13.0, *)
struct CarouselView: View {
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    private let cardWidth: CGFloat = 120
    
    // Можно не инициализировать сразу, а передавать массив элементов извне
    let colors: [Color] = [.red, .blue, .green, .yellow, .purple]
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                VStack {
                    ZStack {
                        ForEach(0..<colors.count, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(colors[index])
                                .frame(width: cardWidth, height: 160)
                                .opacity(currentIndex == index ? 1.0 : 0.5)
                                .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                                .offset(x: CGFloat(index - currentIndex) * (cardWidth + 20) + dragOffset, y: -250)
                                .onTapGesture {
                                    print("tap")
                                }
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onEnded({ value in
                                let threshold: CGFloat = 50
                                if value.translation.width > threshold {
                                    withAnimation {
                                        currentIndex = max(0, currentIndex - 1)
                                    }
                                } else if value.translation.width < -threshold {
                                    withAnimation {
                                        currentIndex = min(colors.count - 1, currentIndex + 1)
                                    }
                                }
                            })
                    )
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.largeTitle)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                currentIndex = min(colors.count - 1, currentIndex + 1)
                            }
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.largeTitle)
                        }
                    }
                    .padding()
                    .offset(y: -250)
                }
            }
        } else {
            // Fallback on earlier versions
            Text("Not available on iOS versions below 16.0")
        }
    }
}

@available(iOS 13.0, *)
struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
