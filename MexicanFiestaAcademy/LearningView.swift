//
//  LearningView.swift
//  Mexican Fiesta Academy
//

import SwiftUI

struct LearningView: View {
    @State private var selectedCategory = 0
    
    private let categories = ["All", "Español", "Geografía", "Cultura", "Cocina"]
    
    private let casinoColors = [
        Color(red: 1.0, green: 0.8, blue: 0.0),
        Color(red: 0.9, green: 0.7, blue: 0.0),
        Color(red: 0.8, green: 0.6, blue: 0.0),
        Color(red: 0.7, green: 0.5, blue: 0.0),
        Color(red: 1.0, green: 0.9, blue: 0.3)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Learn")
                            .font(.custom("Mexicana", size: 36))
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                            .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                        
                        Text("Choose a lesson and start your adventure")
                            .font(.custom("Mexicana", size: 16))
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    }
                    .padding(.horizontal)
                    
                    // Category Filter
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(0..<categories.count, id: \.self) { index in
                                Button {
                                        selectedCategory = index
                                } label: {
                                    Text(categories[index])
                                        .font(.custom("Mexicana", size: 16))
                                        .fontWeight(selectedCategory == index ? .bold : .medium)
                                        .foregroundColor(selectedCategory == index ? .black : Color(red: 1.0, green: 0.8, blue: 0.0))
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(
                                            Capsule()
                                                .fill(selectedCategory == index ? Color(red: 1.0, green: 0.8, blue: 0.0) : Color.black.opacity(0.6))
                                                .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
                                        )
                                        .overlay(
                                            Capsule()
                                                .stroke(selectedCategory == index ? Color.black : Color(red: 1.0, green: 0.8, blue: 0.0), lineWidth: 2)
                                        )
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Learning Path
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Your learning route")
                            .font(.custom("Mexicana", size: 24))
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                            .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                            .padding(.horizontal)
                        
                        LearningPathView(selectedCategory: categories[selectedCategory])
                    }
                    
                    Spacer(minLength: 100)
                }
                .padding(.top)
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
            )
        }
        .background {
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.1, blue: 0.1),
                    Color(red: 0.2, green: 0.2, blue: 0.2)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        }
    }
}

// MARK: - Learning Path View
struct LearningPathView: View {
    let selectedCategory: String

    private let allLessons: [LessonNode] = [
        // Spanish
        LessonNode(id: 1, category: "Español", emoji: "👋", title: "Greetings", description: "Hello, How are you?", difficulty: .easy, isCompleted: true, isLocked: false),
        LessonNode(id: 2, category: "Español", emoji: "👤", title: "Introductions", description: "My name is...", difficulty: .easy, isCompleted: true, isLocked: false),
        LessonNode(id: 3, category: "Español", emoji: "🔢", title: "Numbers", description: "One, two, three", difficulty: .easy, isCompleted: false, isLocked: false),
        LessonNode(id: 4, category: "Español", emoji: "🎨", title: "Colors", description: "Red, blue, green", difficulty: .easy, isCompleted: false, isLocked: false),

        // Geography
        LessonNode(id: 5, category: "Geografía", emoji: "🗺️", title: "Countries and Capitals", description: "Mexico, Spain, Peru...", difficulty: .medium, isCompleted: false, isLocked: false),
        LessonNode(id: 6, category: "Geografía", emoji: "🏔️", title: "Mountains and Rivers", description: "Andes, Amazon...", difficulty: .hard, isCompleted: false, isLocked: true),

        // Culture
        LessonNode(id: 7, category: "Cultura", emoji: "💀", title: "Day of the Dead", description: "A Mexican tradition", difficulty: .medium, isCompleted: false, isLocked: false),
        LessonNode(id: 8, category: "Cultura", emoji: "🎭", title: "Lucha Libre", description: "Masks and heroes", difficulty: .medium, isCompleted: false, isLocked: false),
        LessonNode(id: 9, category: "Cultura", emoji: "🎉", title: "Popular Festivals", description: "Carnival, Posadas...", difficulty: .easy, isCompleted: false, isLocked: false),

        // Kitchen
        LessonNode(id: 10, category: "Cocina", emoji: "🌮", title: "Typical Foods", description: "Tacos, enchiladas, pozole", difficulty: .easy, isCompleted: false, isLocked: false),
        LessonNode(id: 11, category: "Cocina", emoji: "🍹", title: "Drinks", description: "Hibiscus water, horchata...", difficulty: .medium, isCompleted: false, isLocked: false),
        LessonNode(id: 12, category: "Cocina", emoji: "🍫", title: "Desserts", description: "Churros, caramel, flan", difficulty: .medium, isCompleted: false, isLocked: true)
    ]

    private let cardColors = [
        Color(red: 1.0, green: 0.8, blue: 0.0),
        Color(red: 0.9, green: 0.7, blue: 0.0),
        Color(red: 0.8, green: 0.6, blue: 0.0),
        Color(red: 1.0, green: 0.9, blue: 0.3),
        Color(red: 0.7, green: 0.5, blue: 0.0),
        Color(red: 0.9, green: 0.8, blue: 0.2)   
    ]

    var filteredLessons: [LessonNode] {
        if selectedCategory == "All" {
            return allLessons
        } else {
            return allLessons.filter { $0.category == selectedCategory }
        }
    }

