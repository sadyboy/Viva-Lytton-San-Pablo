import SwiftUI

struct QuestionCard: View {
    let question: Question
    @Binding var selectedAnswer: Int?
    @Binding var showResult: Bool
    @Binding var isCorrect: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                Text("❓ Question")
                    .font(.custom("Mexicana", size: 18))
                    .foregroundColor(Color(red: 0.95, green: 0.8, blue: 0.1))
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                
                Text(question.text)
                    .font(.custom("Mexicana", size: 22))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.15))
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            
            VStack(spacing: 12) {
                ForEach(0..<question.options.count, id: \.self) { index in
                    AnswerButton(
                        text: question.options[index],
                        isSelected: selectedAnswer == index,
                        isCorrect: index == question.correctAnswer,
                        showResult: showResult
                    ) {
                        if !showResult {
                            selectedAnswer = index
                            isCorrect = index == question.correctAnswer
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                showResult = true
                            }
                        }
                    }
                }
            }
            if showResult {
                VStack(spacing: 12) {
                    Text("💡 Explanation")
                        .font(.custom("Mexicana", size: 18))
                        .foregroundColor(Color(red: 0.95, green: 0.8, blue: 0.1))
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    
                    Text(question.explanation)
                        .font(.custom("Mexicana", size: 16))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 0.2, green: 0.6, blue: 0.3).opacity(0.3))
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(red: 0.2, green: 0.6, blue: 0.3).opacity(0.5), lineWidth: 1)
                )
            }
        }
        .padding(.horizontal)
    }
}

struct AnswerButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let showResult: Bool
    let action: () -> Void
    
    var backgroundColor: Color {
        if showResult {
            if isSelected {
                return isCorrect ?
                    Color(red: 0.2, green: 0.6, blue: 0.3) :
                    Color(red: 0.85, green: 0.2, blue: 0.3)
            } else if isCorrect {
                return Color(red: 0.2, green: 0.6, blue: 0.3).opacity(0.7)
            }
        }
        return isSelected ?
            Color(red: 0.95, green: 0.8, blue: 0.1).opacity(0.3) :
            Color.white.opacity(0.1)
    }
    
    var borderColor: Color {
        if showResult {
            if isSelected {
                return isCorrect ?
                    Color(red: 0.2, green: 0.6, blue: 0.3) :
                    Color(red: 0.85, green: 0.2, blue: 0.3)
            } else if isCorrect {
                return Color(red: 0.2, green: 0.6, blue: 0.3)
            }
        }
        return isSelected ?
            Color(red: 0.95, green: 0.8, blue: 0.1) :
            Color.white.opacity(0.3)
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                if showResult {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : (isSelected ? "xmark.circle.fill" : "circle"))
                        .foregroundColor(isCorrect ? .white : (isSelected ? .white : .gray))
                        .font(.system(size: 22))
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                } else {
                    Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                        .foregroundColor(isSelected ? Color(red: 0.95, green: 0.8, blue: 0.1) : .gray)
                        .font(.system(size: 22))
                }
                
                Text(text)
                    .font(.custom("Mexicana", size: 17))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundColor)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
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

// MARK: - Enhanced Completion View
struct CompletionView: View {
    let score: Int
    let maxScore: Int
    let lessonTitle: String
    let onDismiss: () -> Void
    
    @State private var animateElements = false
    
    var percentage: Int {
        return Int((Double(score) / Double(maxScore)) * 100)
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("🎉")
                    .font(.system(size: 80))
                    .scaleEffect(animateElements ? 1.2 : 1.0)
                
                VStack(spacing: 16) {
                    Text("Lection Completed!")
                        .font(.custom("Mexicana", size: 32))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
                    
                    Text(lessonTitle)
                        .font(.custom("Mexicana", size: 20))
                        .foregroundColor(Color(red: 0.95, green: 0.8, blue: 0.1))
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                }
                
                VStack(spacing: 20) {
                    Text("\(percentage)%")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
                    
                    Text("\(score) points of \(maxScore)")
                    .font(.custom("Mexicana", size: 18))
                    .foregroundColor(.white.opacity(0.9))
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)

                    HStack(spacing: 20) {
                    StatBadge(icon: "⭐", title: "Points", value: "\(score)")
                    StatBadge(icon: "🎯", title: "Accuracy", value: "\(percentage)%")
                    StatBadge(icon: "🏆", title: "Success", value: "Completed")
                    }
                    }

                    Button(action: onDismiss) {
                    Text("Continue to Menu")
                        .font(.custom("Mexicana", size: 18))
                        .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.3))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                        )
                }
                .padding(.horizontal, 40)
            }
            .padding(40)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.85, green: 0.2, blue: 0.3),
                                Color(red: 1.0, green: 0.6, blue: 0.0),
                                Color(red: 0.95, green: 0.8, blue: 0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
            )
            .padding(.horizontal, 20)
            .scaleEffect(animateElements ? 1.0 : 0.8)
            .opacity(animateElements ? 1.0 : 0.0)
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
                animateElements = true
            }
        }
    }
}

// MARK: - Stat Badge
struct StatBadge: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(icon)
                .font(.system(size: 24))
            
            Text(title)
                .font(.custom("Mexicana", size: 12))
                .foregroundColor(.white.opacity(0.8))
            
            Text(value)
                .font(.custom("Mexicana", size: 14))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.2))
        )
    }
}

struct ConfettiViewe: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            ForEach(0..<50) { i in
                Text(["🎉", "🎊", "⭐", "🌟", "🎈", "🏆"].randomElement()!)
                    .font(.system(size: 20))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: animate ? UIScreen.main.bounds.height + 100 : -100
                    )
                    .animation(
                        Animation.spring(response: 0.8, dampingFraction: 0.6)
                            .delay(Double(i) * 0.05),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
    }
}
