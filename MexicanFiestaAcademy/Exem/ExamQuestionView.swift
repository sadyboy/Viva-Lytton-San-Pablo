import Foundation
import SwiftUI

struct ExamQuestionView: View {
    @ObservedObject var examManager: ExamManager
    @State private var showConfirmSubmit = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.1, blue: 0.3),
                    Color(red: 0.2, green: 0.2, blue: 0.5)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Custom Header
                HStack {
                    Button {
                        showConfirmSubmit = true
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Go out")
                        }
                        .font(.custom("Mexicana", size: 16))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.2))
                                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        )
                    }
                    
                    Spacer()
                    
                    // Progress
                    VStack(spacing: 4) {
                        Text("Ask \(examManager.currentQuestionIndex + 1)/\(examManager.totalQuestions)")
                            .font(.custom("Mexicana", size: 14))
                            .foregroundColor(.white.opacity(0.9))
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.white.opacity(0.2))
                                .frame(height: 6)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(
                                    LinearGradient(
                                        colors: [Color(red: 0.95, green: 0.8, blue: 0.1), Color(red: 1.0, green: 0.6, blue: 0.0)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: CGFloat(examManager.currentQuestionIndex + 1) / CGFloat(examManager.totalQuestions) * 120, height: 6)
                        }
                        .frame(width: 120)
                    }
                    
                    Spacer()
                    
                    // Timer
                    HStack(spacing: 6) {
                        Image(systemName: examManager.timeRemaining < 60 ? "clock.badge.exclamationmark.fill" : "clock.fill")
                            .foregroundColor(examManager.timeRemaining < 60 ? .red : Color(red: 0.95, green: 0.8, blue: 0.1))
                        
                        Text(timeString(examManager.timeRemaining))
                            .font(.custom("Mexicana", size: 18))
                            .foregroundColor(examManager.timeRemaining < 60 ? .red : .white)
                            .monospacedDigit()
                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(examManager.timeRemaining < 60 ? Color.red.opacity(0.3) : Color.white.opacity(0.2))
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                    )
                }
                .padding()
                
                ScrollView {
                    if let question = examManager.currentQuestion {
                        VStack(spacing: 24) {
                            // Question Card
                            VStack(spacing: 16) {
                                Text("❓ Ask")
                                    .font(.custom("Mexicana", size: 16))
                                    .foregroundColor(Color(red: 0.95, green: 0.8, blue: 0.1))
                                
                                Text(question.text)
                                    .font(.custom("Mexicana", size: 20))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(4)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.1))
                                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                            
                            // Options
                            VStack(spacing: 12) {
                                ForEach(0..<question.options.count, id: \.self) { index in
                                    ExamAnswerButton(
                                        text: question.options[index],
                                        isSelected: examManager.selectedAnswer == index,
                                        isCorrect: examManager.showExplanation && index == question.correctAnswer,
                                        showExplanation: examManager.showExplanation
                                    ) {
                                        if !examManager.showExplanation {
                                            examManager.selectAnswer(index)
                                        }
                                    }
                                }
                            }
                            
                            // Explanation
                            if examManager.showExplanation {
                                VStack(spacing: 12) {
                                    Text("💡 Explanation")
                                        .font(.custom("Mexicana", size: 16))
                                        .foregroundColor(Color(red: 0.95, green: 0.8, blue: 0.1))
                                    
                                    Text(question.explanation)
                                        .font(.custom("Mexicana", size: 16))
                                        .foregroundColor(.white.opacity(0.9))
                                        .multilineTextAlignment(.center)
                                        .lineSpacing(4)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color(red: 0.2, green: 0.6, blue: 0.3).opacity(0.3))
                                )
                            }
                        }
                        .padding()
                    }
                }
                
                // Navigation buttons
                HStack(spacing: 12) {
                    if examManager.currentQuestionIndex > 0 {
                        Button {
                            examManager.previousQuestion()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Former")
                            }
                            .font(.custom("Mexicana", size: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.2))
                                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                            )
                        }
                    }
                    
                    Button {
                        if examManager.currentQuestionIndex < examManager.totalQuestions - 1 {
                            examManager.nextQuestion()
                        } else {
                            showConfirmSubmit = true
                        }
                    } label: {
                        HStack {
                            Text(examManager.currentQuestionIndex < examManager.totalQuestions - 1 ? "Next": "Finish")
                            Image(systemName: "chevron.right")
                        }
                        .font(.custom("Mexicana", size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 0.95, green: 0.8, blue: 0.1),
                                            Color(red: 1.0, green: 0.6, blue: 0.0)
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                        )
                    }
                    .disabled(!examManager.showExplanation && examManager.selectedAnswer == nil)
                    .opacity((!examManager.showExplanation && examManager.selectedAnswer == nil) ? 0.5 : 1.0)
                }
                .padding()
            }
        }
        .alert("Exit the exam?", isPresented: $showConfirmSubmit) {
            Button("Continue", role: .cancel) { }
            Button("Exit", role: .destructive) {
                dismiss()
                
            }
        } message: {
            Text("Your progress will be lost if you exit the exam.")
            
        }
    }
    
    private func timeString(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
