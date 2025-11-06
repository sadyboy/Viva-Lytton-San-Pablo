import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @State private var showEditProfile = false
    @State private var showSettings = false
    @State private var showStatistics = false
    @State private var showThemeSelection = false
    @State private var showExamMode = false
    
    private let casinoColors = [
        Color(red: 1.0, green: 0.8, blue: 0.0),
        Color(red: 0.9, green: 0.7, blue: 0.0),  
        Color(red: 0.8, green: 0.6, blue: 0.0),
        Color(red: 0.2, green: 0.2, blue: 0.2),
        Color(red: 0.1, green: 0.1, blue: 0.1),  
        Color(red: 0.0, green: 0.0, blue: 0.0)   
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 25) {
                // Header with avatar
                VStack(spacing: 16) {
                    ZStack(alignment: .bottomTrailing) {
                        if let name = appState.currentUser?.name {
                            Text(name)
                                .font(.system(size: 80))
                                .frame(width: 140, height: 140)
                        }
                        Image(.cap)
                            .resizable()
                            .frame(width: 140, height: 140)
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
                                    .shadow(color: Color(red: 1.0, green: 0.8, blue: 0.0).opacity(0.6), radius: 15, x: 0, y: 8)
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.3), lineWidth: 3)
                            )
                        
                        Button {
                            showEditProfile = true
                        } label: {
                            Image(systemName: "pencil.circle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color(red: 1.0, green: 0.8, blue: 0.0))
                                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
                                )
                        }
                        .offset(x: -5, y: -5)
                    }
                    
                    VStack(spacing: 8) {
                        Text(appState.currentUser?.name ?? "Friend")
                            .font(.custom("Mexicana", size: 28))
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                            .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "trophy.fill")
                                .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                            Text("Level \(appState.userProgress.level)")
                                .font(.custom("Mexicana", size: 16))
                                .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(Color(red: 1.0, green: 0.8, blue: 0.0).opacity(0.3))
                                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color(red: 1.0, green: 0.8, blue: 0.0).opacity(0.5), lineWidth: 1)
                        )
                    }
                }
                .padding(.top, 20)
                
                // Stats grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                    ProfileStatCard(
                    icon: "star.fill",
                    value: "\(appState.userProgress.totalScore)",
                    label: "Total points",
                    color: casinoColors[0]
                    )

                    ProfileStatCard(
                    icon: "flame.fill",
                    value: "\(appState.userProgress.streakDays)",
                    label: "Streak days",
                    color: casinoColors[1]
                    )

                    ProfileStatCard(
                    icon: "book.fill",
                    value: "\(appState.userProgress.completedLessons.count)",
                    label: "Lessons",
                    color: casinoColors[0]
                    )

                    ProfileStatCard(
                    icon: "trophy.fill",
                    value: "\(appState.userProgress.achievements.filter { $0.isUnlocked }.count)/\(appState.userProgress.achievements.count)",
                    label: "Achievements",
                    color: casinoColors[1]
                    )
                }
                .padding(.horizontal)
                
                // Progress section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Progress by category")
                        .font(.custom("Mexicana", size: 24))
                        .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        ProgressCategoryRow(
                        emoji: "💬",
                        title: "Spanish",
                        progress: 0.6,
                        color: casinoColors[0]
                        )

                        ProgressCategoryRow(
                        emoji: "🌎",
                        title: "Geography",
                        progress: 0.3,
                        color: casinoColors[1]
                        )

                        ProgressCategoryRow(
                        emoji: "🎭",
                        title: "Culture",
                        progress: 0.45,
                        color: casinoColors[0]
                        )

                        ProgressCategoryRow(
                        emoji: "🍽️",
                        title: "Kitchen",
                        progress: 0.2,
                        color: casinoColors[1]
                        )
                        }
                    .padding(.horizontal)
                }
                
                // Achievements
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Your achievements")
                            .font(.custom("Mexicana", size: 24))
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                            .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                        
                        Spacer()
                        
                        Button {
                            // Show all achievements
                        } label: {
                            Text("All")
                                .font(.custom("Mexicana", size: 16))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    Capsule()
                                        .fill(Color(red: 1.0, green: 0.8, blue: 0.0).opacity(0.7))
                                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                                )
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(sampleAchievements) { achievement in
                                AchievementCard(achievement: achievement)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Settings buttons
                VStack(spacing: 12) {
                    SettingsButton(
                        icon: "paintbrush.fill",
                        title: "Temas",
                        color: casinoColors[0]
                    ) {
                        showThemeSelection = true
                    }
                    
                    SettingsButton(
                        icon: "doc.text.fill",
                        title: "Examen Final",
                        color: casinoColors[1]
                    ) {
                        showExamMode = true
                    }
                    
                    SettingsButton(
                        icon: "chart.bar.fill",
                        title: "Estadísticas",
                        color: casinoColors[0]
                    ) {
                        showStatistics = true
                    }
                    
//                    SettingsButton(
//                        icon: "gear",
//                        title: "Configuración",
//                        color: casinoColors[1]
//                    ) {
//                        showSettings = true
//                    }
//                    
//                    SettingsButton(
//                        icon: "bell.fill",
//                        title: "Notificaciones",
//                        color: casinoColors[0]
//                    ) {
//                        // Open notifications settings
//                    }
//                    
//                    SettingsButton(
//                        icon: "questionmark.circle.fill",
//                        title: "Ayuda y soporte",
//                        color: casinoColors[1]
//                    ) {
//                        // Open help
//                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 100)
            }
        }
        .background(
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
        )
        .sheet(isPresented: $showEditProfile) {
            EditProfileView()
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .sheet(isPresented: $showStatistics) {
            StatisticsView()
        }
        .sheet(isPresented: $showThemeSelection) {
            ThemeSelectionView()
        }
        .fullScreenCover(isPresented: $showExamMode) {
            ExamModeView()
        }
    }
    
    private var sampleAchievements: [DisplayAchievement] {
    [
        DisplayAchievement(emoji: "🏆", title: "First Lesson", description: "You completed your first lesson", isUnlocked: true, color: casinoColors[0]),
        DisplayAchievement(emoji: "🔥", title: "7-Day Streak", description: "You maintained a 7-day streak", isUnlocked: true, color: casinoColors[1]),
        DisplayAchievement(emoji: "⭐", title: "100 Points", description: "You reached 100 points", isUnlocked: true, color: casinoColors[0]),
        DisplayAchievement(emoji: "🎯", title: "Perfectionist", description: "Get 100% in 5 lessons", isUnlocked: false, color: casinoColors[1]),
        DisplayAchievement(emoji: "🌟", title: "Master", description: "Complete all categories", isUnlocked: false, color: casinoColors[0])
        ]
    }
}



