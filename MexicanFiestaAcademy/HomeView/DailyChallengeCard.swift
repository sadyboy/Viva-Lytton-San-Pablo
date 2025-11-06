import Foundation
import SwiftUI

// MARK: - Daily Challenge Card
struct DailyChallengeCard: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationLink(destination: LearningView()) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.8, green: 0.6, blue: 0.0),
                                Color(red: 1.0, green: 0.8, blue: 0.0),
                                Color(red: 0.9, green: 0.7, blue: 0.0)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: Color(red: 0.8, green: 0.6, blue: 0.0).opacity(0.6), radius: 15, x: 0, y: 8)

                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("🎯")
                                .font(.system(size: 30))
                                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                                Text("Daily Challenge")
                                .font(.custom("Mexicana", size: 22))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                                }

                                Text("Complete 3 lessons today")
                                .font(.custom("Mexicana", size: 16))
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                        
                        HStack(spacing: 8) {
                            ForEach(0..<3) { index in
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 24, height: 24)
                                    .overlay(
                                        index < 1 ?
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.white)
                                            .font(.system(size: 12, weight: .bold))
                                            .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
                                        : nil
                                    )
                            }
                        }
                        .padding(.top, 4)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 36))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
                }
                .padding(20)
            }
            .frame(height: 140)
        }
    }
}
