import Foundation
import SwiftUI

struct CompletionViews: View {
    let score: Int
    let maxScore: Int
//    let lessonTitle: String
    let onDismiss: () -> Void
    @EnvironmentObject var appState: AppState
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
                    Text("Lesson Completed!")
                        .font(.custom("Mexicana", size: 32))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                    
//                    Text(lessonTitle)
//                        .font(.custom("Mexicana", size: 20))
//                        .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
//                        .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
                }
                
                VStack(spacing: 20) {
                    Text("\(percentage)%")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                    
                    Text("\(score) points of \(maxScore)")
                        .font(.custom("Mexicana", size: 18))
                        .foregroundColor(.white.opacity(0.9))
                        .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
                    
                    HStack(spacing: 20) {
                        StatBadge(icon: "⭐", title: "Points", value: "\(score)")
                        StatBadge(icon: "🎯", title: "Accuracy", value: "\(percentage)%")
                        StatBadge(icon: "🏆", title: "Achievement", value: "Completed")
                    }
                }
                
                Button(action: onDismiss) {
                    Text("Continue to Menu")
                        .font(.custom("Mexicana", size: 18))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 1.0, green: 0.8, blue: 0.0))
                                .shadow(color: .black.opacity(0.4), radius: 8, x: 0, y: 4)
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
                                Color(red: 0.2, green: 0.2, blue: 0.2),
                                Color(red: 0.3, green: 0.3, blue: 0.3),
                                Color(red: 0.4, green: 0.4, blue: 0.4)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .black.opacity(0.6), radius: 20, x: 0, y: 10)
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
