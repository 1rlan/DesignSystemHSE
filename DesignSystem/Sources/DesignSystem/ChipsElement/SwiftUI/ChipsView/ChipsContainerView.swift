//
//  ChipsContainerView.swift
//  chipscomponent
//
//  Created by Nikita Shubin on 30.01.2024.
//

import SwiftUI

struct ChipContainerView: View {
    @ObservedObject var viewModel = ChipsViewModel(chipsArray: [])
    
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return GeometryReader { geo in
            ZStack(alignment: .topLeading, content: {
                ForEach(viewModel.chipsArray) { data in
                    ChipsView(isSelected: data.isSelected,
                              isDeletable: data.isDeletable,
                              isUnselectable: data.isUnselectable,
                              name: data.name,
                              icon: data.icon,
                              primaryColor: data.primaryColor,
                              secondaryColor: data.secondaryColor
                              
                    ) {
                        viewModel.chipsArray.removeAll { $0.id == data.id }
                    }
                    .padding(.all, 5)
                    .alignmentGuide(.leading) { dimension in
                        if (abs(width - dimension.width) > geo.size.width) {
                            width = 0
                            height -= dimension.height
                        }
                        let result = width
                        if data.id == viewModel.chipsArray.last!.id {
                            width = 0
                        } else {
                            width -= dimension.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { dimension in
                        let result = height
                        if data.id == viewModel.chipsArray.last!.id {
                            height = 0
                        }
                        return result
                    }
                }
            })
        }
    }
}
