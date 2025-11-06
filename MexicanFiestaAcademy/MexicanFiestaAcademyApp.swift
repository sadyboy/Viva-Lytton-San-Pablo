import SwiftUI

@main
struct MexicanFiestaAcademyApp: App {
    @StateObject private var appState = AppState()
    @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted = false

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if isOnboardingCompleted {
            ContentView()
                .environmentObject(appState)
                .colorScheme(.dark)
                .environment(\.colorScheme, .dark)
                } else {
                    ZStack {
                        if appState.showBackground {
                            LinearGradient(
                                colors: [
                                    Color(red: 0.1, green: 0.1, blue: 0.1),
                                    Color(red: 0.2, green: 0.2, blue: 0.2),
                                    Color(red: 0.3, green: 0.3, blue: 0.3)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .ignoresSafeArea()

                        }
                        OnGameView(isOnboardingCompleted: $isOnboardingCompleted)
                        .environmentObject(appState)
                            
                    }
                }
            }
            .colorScheme(.dark)
            .environment(\.colorScheme, .dark)
        }
    }
}

// MARK: - App State
class AppState: ObservableObject {
    @Published var currentUser: User?
    @Published var userProgress: UserProgress
    @Published var isFirstLaunch: Bool
    @Published var showBackground: Bool = true

    init() {
        self.isFirstLaunch = !UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        self.userProgress = UserProgress()
        
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
        }
    }
}

// MARK: - User Model
struct User: Codable, Identifiable {
    let id: UUID
    var name: String
    var avatar: String
    var joinDate: Date
    
    init(name: String, avatar: String = "🌮") {
        self.id = UUID()
        self.name = name
        self.avatar = avatar
        self.joinDate = Date()
    }
}

// MARK: - User Progress
class UserProgress: ObservableObject {
    @Published var totalScore: Int
    @Published var level: Int
    @Published var achievements: [Achievement]
    @Published var completedLessons: [Int] = []
    @Published var streakDays: Int
    @Published var lastPlayDate: Date?
    
    init() {
        self.totalScore = UserDefaults.standard.integer(forKey: "totalScore")
        self.level = UserDefaults.standard.integer(forKey: "level")
        self.achievements = []
        self.completedLessons = []
        self.streakDays = UserDefaults.standard.integer(forKey: "streakDays")
        self.lastPlayDate = UserDefaults.standard.object(forKey: "lastPlayDate") as? Date
        
        if level == 0 {
            level = 1
        }
    }
    
    func addScore(_ points: Int) {
        totalScore += points
        UserDefaults.standard.set(totalScore, forKey: "totalScore")
        checkLevelUp()
    }
    
    func checkLevelUp() {
        let newLevel = (totalScore / 1000) + 1
        if newLevel > level {
            level = newLevel
            UserDefaults.standard.set(level, forKey: "level")
        }
    }
    
    func completeLesson(_ lessonId: Int) {
        if !completedLessons.contains(lessonId) {
            completedLessons.append(lessonId)
            addScore(100)
        }
    }
    
    func updateStreak() {
        let calendar = Calendar.current
        let today = Date()
        
        if let lastDate = lastPlayDate {
            if calendar.isDateInToday(lastDate) {
                return
            } else if calendar.isDateInYesterday(lastDate) {
                streakDays += 1
            } else {
                streakDays = 1
            }
        } else {
            streakDays = 1
        }
        
        lastPlayDate = today
        UserDefaults.standard.set(streakDays, forKey: "streakDays")
        UserDefaults.standard.set(lastPlayDate, forKey: "lastPlayDate")
    }
}

// MARK: - Achievement
struct Achievement: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let icon: String
    var isUnlocked: Bool
    let requiredScore: Int
    
    init(title: String, description: String, icon: String, requiredScore: Int) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.icon = icon
        self.isUnlocked = false
        self.requiredScore = requiredScore
    }
}
