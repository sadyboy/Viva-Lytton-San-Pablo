import Foundation
import SwiftUI


// MARK: - Main Tab View
struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
        
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                
                LearningView()
                    .tag(1)
                
                GamesView()
                    .tag(2)
                
                ProfileView()
                    .tag(3)
            }
            .environmentObject(appState)
            // Custom Tab Bar
            CustomTabBar(selectedTab: $selectedTab)
                .padding(.bottom, 10)
        }
        .onAppear {
            appState.userProgress.updateStreak()
        }
    }
}
