
import SwiftUI

struct ChipsView: View {
    @State var isSelected: Bool
    let isDeletable: Bool
    let isUnselectable: Bool
    let name: String
    let icon: String?
    let primaryColor: Color
    let secondaryColor: Color
    var onDelete: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 4) {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(isSelected ? secondaryColor : primaryColor)
            }
        
            Text(name).font(.body).lineLimit(1)
            
            if isDeletable {
                Button(action: {
                    onDelete?()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.vertical, 4)
        .padding(.leading, 8)
        .padding(.trailing, 8)
        .foregroundColor(isSelected ? secondaryColor : primaryColor)
        .background(isSelected ? primaryColor : secondaryColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(primaryColor, lineWidth: 1.5)
            
        ).onTapGesture {
            if !isUnselectable {
                self.isSelected.toggle()
            }
        }
    }
}
