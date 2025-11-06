import Foundation
import SwiftUI
struct ProfileStatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .shadow(color: color.opacity(0.6), radius: 3, x: 0, y: 2)
            
            Text(value)
                .font(.custom("Mexicana", size: 24))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
            
            Text(label)
                .font(.custom("Mexicana", size: 13))
                .foregroundColor(.white.opacity(0.9))
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [
                            color.opacity(0.7),
                            color.opacity(0.4)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: color.opacity(0.5), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}
