import Foundation
import SwiftUI

struct ExamCompletionView: View {
    let score: Int
    let totalQuestions: Int
    let percentage: Int
    let timeUsed: TimeInterval
    let onDismiss: () -> Void
    @EnvironmentObject var appState: AppState
    @State private var showCertificate = false
    @State private var animateScore = false
    
    var isPassed: Bool {
        percentage >= 70
    }
    
    var grade: String {
        switch percentage {
            case 90...100: return "Excellent! 🏆"
            case 80..<90: return "Very Good! ⭐"
            case 70..<80: return "Passed! ✅"
            case 60..<70: return "Good 👍"
            default: return "Keep Practicing 💪"
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: isPassed ? [
                    Color(red: 0.2, green: 0.6, blue: 0.3),
                    Color(red: 0.3, green: 0.7, blue: 0.4),
                    Color(red: 0.4, green: 0.8, blue: 0.5)
                ] : [
                    Color(red: 0.85, green: 0.2, blue: 0.3),
                    Color(red: 1.0, green: 0.4, blue: 0.2),
                    Color(red: 1.0, green: 0.6, blue: 0.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Confetti effect for passing
            if isPassed {
                VStack {
                    ForEach(0..<20) { i in
                        Text(["🎉", "🎊", "🌟", "⭐", "🎈", "🏆"].randomElement()!)
                            .font(.system(size: 24))
                            .position(
                                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                y: CGFloat.random(in: -100...0)
                            )
                            .animation(
                                Animation.spring(response: 0.6, dampingFraction: 0.8)
                                    .delay(Double(i) * 0.1),
                                value: isPassed
                            )
                    }
                }
            }
            
            VStack(spacing: 30) {
                Text(isPassed ? "🎓" : "📝")
                    .font(.system(size: 100))
                    .scaleEffect(animateScore ? 1.1 : 1.0)
                    .animation(.spring(response: 0.6, dampingFraction: 0.8), value: animateScore)
                
                VStack(spacing: 16) {
                    Text(grade)
                        .font(.custom("Mexicana", size: 32))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
                    
                    Text("\(score) of \(totalQuestions) correct")
                        .font(.custom("Mexican", size: 20))
                        .foregroundColor(.white.opacity(0.9))
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                    
                    Text("\(percentage)%")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
                        .scaleEffect(animateScore ? 1.2 : 1.0)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: animateScore)
                }
                
                VStack(spacing: 20) {
                    // Stats
                    HStack(spacing: 20) {
                        StatBadgos(icon: "⏱️", title: "Time", value: timeString(timeUsed))
                        StatBadgos(icon: "⭐", title: "Points", value: "\(score * 100)")
                        StatBadgos(icon: "📊", title: "Accuracy", value: "\(percentage)%")
                    }
                    
                    if isPassed {
                        Button {
                            showCertificate = true
                        } label: {
                            HStack {
                                Image(systemName: "doc.text.fill")
                                Text("View Digital Certificate")
                            }
                            .font(.custom("Mexican", size: 18))
                            .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.3))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                            )
                        }
                        .padding(.horizontal, 40)
                    }
                }
                
                Button(action: onDismiss) {
                    Text("Continue to Profile")
                        .font(.custom("Mexicana", size: 18))
                        .foregroundColor(isPassed ? Color(red: 0.2, green: 0.6, blue: 0.3) : Color(red: 0.85, green: 0.2, blue: 0.3))
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
            .padding()
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                animateScore = true
            }
        }
        .sheet(isPresented: $showCertificate) {
            CertificateView(percentage: percentage, score: score, totalQuestions: totalQuestions)
        }
    }
    
    private func timeString(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
