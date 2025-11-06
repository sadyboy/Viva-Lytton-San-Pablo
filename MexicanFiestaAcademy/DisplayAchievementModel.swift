import Foundation
import SwiftUI
// MARK: - Achievement Card
struct DisplayAchievement: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let description: String
    let isUnlocked: Bool
    let color: Color
}
