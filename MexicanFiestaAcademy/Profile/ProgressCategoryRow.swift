import Foundation
import SwiftUI


struct ProgressCategoryRow: View {
    let emoji: String
    let title: String
    let progress: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(emoji)
                    .font(.system(size: 24))
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                
                Text(title)
                    .font(.custom("Mexicana", size: 16))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
                
                Spacer()
                
                Text("\(Int(progress * 100))%")
                    .font(.custom("Mexicana", size: 16))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black.opacity(0.4))
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            LinearGradient(
                                colors: [color, color.opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * progress)
                        .shadow(color: color.opacity(0.6), radius: 2, x: 0, y: 1)
                }
            }
            .frame(height: 10)
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
