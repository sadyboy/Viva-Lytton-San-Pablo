import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var animateCards = false

    private let casinoColors = [
        Color(red: 1.0, green: 0.8, blue: 0.0),
        Color(red: 0.9, green: 0.7, blue: 0.0),
        Color(red: 0.8, green: 0.6, blue: 0.0),
        Color(red: 0.2, green: 0.2, blue: 0.2),
        Color(red: 0.1, green: 0.1, blue: 0.1),
        Color(red: 0.0, green: 0.0, blue: 0.0)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
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

                VStack {
                    HStack {
                        Spacer()
                        Image(.cap)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .rotationEffect(.degrees(15))
                            .offset(x: 40, y: -100)
                            .opacity(0.3)
                    }
                    Spacer()
                    HStack {
                        Text("♠️")
                            .font(.system(size: 60))
                            .rotationEffect(.degrees(-10))
                            .offset(x: -30, y: 50)
                            .opacity(0.3)
                        Spacer()
                    }
                }
                .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 25) {
                    ScrollView(showsIndicators: false) {
                        HeaderSection()
                            .padding(.horizontal)

                        StatsSection()
                            .padding(.horizontal)

                        DailyChallengeCard()
                            .padding(.horizontal)

                        Text("Categorías")
                            .font(.custom("Mexicana", size: 28))
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0)) 
                            .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                CategoryCard(emoji: "💬", title: "Español", color: casinoColors[0], progress: 0.6)
                                CategoryCard(emoji: "🌎", title: "Geografía", color: casinoColors[1], progress: 0.3)
                                CategoryCard(emoji: "🎭", title: "Cultura", color: casinoColors[0], progress: 0.45)
                                CategoryCard(emoji: "🍽️", title: "Cocina", color: casinoColors[1], progress: 0.2)
                            }
                            .padding(.horizontal)
                        }

                        Text("Continue learning")
                            .font(.custom("Mexicana", size: 28))
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                            .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                            .padding(.horizontal)

                        VStack(spacing: 12) {
                            LessonCard(emoji: "dance", title: "Basic greetings", subtitle: "Hola, How are you?", difficulty: "Easy", duration: "5 min", completed: false, color: casinoColors[0])
                            LessonCard(emoji: "number", title: "Numbers 1-20", subtitle: "One, dos, three...", difficulty: "Easy", duration: "8 min", completed: false, color: casinoColors[1])
                            LessonCard(emoji: "food", title: "Colores", subtitle: "Red, green, blue...", difficulty: "Easy", duration: "6 min", completed: true, color: casinoColors[0])
                            }
                        .padding(.horizontal)

                        AchievementsPreview()
                            .padding(.horizontal)
                            .padding(.bottom, 120)
                    }
                    .padding(.top)
                }
                .navigationDestination(for: LessonNode.self) { lesson in
                    LessonDetailView(lesson: lesson)
                }
            }
            .navigationBarHidden(true)
        }
    }
}



// MARK: - Category Card


// MARK: - Lesson Card
struct LessonCard: View {
    let emoji: String
    let title: String
    let subtitle: String
    let difficulty: String
    let duration: String
    let completed: Bool
    let category: String = "General"
    let color: Color
    @EnvironmentObject var appState: AppState
    
    private var lesson: LessonNode {
        LessonNode(
            id: 1,
            category: category,
            emoji: emoji,
            title: title,
            description: subtitle,
            difficulty: .easy,
            isCompleted: completed,
            isLocked: false
        )
    }
    
    var body: some View {
        NavigationLink(value: lesson) {
            HStack(spacing: 16) {
                Image(emoji)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    colors: [color.opacity(0.7), color.opacity(0.4)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.custom("Mexicana", size: 18))
                        .foregroundColor(.white)
                    Text(subtitle)
                        .font(.custom("Mexicana", size: 14))
                        .foregroundColor(.white.opacity(0.9))
                    HStack(spacing: 8) {
                        Label(difficulty, systemImage: "chart.bar.fill")
                            .font(.custom("Mexicana", size: 11))
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Capsule().fill(Color.yellow.opacity(0.4)))
                        Label(duration, systemImage: "clock.fill")
                            .font(.custom("Mexicana", size: 11))
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Capsule().fill(Color.orange.opacity(0.4)))
                    }
                }
                
                Spacer()
                
                Image(systemName: completed ? "checkmark.circle.fill" : "arrow.right.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(
                        colors: [color.opacity(0.7), color.opacity(0.4)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle()) 
    }
}

// MARK: - Achievements Preview
struct AchievementsPreview: View {
    private let achievementColors = [
        Color(red: 1.0, green: 0.8, blue: 0.0),
        Color(red: 0.9, green: 0.7, blue: 0.0),
        Color(red: 0.8, green: 0.6, blue: 0.0),
        Color(red: 0.7, green: 0.5, blue: 0.0)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent achievements")
                    .font(.custom("Mexicana", size: 28))
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                
                Spacer()
                
                Button {
                    // Action
                } label: {
                    Text("")
                        .font(.custom("Mexicana", size: 16))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
//                        .background(
//                            Capsule()
//                                .fill(Color(red: 1.0, green: 0.8, blue: 0.0).opacity(0.6)) 
//                                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
//                        )
                }
            }
            
            HStack(spacing: 12) {
                AchievementBadge(emoji: "🏆", title: "First lesson", isLocked: false, color: achievementColors[0])
                AchievementBadge(emoji: "🔥", title: "Racha 7 días", isLocked: false, color: achievementColors[1])
                AchievementBadge(emoji: "⭐", title: "100 points", isLocked: false, color: achievementColors[2])
                AchievementBadge(emoji: "🎯", title: "Perfectionist", isLocked: true, color: achievementColors[3])
            }
        }
    }
}

struct AchievementBadge: View {
    let emoji: String
    let title: String
    let isLocked: Bool
    let color: Color
    @State private var showDetail = false
    
    var body: some View {
        Button {
            showDetail = true
        } label: {
            VStack(spacing: 8) {
                Text(emoji)
                    .font(.system(size: 40))
                    .grayscale(isLocked ? 1.0 : 0.0)
                    .opacity(isLocked ? 0.5 : 1.0)
                    .shadow(color: isLocked ? .clear : color.opacity(0.6), radius: 3, x: 0, y: 2)
                
                Text(title)
                    .font(.custom("Mexicana", size: 12))
                    .foregroundColor(isLocked ? .gray : .white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(height: 30)
                    .shadow(color: isLocked ? .clear : .black.opacity(0.4), radius: 1, x: 0, y: 1)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        isLocked
                        ? AnyShapeStyle(Color.gray.opacity(0.2))
                        : AnyShapeStyle(
                            LinearGradient(
                                colors: [color.opacity(0.7), color.opacity(0.4)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    )
                    .shadow(color: isLocked ? .clear : color.opacity(0.4), radius: 6, x: 0, y: 3)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isLocked ? Color.gray.opacity(0.4) : Color.white.opacity(0.3), lineWidth: 1)
            )
        }
        .alert(isPresented: $showDetail) {
            Alert(
                title: Text(emoji + " " + title),
                message: Text(isLocked ? "Continue playing to unlock this achievement" : "Logro unlocked!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