// MARK: - Settings View
struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.1, green: 0.1, blue: 0.1),
                        Color(red: 0.2, green: 0.2, blue: 0.2)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                List {
                Section {
                Toggle("Notifications", isOn: .constant(true))
                Toggle("Sound", isOn: .constant(true))
                }
                .listRowBackground(Color.white.opacity(0.1))

                Section {
                Toggle("Daily Reminders", isOn: .constant(true))
                Picker("Daily Goal", selection: .constant(1)) {
                Text("5 minutes").tag(0)
                Text("10 minutes").tag(1)
                Text("15 minutes").tag(2)
                }
                }
                    .listRowBackground(Color.white.opacity(0.1))
                    
                    Section {
                    Button("Reset progress") {
                    //Action
                    }
                    .foregroundColor(.red)
                    }
                    .listRowBackground(Color.white.opacity(0.1))
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    }
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                    dismiss()
                    }
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                    }
            }
        }
    }
}

// MARK: - Statistics View
struct StatisticsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.1, green: 0.1, blue: 0.1),
                        Color(red: 0.2, green: 0.2, blue: 0.2)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
//                        Text("Statistics")
//                            .foregroundColor(.white)
//                            .font(.custom("Mexicana", size: 22))
                        // Overall Stats
                        VStack(alignment: .leading, spacing: 16) {
                            Text("General Statistics")
                                .font(.custom("Mexicana", size: 28))
                                .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                                .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                                .padding(.horizontal)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                            StatCards(
                            icon: "star.fill",
                            value: "\(appState.userProgress.totalScore)",
                            label: "Total Points",
                            color: Color(red: 1.0, green: 0.8, blue: 0.0),
                            subtitle: "from the beginning"
                            )

                            StatCards(
                            icon: "trophy.fill",
                            value: "Level \(appState.userProgress.level)",
                            label: "Your Level",
                            color: Color(red: 0.9, green: 0.7, blue: 0.0),
                            subtitle: "of ∞"
                            )

                            StatCards(
                            icon: "flame.fill",
                            value: "\(appState.userProgress.streakDays)",
                            label: "Streak Days",
                            color: Color(red: 1.0, green: 0.8, blue: 0.0),
                            subtitle: "consecutive"
                            )

                            StatCards(
                            icon: "book.fill",
                            value: "\(appState.userProgress.completedLessons.count)",
                            label: "Lessons",
                            color: Color(red: 0.9, green: 0.7, blue: 0.0),
                            subtitle: "completed"
                            )
                            }
                            .padding(.horizontal)
                            }
                        
                        // Progress Chart
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Progreso por categoría")
                                .font(.custom("Mexicana", size: 28))
                                .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                                .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                                .padding(.horizontal)
                            
                            VStack(spacing: 16) {
                                CategoryProgressBar(
                                    emoji: "💬",
                                    title: "Español",
                                    progress: 0.6,
                                    lessons: 12,
                                    completed: 7,
                                    color: Color(red: 1.0, green: 0.8, blue: 0.0)
                                )
                                
                                CategoryProgressBar(
                                    emoji: "🌎",
                                    title: "Geografía",
                                    progress: 0.3,
                                    lessons: 10,
                                    completed: 3,
                                    color: Color(red: 0.9, green: 0.7, blue: 0.0)
                                )
                                
                                CategoryProgressBar(
                                    emoji: "🎭",
                                    title: "Cultura",
                                    progress: 0.45,
                                    lessons: 15,
                                    completed: 7,
                                    color: Color(red: 1.0, green: 0.8, blue: 0.0)
                                )
                                
                                CategoryProgressBar(
                                    emoji: "🍽️",
                                    title: "Cocina",
                                    progress: 0.2,
                                    lessons: 8,
                                    completed: 2,
                                    color: Color(red: 0.9, green: 0.7, blue: 0.0)
                                )
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer(minLength: 20)
                    }
                    .padding(.vertical)
                }
            }
           
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                }
            }
        }
    }
}

// MARK: - Stat Card (for Statistics)
struct StatCards: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(.white)
                .shadow(color: color.opacity(0.6), radius: 3, x: 0, y: 2)
            
            Text(value)
                .font(.custom("Mexicana", size: 22))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
            
            VStack(spacing: 2) {
                Text(label)
                    .font(.custom("Mexicana", size: 12))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                
                Text(subtitle)
                    .font(.custom("Mexicana", size: 10))
                    .foregroundColor(.white.opacity(0.8))
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [
                            color.opacity(0.7),
                            color.opacity(0.4)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: color.opacity(0.5), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: - Category Progress Bar
struct CategoryProgressBar: View {
    let emoji: String
    let title: String
    let progress: Double
    let lessons: Int
    let completed: Int
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 8) {
                    Text(emoji)
                        .font(.system(size: 28))
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.custom("Mexicana", size: 18))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
                        
                        Text("\(completed) de \(lessons) lecciones")
                            .font(.custom("Mexicana", size: 12))
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    }
                }
                
                Spacer()
                
                Text("\(Int(progress * 100))%")
                    .font(.custom("Mexicana", size: 20))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.4))
                    
                    RoundedRectangle(cornerRadius: 10)
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
            .frame(height: 12)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
                .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppState())
}
