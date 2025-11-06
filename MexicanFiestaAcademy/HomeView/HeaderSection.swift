import Foundation
import SwiftUI

// MARK: - Header Section
struct HeaderSection: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("¡Hola!")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                
                Text(appState.currentUser?.name ?? "Amigo")
                    .font(.custom("Mexicana", size: 32))
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
            }
            
            Spacer()
            
            // Avatar and streak
            HStack(spacing: 12) {
                // Streak
                HStack(spacing: 4) {
                    Text("🔥")
                        .font(.system(size: 20))
                        .shadow(color: .yellow.opacity(0.5), radius: 2, x: 0, y: 1)
                    Text("\(appState.userProgress.streakDays)")
                        .font(.custom("Mexicana", size: 18))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(red: 1.0, green: 0.8, blue: 0.0).opacity(0.3))
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 1.0, green: 0.8, blue: 0.0).opacity(0.5), lineWidth: 1)
                )
                
                // Avatar
                
                if let name =  appState.currentUser?.avatar {
                    Text(name)
                        .font(.system(size: 40))
                        .frame(width: 60, height: 60)
                }
                Image(.cap)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .background(
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 1.0, green: 0.8, blue: 0.0),
                                        Color(red: 0.9, green: 0.7, blue: 0.0)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 3)
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                    )
            }
        }
    }
}
