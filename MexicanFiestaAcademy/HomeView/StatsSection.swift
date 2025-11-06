import Foundation
import SwiftUI

// MARK: - Stats Section
struct StatsSection: View {
    @EnvironmentObject var appState: AppState
    
    private let statColors = [
        Color(red: 1.0, green: 0.8, blue: 0.0),
        Color(red: 0.9, green: 0.7, blue: 0.0),
        Color(red: 0.8, green: 0.6, blue: 0.0)   
    ]
    
    var body: some View {
        HStack(spacing: 12) {
            StatCard(
            icon: "star.fill",
            value: "\(appState.userProgress.totalScore)",
            label: "Points",
            color: statColors[0]
            )

            StatCard(
            icon: "chart.line.uptrend.xyaxis",
            value: "Level \(appState.userProgress.level)",
            label: "You level",
            color: statColors[1]
            )

            StatCard(
            icon: "trophy.fill",
            value: "\(appState.userProgress.achievements.filter { $0.isUnlocked }.count)",
            label: "Logros",
            color: statColors[2]
            )
        }
    }
}
