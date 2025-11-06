import Foundation
import SwiftUI

struct AchievementCard: View {
    let achievement: DisplayAchievement
    
    var body: some View {
        VStack(spacing: 12) {
            Text(achievement.emoji)
                .font(.system(size: 50))
                .grayscale(achievement.isUnlocked ? 0 : 1)
                .opacity(achievement.isUnlocked ? 1 : 0.5)
                .shadow(color: achievement.isUnlocked ? achievement.color.opacity(0.6) : .clear, radius: 3, x: 0, y: 2)
            
            VStack(spacing: 4) {
                Text(achievement.title)
                    .font(.custom("Mexicana", size: 16))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
                
                Text(achievement.description)
                    .font(.custom("Mexicana", size: 12))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
            }
            
            if achievement.isUnlocked {
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                    Text("Unlocked")
                        .font(.custom("Mexicana", size: 11))
                        .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                }
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
            } else {
                HStack(spacing: 4) {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.white.opacity(0.7))
                    Text("Locked")
                        .font(.custom("Mexicana", size: 11))
                        .foregroundColor(.white.opacity(0.7))
                }
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
            }
        }
        .frame(width: 160)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [
                            achievement.color.opacity(achievement.isUnlocked ? 0.6 : 0.3),
                            achievement.color.opacity(achievement.isUnlocked ? 0.3 : 0.1)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: achievement.color.opacity(achievement.isUnlocked ? 0.5 : 0.1), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(achievement.isUnlocked ? 0.3 : 0.1), lineWidth: 1)
        )
    }
}
