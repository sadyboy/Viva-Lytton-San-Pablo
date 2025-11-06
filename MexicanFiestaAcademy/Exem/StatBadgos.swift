import Foundation
import SwiftUI

// MARK: - Stat Badge
struct StatBadgos: View {
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
                .fill(Color.white.opacity(0.1))
        )
    }
}
