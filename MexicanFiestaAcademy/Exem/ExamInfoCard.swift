import Foundation
import SwiftUI

struct ExamInfoCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Text(icon)
                .font(.system(size: 40))
                .frame(width: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.custom("Mexicana", size: 18))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                
                Text(description)
                    .font(.custom("Mexicana", size: 14))
                    .foregroundColor(.white.opacity(0.9))
                    .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color.opacity(0.8))
                .shadow(color: color.opacity(0.4), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}
