//
//  TailwindCardComponent.swift
//  
//
//  Created by Карим Хамид on 05.02.2024.
//

import Foundation
import SwiftUI

@available(iOS 13, *)
struct SwiftUICardView: View {
    let title: String
    let mainText: String
    let footerText: String
    var backgroundColor: Color

    @State private var isSelected: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .fill(backgroundColor)
                .frame(height: 150)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                
                Text(mainText)
                    .font(.system(size: 16))
                    .padding(.top, 4)
                
                Text(footerText)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding(.top, 24)
            }
            .padding(16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 4)
        )
        .overlay(
            HStack {
                Spacer()
                if isSelected {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 24, height: 24)
                        .overlay(
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                        )
                        .padding(.top, 16)
                        .padding(.trailing, 16)
                        .animation(.easeInOut, value: isSelected)
                        .transition(.scale)
                }
            },
            alignment: .topTrailing
        )
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                isSelected.toggle()
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 0)
        )
    }
}

@available(iOS 13, *)
struct SwiftUICardsListView: View {
    let cardsData: [(title: String, mainText: String, footerText: String, backgroundColor: Color)] = [
        ("Newsletter", "Last message sent an hour ago", "Информационная надпись 1", .red),
        ("Заголовок 2", "Основной текст карточки 2", "Информационная надпись 2", .green),
        ("Заголовок 3", "Основной текст карточки 3", "Информационная надпись 3", .blue),
        ("Заголовок 4", "Основной текст карточки 4", "Информационная надпись 4", .orange),
        ("Заголовок 5", "Основной текст карточки 5", "Информационная надпись 5", .gray),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<cardsData.count, id: \.self) { index in
                    SwiftUICardView(
                        title: cardsData[index].title,
                        mainText: cardsData[index].mainText,
                        footerText: cardsData[index].footerText,
                        backgroundColor: cardsData[index].backgroundColor
                    )
                }
            }
            .padding(20)
        }
    }
}

@available(iOS 13, *)
struct SwiftUICardsListView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUICardsListView()
    }
}
