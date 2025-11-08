import Foundation
import SwiftUI

struct CategoryCard: View {
    let emoji: String
    let title: String
    let color: Color
    let progress: Double
    @EnvironmentObject var appState: AppState
    var body: some View {
        NavigationLink(destination: LearningView()) {
            VStack(alignment: .leading, spacing: 12) {
                Text(emoji)
                    .font(.system(size: 50))
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                
                Text(title)
                    .font(.custom("Mexicana", size: 20))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
                
                // Progress bar with casino style
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.black.opacity(0.3))
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            LinearGradient(
                                colors: [color, color.opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: CGFloat(progress) * 140, height: 8)
                        .shadow(color: color.opacity(0.6), radius: 2, x: 0, y: 1)
                }
                
                Text("\(Int(progress * 100))% completado")
                    .font(.custom("Mexicana", size: 13))
                    .foregroundColor(.white.opacity(0.9))
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
            }
            .padding(20)
            .frame(width: 180)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [
                                color.opacity(0.6),
                                color.opacity(0.3)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: color.opacity(0.5), radius: 15, x: 0, y: 8)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
        }
    }
}
