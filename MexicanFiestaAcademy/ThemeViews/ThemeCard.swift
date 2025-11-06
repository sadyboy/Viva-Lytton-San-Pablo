import SwiftUI

struct ThemeCard: View {
    let theme: Theme
    let isSelected: Bool
    let isUnlocked: Bool
    let userLevel: Int
    let userCoins: Int
    let action: () -> Void
    
    var canUnlock: Bool {
        userLevel >= theme.unlockLevel && userCoins >= theme.unlockCoins
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 16) {
                // Theme preview
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [
                                    theme.colors.primary,
                                    theme.colors.secondary
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 140)
                        .shadow(color: theme.colors.primary.opacity(0.5), radius: 10, x: 0, y: 5)
                    
                    if !isUnlocked {
                        // Lock overlay
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black.opacity(0.7))
                            .frame(height: 140)
                        
                        VStack(spacing: 12) {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                            
                            if canUnlock {
                                Text("Toca para desbloquear")
                                    .font(.custom("Mexicana", size: 12))
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                            } else {
                                VStack(spacing: 6) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 12))
                                            .foregroundColor(userLevel >= theme.unlockLevel ? .green : .orange)
                                        Text("Nivel \(theme.unlockLevel)")
                                            .font(.custom("Mexicana", size: 12))
                                            .foregroundColor(userLevel >= theme.unlockLevel ? .green : .orange)
                                    }
                                    
                                    if theme.unlockCoins > 0 {
                                        HStack(spacing: 4) {
                                            Image(systemName: "dollarsign.circle.fill")
                                                .font(.system(size: 12))
                                                .foregroundColor(userCoins >= theme.unlockCoins ? .green : .orange)
                                            Text("\(theme.unlockCoins)")
                                                .font(.custom("Mexicana", size: 12))
                                                .foregroundColor(userCoins >= theme.unlockCoins ? .green : .orange)
                                        }
                                    }
                                }
                                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                            }
                        }
                    } else if isSelected {
                        // Selected checkmark
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(.white)
                                    .background(
                                        Circle()
                                            .fill(theme.colors.accent)
                                            .frame(width: 36, height: 36)
                                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                                    )
                                    .padding(12)
                            }
                        }
                        .frame(height: 140)
                    }
                    
                    // Theme emoji
                    VStack {
                        Text(theme.emoji)
                            .font(.system(size: 60))
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    }
                    .frame(height: 140)
                    .opacity(isUnlocked ? 1.0 : 0.3)
                }
                
                // Theme info
                VStack(spacing: 6) {
                    Text(theme.name)
                        .font(.custom("Mexicana", size: 18))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    
                    if isUnlocked {
                        Text(isSelected ? "🎉 Tema activo" : "✅ Disponible")
                            .font(.custom("Mexicana", size: 14))
                            .foregroundColor(isSelected ? Color(red: 0.95, green: 0.8, blue: 0.1) : Color(red: 0.2, green: 0.6, blue: 0.3))
                            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                    } else {
                        Text("🔒 Bloqueado")
                            .font(.custom("Mexicana", size: 14))
                            .foregroundColor(.white.opacity(0.7))
                            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                    }
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.25),
                                Color.white.opacity(0.15)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(
                        color: isSelected ? theme.colors.primary.opacity(0.6) : Color.black.opacity(0.3),
                        radius: isSelected ? 20 : 10,
                        x: 0,
                        y: isSelected ? 10 : 5
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(
                        isSelected ? theme.colors.accent : Color.white.opacity(0.3),
                        lineWidth: isSelected ? 4 : 2
                    )
            )
            .scaleEffect(isSelected ? 1.05 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}
