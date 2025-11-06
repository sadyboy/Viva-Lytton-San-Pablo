import Foundation
import SwiftUI

struct Theme: Identifiable {
    let id: String
    let name: String
    let emoji: String
    let colors: ThemeColors
    let unlockLevel: Int
    let unlockCoins: Int
    let unlockRequirement: String
}
