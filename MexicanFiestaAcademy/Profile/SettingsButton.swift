import Foundation
import SwiftUI

// MARK: - Settings Button
struct SettingsButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(color.opacity(0.8))
                            .shadow(color: color.opacity(0.5), radius: 3, x: 0, y: 2)
                    )
                
                Text(title)
                    .font(.custom("Mexicana", size: 18))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white.opacity(0.8))
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.1))
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
        }
    }
}
