import Foundation
import SwiftUI
struct ExamAnswerButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let showExplanation: Bool
    let action: () -> Void
    
    var backgroundColor: Color {
        if showExplanation {
            if isCorrect {
                return Color(red: 0.2, green: 0.6, blue: 0.3)
            } else if isSelected && !isCorrect {
                return Color(red: 0.85, green: 0.2, blue: 0.3)
            }
        }
        return isSelected ? Color(red: 0.95, green: 0.8, blue: 0.1).opacity(0.3) : Color.white.opacity(0.1)
    }
    
    var borderColor: Color {
        if showExplanation {
            if isCorrect {
                return Color(red: 0.2, green: 0.6, blue: 0.3)
            } else if isSelected && !isCorrect {
                return Color(red: 0.85, green: 0.2, blue: 0.3)
            }
        }
        return isSelected ? Color(red: 0.95, green: 0.8, blue: 0.1) : Color.white.opacity(0.3)
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                if showExplanation {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : (isSelected ? "xmark.circle.fill" : "circle"))
                        .foregroundColor(isCorrect ? .white : (isSelected ? .white : .gray))
                        .font(.system(size: 20))
                } else {
                    Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                        .foregroundColor(isSelected ? Color(red: 0.95, green: 0.8, blue: 0.1) : .gray)
                        .font(.system(size: 20))
                }
                
                Text(text)
                    .font(.custom("Mexicana", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor)
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .disabled(showExplanation)
    }
}
