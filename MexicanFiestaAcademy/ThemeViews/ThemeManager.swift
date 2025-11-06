import Foundation
import Combine
import SwiftUI

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var currentTheme: Theme = mexicanFiestaTheme
    
    static let allThemes: [Theme] = [
        mexicanFiestaTheme,
        sunsetTheme,
        oceanTheme,
        forestTheme,
        desertTheme,
        festivalTheme
    ]
    
    private var unlockedThemes: Set<String> = ["mexican_fiesta"]
    
    func setTheme(_ theme: Theme) {
        currentTheme = theme
        // Save to UserDefaults or other storage
    }
    
    func isThemeUnlocked(_ themeId: String) -> Bool {
        return unlockedThemes.contains(themeId)
    }
    
    func unlockTheme(_ themeId: String) {
        unlockedThemes.insert(themeId)
    }
}