    var body: some View {
        ZStack {
            GeometryReader { geo in
                let cardHeight: CGFloat = 120
                let spacing: CGFloat = 40
                let totalHeight = CGFloat(filteredLessons.count) * (cardHeight + spacing)

                Path { path in
                    let startX = geo.size.width / 2
                    var currentY: CGFloat = 80

                    path.move(to: CGPoint(x: startX, y: currentY))

                    for index in 0..<filteredLessons.count {
                        let nextY = currentY + cardHeight + spacing
                        let controlX = index % 2 == 0 ? startX + 60 : startX - 60
                        path.addQuadCurve(
                            to: CGPoint(x: startX, y: nextY),
                            control: CGPoint(x: controlX, y: (currentY + nextY) / 2)
                        )
                        currentY = nextY
                    }
                }
                .stroke(
                    LinearGradient(
                        colors: [
                            Color(red: 1.0, green: 0.8, blue: 0.0),
                            Color(red: 0.9, green: 0.7, blue: 0.0),
                            Color(red: 0.8, green: 0.6, blue: 0.0),
                            Color(red: 1.0, green: 0.9, blue: 0.3)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round, dash: [15, 8])
                )
                .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                .frame(height: totalHeight + 100)
                .offset(y: 60)
            }

            VStack(spacing: 40) {
                ForEach(Array(filteredLessons.enumerated()), id: \.element.id) { index, lesson in
                    LessonNodeCard(lesson: lesson, cardColor: cardColors[index % cardColors.count])
                        .offset(x: lesson.id % 2 == 0 ? -40 : 40)
                }
            }
            .padding(.vertical, 40)
        }
        .animation(.easeInOut(duration: 0.3), value: filteredLessons.count)
        .padding(.horizontal)
    }
}

// MARK: - Lesson Node
struct LessonNode: Identifiable {
    let id: Int
    let category: String
    let emoji: String
    let title: String
    let description: String
    let difficulty: Difficulty
    let isCompleted: Bool
    let isLocked: Bool
    
    enum Difficulty {
        case easy, medium, hard
        
        var color: Color {
            switch self {
            case .easy: return Color(red: 0.2, green: 0.8, blue: 0.2)
            case .medium: return Color(red: 1.0, green: 0.8, blue: 0.0)
            case .hard: return Color(red: 1.0, green: 0.3, blue: 0.3)    
            }
        }
        
        var text: String {
            switch self {
                case .easy: return "Easy"
                case .medium: return "Medium"
                case .hard: return "Hard"
            }
        }
    }
}

// MARK: - Lesson Node Card
struct LessonNodeCard: View {
    let lesson: LessonNode
    let cardColor: Color
    
    var body: some View {
        NavigationLink(destination: LessonDetailView(lesson: lesson)) {
            HStack(spacing: 16) {
                // Emoji
                ZStack {
                    Circle()
                        .fill(
                            lesson.isCompleted ?
                            LinearGradient(
                                colors: [Color(red: 0.2, green: 0.8, blue: 0.2), Color(red: 0.3, green: 0.9, blue: 0.3)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ) :
                            lesson.isLocked ?
                            LinearGradient(
                                colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ) :
                            LinearGradient(
                                colors: [
                                    cardColor.opacity(0.8),
                                    cardColor.opacity(0.4)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: cardColor.opacity(0.6), radius: 5, x: 0, y: 3)
                    
                    if lesson.isLocked {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                    } else if lesson.isCompleted {
                        ZStack {
                            Text(lesson.emoji)
                                .font(.system(size: 40))
                                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                            
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .background(Circle().fill(Color(red: 0.2, green: 0.8, blue: 0.2)))
                                .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                                .offset(x: 20, y: -20)
                        }
                    } else {
                        Text(lesson.emoji)
                            .font(.system(size: 40))
                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    }
                }
                .frame(width: 70, height: 70)
                
                // Info
                VStack(alignment: .leading, spacing: 6) {
                    Text(lesson.title)
                         .font(.custom("Mexicana", size: 20))
                        .foregroundColor(lesson.isLocked ? .gray : .white)
                        .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
                    
                    Text(lesson.description)
                         .font(.custom("Mexicana", size: 14))
                        .foregroundColor(lesson.isLocked ? .gray.opacity(0.7) : .white.opacity(0.9))
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    
                    HStack(spacing: 8) {
                        HStack(spacing: 4) {
                            Circle()
                                .fill(lesson.difficulty.color)
                                .frame(width: 8, height: 8)
                                .shadow(color: lesson.difficulty.color.opacity(0.6), radius: 2, x: 0, y: 1)
                            
                            Text(lesson.difficulty.text)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(lesson.difficulty.color.opacity(0.7))
                                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                        )
                        
                        if !lesson.isLocked {
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 10))
                                Text("50 pts")
                                    .font(.system(size: 12, weight: .bold))
                            }
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                        }
                    }
                }
                
                Spacer()
                
                if !lesson.isLocked {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        lesson.isLocked ?
                        LinearGradient(
                            colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ) :
                        LinearGradient(
                            colors: [
                                cardColor.opacity(0.8),
                                cardColor.opacity(0.5)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(
                        color: lesson.isLocked ? .black.opacity(0.2) : cardColor.opacity(0.6),
                        radius: 10,
                        x: 0,
                        y: 5
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                lesson.isLocked ? Color.gray.opacity(0.3) : Color.white.opacity(0.2),
                                lineWidth: 1
                            )
                    )
            )
        }
        .disabled(lesson.isLocked)
    }
}

#Preview {
    LearningView()
}
