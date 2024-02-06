//
//  ContentView.swift
//  chipscomponent
//
//  Created by Nikita Shubin on 30.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ChipsViewModel(chipsArray: [
        ChipsModel(name: "Unselectable deletable button", isDeletable: true, isUnselectable: true),
        ChipsModel(name: "Just deletable button", isDeletable: true),
        ChipsModel(isSelected: true, name: "Unselectable selected button", isUnselectable: true),
        ChipsModel(name: "Item Fooooouuuuuurrrr"),
        ChipsModel(name: "s"),
        ChipsModel(name: "Item icon", icon: "star"),
        ChipsModel(name: "Different colors!", isDeletable: true, icon: "star", primaryColor: .mint, secondaryColor: .black),
    ])
    
        var body: some View {
            VStack(spacing: 16) {
                Text("Select Your Chips")
                    .font(.title)
                    .fontWeight(.bold)
                ScrollView {
                    ChipContainerView(viewModel: viewModel)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
        }
}

#Preview {
    ContentView()
}
