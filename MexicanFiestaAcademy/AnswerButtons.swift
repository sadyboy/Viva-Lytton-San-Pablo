import Foundation
import SwiftUI

// MARK: - Answer Button with Improved Design
struct AnswerButtons: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let showResult: Bool
    let action: () -> Void
    
    var backgroundColor: Color {
        if showResult {
            if isSelected {
                return isCorrect ?
                    Color.green :
                    Color.red
            } else if isCorrect {
                return Color.green.opacity(0.7)
            }
        }
        return isSelected ?
            Color(red: 1.0, green: 0.8, blue: 0.0).opacity(0.3) :
            Color.white.opacity(0.1)
    }
    
    var borderColor: Color {
        if showResult {
            if isSelected {
                return isCorrect ?
                    Color.green :
                    Color.red
            } else if isCorrect {
                return Color.green
            }
        }
        return isSelected ?
            Color(red: 1.0, green: 0.8, blue: 0.0) :
            Color.white.opacity(0.3)
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                if showResult {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : (isSelected ? "xmark.circle.fill" : "circle"))
                        .foregroundColor(isCorrect ? .white : (isSelected ? .white : .gray))
                        .font(.system(size: 22))
                        .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
                } else {
                    Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                        .foregroundColor(isSelected ? Color(red: 1.0, green: 0.8, blue: 0.0) : .gray)
                        .font(.system(size: 22))
                }
                
                Text(text)
                    .font(.custom("Mexicana", size: 17))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                    .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
                
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundColor)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(borderColor, lineWidth: 2)
            )
            .scaleEffect(isSelected ? 1.02 : 1.0)
        }
        .disabled(showResult)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}
