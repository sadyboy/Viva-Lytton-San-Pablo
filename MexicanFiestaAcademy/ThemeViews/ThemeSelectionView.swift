import SwiftUI

struct ThemeSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    @StateObject private var themeManager = ThemeManager.shared
    @State private var showUnlockAlert = false
    @State private var selectedTheme: Theme?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.85, green: 0.2, blue: 0.3),
                        Color(red: 1.0, green: 0.6, blue: 0.0),
                        Color(red: 0.95, green: 0.8, blue: 0.1)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        // Header
                        VStack(spacing: 12) {
                            Text("🎨")
                                .font(.system(size: 80))
                                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                            
                            Text("Elige tu tema")
                                .font(.custom("Mexicana", size: 32))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                            
                            Text("Personaliza la apariencia de tu app")
                                .font(.custom("Mexicana", size: 18))
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.2))
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        )
                        .padding(.horizontal)
                        
                        // Themes Grid
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(ThemeManager.allThemes) { theme in
                                ThemeCard(
                                    theme: theme,
                                    isSelected: themeManager.currentTheme.id == theme.id,
                                    isUnlocked: themeManager.isThemeUnlocked(theme.id),
                                    userLevel: appState.userProgress.level,
                                    userCoins: 0  // TODO: Add coins system
                                ) {
                                    selectTheme(theme)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Info Section
                        VStack(spacing: 16) {
                            Text("💡 Cómo desbloquear temas")
                                .font(.custom("Mexicana", size: 20))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                            
                            HStack(spacing: 20) {
                                VStack(spacing: 8) {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(Color(red: 0.95, green: 0.8, blue: 0.1))
                                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                                    
                                    Text("Sube de nivel")
                                        .font(.custom("Mexicana", size: 12))
                                        .foregroundColor(.white)
                                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                                }
                                
                                VStack(spacing: 8) {
                                    Image(systemName: "trophy.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.3))
                                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                                    
                                    Text("Completa logros")
                                        .font(.custom("Mexicana", size: 12))
                                        .foregroundColor(.white)
                                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                                }
                                
                                VStack(spacing: 8) {
                                    Image(systemName: "gamecontroller.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.3))
                                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                                    
                                    Text("Juega más")
                                        .font(.custom("Mexicana", size: 12))
                                        .foregroundColor(.white)
                                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.2))
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        )
                        .padding(.horizontal)
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Temas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Atrás")
                        }
                        .font(.custom("Mexicana", size: 16))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.3))
                                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                        )
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color(red: 0.95, green: 0.8, blue: 0.1))
                        Text("Nivel \(appState.userProgress.level)")
                            .font(.custom("Mexicana", size: 14))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.2))
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                    )
                }
            }
        }
        .alert("Tema bloqueado", isPresented: $showUnlockAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            if let theme = selectedTheme {
                Text(theme.unlockRequirement)
                    .font(.custom("Mexicana", size: 16))
            }
        }
    }
    
    private func selectTheme(_ theme: Theme) {
        if themeManager.isThemeUnlocked(theme.id) {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                themeManager.setTheme(theme)
            }
        } else {
            selectedTheme = theme
            showUnlockAlert = true
        }
    }
}

// MARK: - Theme Card


// MARK: - Theme Manager and Models


let mexicanFiestaTheme = Theme(
    id: "mexican_fiesta",
    name: "Fiesta Mexicana",
    emoji: "🌮",
    colors: ThemeColors(
        primary: Color(red: 0.85, green: 0.2, blue: 0.3),
        secondary: Color(red: 1.0, green: 0.6, blue: 0.0),
        accent: Color(red: 0.95, green: 0.8, blue: 0.1),
        background: Color(red: 0.98, green: 0.98, blue: 1.0),
        text: Color.primary
    ),
    unlockLevel: 1,
    unlockCoins: 0,
    unlockRequirement: "Tema disponible desde el inicio"
)

let sunsetTheme = Theme(
    id: "sunset",
    name: "Atardecer",
    emoji: "🌅",
    colors: ThemeColors(
        primary: Color(red: 0.9, green: 0.3, blue: 0.2),
        secondary: Color(red: 1.0, green: 0.5, blue: 0.0),
        accent: Color(red: 1.0, green: 0.8, blue: 0.0),
        background: Color(red: 0.98, green: 0.95, blue: 0.9),
        text: Color.primary
    ),
    unlockLevel: 5,
    unlockCoins: 100,
    unlockRequirement: "Necesitas nivel 5 y 100 monedas para desbloquear este tema"
)

let oceanTheme = Theme(
    id: "ocean",
    name: "Océano Azul",
    emoji: "🌊",
    colors: ThemeColors(
        primary: Color(red: 0.1, green: 0.4, blue: 0.8),
        secondary: Color(red: 0.2, green: 0.6, blue: 0.9),
        accent: Color(red: 0.4, green: 0.8, blue: 1.0),
        background: Color(red: 0.95, green: 0.98, blue: 1.0),
        text: Color.primary
    ),
    unlockLevel: 10,
    unlockCoins: 200,
    unlockRequirement: "Necesitas nivel 10 y 200 monedas para desbloquear este tema"
)

let forestTheme = Theme(
    id: "forest",
    name: "Bosque Verde",
    emoji: "🌲",
    colors: ThemeColors(
        primary: Color(red: 0.2, green: 0.6, blue: 0.3),
        secondary: Color(red: 0.3, green: 0.7, blue: 0.4),
        accent: Color(red: 0.8, green: 0.9, blue: 0.3),
        background: Color(red: 0.95, green: 0.98, blue: 0.95),
        text: Color.primary
    ),
    unlockLevel: 15,
    unlockCoins: 300,
    unlockRequirement: "Necesitas nivel 15 y 300 monedas para desbloquear este tema"
)

let desertTheme = Theme(
    id: "desert",
    name: "Desierto",
    emoji: "🏜️",
    colors: ThemeColors(
        primary: Color(red: 0.8, green: 0.6, blue: 0.3),
        secondary: Color(red: 0.9, green: 0.7, blue: 0.4),
        accent: Color(red: 1.0, green: 0.8, blue: 0.5),
        background: Color(red: 1.0, green: 0.98, blue: 0.95),
        text: Color.primary
    ),
    unlockLevel: 20,
    unlockCoins: 400,
    unlockRequirement: "Necesitas nivel 20 y 400 monedas para desbloquear este tema"
)

let festivalTheme = Theme(
    id: "festival",
    name: "Festival",
    emoji: "🎪",
    colors: ThemeColors(
        primary: Color(red: 0.6, green: 0.2, blue: 0.8),
        secondary: Color(red: 0.8, green: 0.4, blue: 0.9),
        accent: Color(red: 1.0, green: 0.6, blue: 0.8),
        background: Color(red: 0.98, green: 0.95, blue: 1.0),
        text: Color.primary
    ),
    unlockLevel: 25,
    unlockCoins: 500,
    unlockRequirement: "Necesitas nivel 25 y 500 monedas para desbloquear este tema"
)
