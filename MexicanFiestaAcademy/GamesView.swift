//
//  GamesView.swift
//  Mexican Fiesta Academy
//

import SwiftUI

struct GamesView: View {
    @State private var selectedGame: GameType? = nil
    @State private var showFeaturedGame = false
    
    private let casinoColors = [
        Color(red: 1.0, green: 0.8, blue: 0.0),
        Color(red: 0.9, green: 0.7, blue: 0.0),
        Color(red: 0.8, green: 0.6, blue: 0.0),
        Color(red: 1.0, green: 0.9, blue: 0.3),
        Color(red: 0.7, green: 0.5, blue: 0.0),  
        Color(red: 0.9, green: 0.8, blue: 0.2)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 25) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Games")
                            .font(.custom("Mexicana", size: 36))
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                            .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                        
                        Text("Have fun while you learn")
                            .font(.custom("Mexicana", size: 16))
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    }
                    .padding(.horizontal)
                    
                    // Featured game
                    FeaturedGameCard(action: { showFeaturedGame = true })
                        .padding(.horizontal)
                    
                    // Game categories
                    Text("Mini-games")
                        .font(.custom("Mexicana", size: 28))
                        .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                        .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        GameCard(
                            game: .matching,
                            emoji: "cart",
                            title: "Memory Match",
                            description: "Find the word pairs",
                            color: casinoColors[0],
                            difficulty: "Easy",
                            duration: "3 min",
                            action: { selectedGame = .matching }
                        )
                        
                        GameCard(
                            game: .quiz,
                            emoji: "brain",
                            title: "Quick Quiz",
                            description: "Answer questions about Mexican culture",
                            color: casinoColors[1],
                            difficulty: "Medium",
                            duration: "5 min",
                            action: { selectedGame = .quiz }
                        )
                        
                        GameCard(
                            game: .wordBuilder,
                            emoji: "char",
                            title: "Build Words",
                            description: "Form words in Spanish",
                            color: casinoColors[2],
                            difficulty: "Medium",
                            duration: "4 min",
                            action: { selectedGame = .wordBuilder }
                        )
                        
                        GameCard(
                            game: .flagMatch,
                            emoji: "flas",
                            title: "Flags of Mexico",
                            description: "Identify the Mexican states",
                            color: casinoColors[3],
                            difficulty: "Hard",
                            duration: "6 min",
                            action: { selectedGame = .flagMatch }
                        )
                    }
                    .padding(.horizontal)
                    
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
        .fullScreenCover(item: $selectedGame) { game in
            gameView(for: game)
        }
        .fullScreenCover(isPresented: $showFeaturedGame) {
            TacoTriviaGameView()
        }
    }
    
    @ViewBuilder
    private func gameView(for game: GameType) -> some View {
        switch game {
            case .matching:
                MemoryMatchGameView()
            case .quiz:
                QuizGameView()
            case .wordBuilder:
                WordBuilderGameView()
            case .flagMatch:
                FlagMatchGameView()
        }
    }
}

// MARK: - Game Type
enum GameType: Identifiable {
    case matching, quiz, wordBuilder, flagMatch
    
    var id: String {
        switch self {
            case .matching: return "matching"
            case .quiz: return "quiz"
            case .wordBuilder: return "wordBuilder"
            case .flagMatch: return "flagMatch"
        }
    }
}

// MARK: - Featured Game Card
struct FeaturedGameCard: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.8, green: 0.6, blue: 0.0),
                                Color(red: 1.0, green: 0.8, blue: 0.0),
                                Color(red: 0.9, green: 0.7, blue: 0.0)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: Color(red: 1.0, green: 0.8, blue: 0.0).opacity(0.6), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("🌮 Featured")
                                .font(.custom("Mexicana", size: 14))
                                .foregroundColor(.black)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(Color.white.opacity(0.9))
                                )
                                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                            
                            Text("Taco Trivia")
                                .font(.custom("Mexicana", size: 32))
                                .foregroundColor(.black)
                                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                            
                            Text("Show how much you know about tacos!")
                                .font(.custom("Mexicana", size: 16))
                                .foregroundColor(.black.opacity(0.8))
                                .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                        }
                        
                        Spacer()
                        
                        Text("🌮")
                            .font(.system(size: 80))
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    }
                    
                    HStack {
                        HStack(spacing: 8) {
                            Image(systemName: "person.2.fill")
                                .font(.system(size: 14))
                            Text("Multiplayer")
                                .font(.custom("Mexicana", size: 14))
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.9))
                        )
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                        
                        Spacer()
                        
                        HStack {
                            Text("Play")
                                .font(.custom("Mexicana", size: 16))
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .fill(Color.black.opacity(0.8))
                                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                        )
                    }
                }
                .padding(24)
            }
            .frame(height: 220)
        }
    }
}

// MARK: - Game Card
struct GameCard: View {
    let game: GameType
    let emoji: String
    let title: String
    let description: String
    let color: Color
    let difficulty: String
    let duration: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [color.opacity(0.8), color.opacity(0.4)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: color.opacity(0.5), radius: 5, x: 0, y: 3)
                    
                    Image(emoji)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                }
                .frame(width: 80, height: 80)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                
                // Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.custom("Mexicana", size: 20))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
                    
                    Text(description)
                        .font(.custom("Mexicana", size: 14))
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(2)
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    
                    HStack(spacing: 12) {
                        Label(difficulty, systemImage: "chart.bar.fill")
                            .font(.custom("Mexicana", size: 12))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(Color(red: 1.0, green: 0.8, blue: 0.0).opacity(0.4))
                            )
                        
                        Label(duration, systemImage: "clock.fill")
                            .font(.custom("Mexicana", size: 12))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(Color(red: 0.9, green: 0.7, blue: 0.0).opacity(0.4))
                            )
                    }
                }
                
                Spacer()
                
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 36))
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                    .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [
                                color.opacity(0.7),
                                color.opacity(0.3)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: color.opacity(0.5), radius: 10, x: 0, y: 5)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

// MARK: - Memory Match Game View
struct MemoryMatchGameView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    @State private var cards: [MemoryCard] = []
    @State private var flippedIndices: Set<Int> = []
    @State private var matchedIndices: Set<Int> = []
    @State private var moves = 0
    @State private var score = 0
    @State private var showCompletion = false
    @State private var canFlip = true
    
    private let cardPairs = [
        ("🌮", "Taco"),
        ("🌯", "Burrito"),
        ("🫔", "Tamale"),
        ("🥑", "Aguacate"),
        ("🌶️", "Chile"),
        ("🍅", "Tomate")
    ]
    
    var body: some View {
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
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                            .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("Movements")
                            .font(.custom("Mexicana", size: 12))
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                        Text("\(moves)")
                            .font(.custom("Mexicana", size: 20))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("Points")
                            .font(.custom("Mexicana", size: 12))
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                        Text("\(score)")
                            .font(.custom("Mexicana", size: 20))
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                            .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
                    }
                }
                .padding()
                
                Text("Memory Match")
                    .font(.custom("Mexicana", size: 32))
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                    .padding(.bottom, 10)
                
                Text("Find the pairs")
                    .font(.custom("Mexicana", size: 16))
                    .foregroundColor(.white.opacity(0.9))
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    .padding(.bottom, 20)
                
                // Game grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                    ForEach(0..<cards.count, id: \.self) { index in
                        MemoryCardView(
                            card: cards[index],
                            isFlipped: flippedIndices.contains(index) || matchedIndices.contains(index),
                            isMatched: matchedIndices.contains(index)
                        )
                        .onTapGesture {
                            flipCard(at: index)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            
            if showCompletion {
                CompletionViews(score: score, maxScore: 600) {
                    dismiss()
                }
            }
        }
        .onAppear {
            setupGame()
        }
    }
    
    private func setupGame() {
        var newCards: [MemoryCard] = []
        for pair in cardPairs {
            newCards.append(MemoryCard(emoji: pair.0, text: pair.0))
            newCards.append(MemoryCard(emoji: pair.1, text: pair.1))
        }
        cards = newCards.shuffled()
    }
    
    private func flipCard(at index: Int) {
        guard canFlip,
              !matchedIndices.contains(index),
              !flippedIndices.contains(index),
              flippedIndices.count < 2 else { return }
        
        withAnimation(.spring(response: 0.3)) {
            flippedIndices.insert(index)
        }
        
        if flippedIndices.count == 2 {
            moves += 1
            checkForMatch()
        }
    }
    
    private func checkForMatch() {
        canFlip = false
        let indices = Array(flippedIndices)
        let firstCard = cards[indices[0]]
        let secondCard = cards[indices[1]]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if firstCard.emoji == secondCard.text || firstCard.text == secondCard.emoji {
                withAnimation {
                    matchedIndices.insert(indices[0])
                    matchedIndices.insert(indices[1])
                    score += 100
                }
                
                if matchedIndices.count == cards.count {
                    appState.userProgress.addScore(score)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showCompletion = true
                    }
                }
            }
            
            flippedIndices.removeAll()
            canFlip = true
        }
    }
}

struct MemoryCard: Identifiable {
    let id = UUID()
    let emoji: String
    let text: String
}

struct MemoryCardView: View {
    let card: MemoryCard
    let isFlipped: Bool
    let isMatched: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    isMatched ?
                    LinearGradient(
                        colors: [Color(red: 0.2, green: 0.8, blue: 0.2), Color(red: 0.3, green: 0.9, blue: 0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ) :
                    LinearGradient(
                        colors: [Color.white, Color(red: 0.98, green: 0.98, blue: 1.0)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isMatched ? Color.white.opacity(0.3) : Color.gray.opacity(0.2), lineWidth: 1)
                )
            
            if isFlipped {
                VStack(spacing: 4) {
                    if card.emoji.count == 1 {
                        Text(card.emoji)
                            .font(.system(size: 40))
                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    } else {
                        Text(card.text)
                            .font(.custom("Mexicana", size: 14))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                    }
                }
            } else {
                Image(systemName: "questionmark")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
            }
        }
        .frame(height: 100)
        .rotation3DEffect(
            .degrees(isFlipped ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.spring(response: 0.4), value: isFlipped)
    }
}

// MARK: - Quiz Game View
struct QuizGameView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    @State private var currentQuestion = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showResult = false
    @State private var score = 0
    @State private var isCorrect = false
    @State private var showCompletion = false
    
    private let quizQuestions = [
        Question(
            text: "What is the capital of Mexico?",
            options: ["Guadalajara", "Mexico City", "Monterrey", "Cancun"],
            correctAnswer: 1,
            explanation: "Correct! Mexico City is the capital and largest city of Mexico."
        ),
        Question(
            text: "What does 'Day of the Dead' mean?",
            options: ["Day of the Dead", "Birthday", "New Year", "Christmas"],
            correctAnswer: 0,
            explanation: "That's right! Day of the Dead is a Mexican tradition that celebrates the lives of the deceased."
        ),
        Question(
            text: "What is the most famous traditional Mexican dish?",
            options: ["Pizza", "Sushi", "Tacos", "Pasta"],
            correctAnswer: 2,
            explanation: "Perfect! Tacos are one of the most iconic dishes in Mexico."
        ),
        Question(
            text: "What colors does the Mexican flag have?",
            options: ["Red, white, and blue", "Green, white, and red", "Yellow and black", "Blue and white"],
            correctAnswer: 1,
            explanation: "Correct! The Mexican flag has three colors: green, white, and red."
        ),
        Question(
            text: "What is the currency of Mexico?",
            options: ["Dollar", "Euro", "Peso", "Real"],
            correctAnswer: 2,
            explanation: "Good! The Mexican peso is the official currency of Mexico."
        )
    ]
    
    var body: some View {
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
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                            .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                    }
                    
                    Spacer()
                    
                    Text("Question \(currentQuestion + 1)/\(quizQuestions.count)")
                        .font(.custom("Mexicana", size: 18))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                            .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
                        Text("\(score)")
                            .font(.custom("Mexicana", size: 18))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
                    }
                }
                .padding()
                
                Text("🧠 Quick Quiz")
                    .font(.custom("Mexicana", size: 32))
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                    .padding(.bottom, 20)
                
                ScrollView {
                    if !showCompletion {
                        QuestionCard(
                            question: quizQuestions[currentQuestion],
                            selectedAnswer: $selectedAnswer,
                            showResult: $showResult,
                            isCorrect: $isCorrect
                        )
                        .onReceive([showResult].publisher) { _ in
                            if showResult && isCorrect {
                                score += 100
                            }
                        }
                        
                        if showResult {
                            Button {
                                nextQuestion()
                            } label: {
                                Text(currentQuestion < quizQuestions.count - 1 ? "Next" : "Finish")
                                    .font(.custom("Mexicana", size: 18))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color(red: 1.0, green: 0.8, blue: 0.0))
                                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                                    )
                            }
                            .padding()
                        }
                    }
                }
            }
            
            if showCompletion {
                CompletionViews(score: score, maxScore: quizQuestions.count * 100) {
                    appState.userProgress.addScore(score)
                    dismiss()
                }
            }
        }
    }
    
    private func nextQuestion() {
        if currentQuestion < quizQuestions.count - 1 {
            withAnimation {
                currentQuestion += 1
                selectedAnswer = nil
                showResult = false
                isCorrect = false
            }
        } else {
            withAnimation {
                showCompletion = true
            }
        }
    }
}

struct WordBuilderGameView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
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
            
            VStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                        .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                }
                .padding()
                
                Text("📝 Build Words")
                    .font(.custom("Mexicana", size: 32))
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                
                Text("Developing")
                    .font(.custom("Mexicana", size: 20))
                    .foregroundColor(.white.opacity(0.9))
                    .padding()
            }
        }
    }
}

struct FlagMatchGameView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
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
            
            VStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                        .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                }
                .padding()
                
                Text("🏴 Flags of Mexico")
                    .font(.custom("Mexicana", size: 32))
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                
                Text("Developing")
                    .font(.custom("Mexicana", size: 20))
                    .foregroundColor(.white.opacity(0.9))
                    .padding()
            }
        }
    }
}

// MARK: - Taco Trivia Game View
struct TacoTriviaGameView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    @State private var currentQuestion = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showResult = false
    @State private var score = 0
    @State private var showCompletion = false
    
    private let tacoQuestions = [
        Question(
            text: "Where did tacos originate?",
            options: ["Spain", "Mexico", "United States", "Cuba"],
            correctAnswer: 1,
            explanation: "Correct! Tacos originated in Mexico, with centuries of history."
        ),
        Question(
            text: "What does 'al pastor' mean?",
            options: ["With vegetables", "Shepherd style", "Spicy", "With cheese"],
            correctAnswer: 1,
            explanation: "Exactly! 'Al pastor' means 'in the shepherd style', inspired by Lebanese shawarma."
        ),
        Question(
            text: "What is the main ingredient in fish tacos?",
            options: ["Chicken", "Beef", "Fish", "Pork"],
            correctAnswer: 2,
            explanation: "Perfect! Fish tacos use battered and fried fish."
        ),
        Question(
            text: "What day is Taco Day celebrated in some places?",
            options: ["October 4", "May 5", "January 1", "December 31"],
            correctAnswer: 0,
            explanation: "Good! October 4th is National Taco Day in Mexico."
        )
    ]
    
    var body: some View {
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
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                            .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                    }
                    
                    Spacer()
                    
                    Text("🌮 Taco Trivia")
                        .font(.custom("Mexicana", size: 24))
                        .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                        .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                        Text("\(score)")
                            .font(.custom("Mexicana", size: 18))
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                if !showCompletion {
                    ScrollView {
                        VStack(spacing: 20) {
                            Text("🌮")
                                .font(.system(size: 100))
                                .padding()
                            
                            VStack(spacing: 24) {
                                // Question
                                Text(tacoQuestions[currentQuestion].text)
                                    .font(.custom("Mexicana", size: 24))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white.opacity(0.1))
                                    )
                                
                                // Answers
                                VStack(spacing: 12) {
                                    ForEach(0..<tacoQuestions[currentQuestion].options.count, id: \.self) { index in
                                        TacoAnswerButton(
                                            text: tacoQuestions[currentQuestion].options[index],
                                            isSelected: selectedAnswer == index,
                                            isCorrect: index == tacoQuestions[currentQuestion].correctAnswer,
                                            showResult: showResult
                                        ) {
                                            selectAnswer(index)
                                        }
                                    }
                                }
                                
                                if showResult {
                                    Text(tacoQuestions[currentQuestion].explanation)
                                        .font(.custom("Mexicana", size: 16))
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(Color.white.opacity(0.1))
                                        )
                                    
                                    Button {
                                        nextQuestion()
                                    } label: {
                                        Text(currentQuestion < tacoQuestions.count - 1 ? "Next 🌮" : "Finish 🎉")
                                            .font(.custom("Mexicana", size: 18))
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 16)
                                            .background(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .fill(Color(red: 1.0, green: 0.8, blue: 0.0))
                                            )
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            
            if showCompletion {
                ZStack {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 30) {
                        Text("🌮🎉🌮")
                            .font(.system(size: 80))
                        
                        Text("You are a taco expert!")
                            .font(.custom("Mexicana", size: 28))
                            .foregroundColor(.white)
                        
                        Text("Score: \(score)")
                            .font(.custom("Mexicana", size: 24))
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                        
                        Button {
                            appState.userProgress.addScore(score)
                            dismiss()
                        } label: {
                            Text("Continue")
                                .font(.custom("Mexicana", size: 18))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color(red: 1.0, green: 0.8, blue: 0.0))
                                )
                        }
                    }
                    .padding(40)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
                            .shadow(radius: 20)
                    )
                    .padding(.horizontal, 40)
                }
            }
        }
    }
    
    private func selectAnswer(_ index: Int) {
        guard !showResult else { return }
        selectedAnswer = index
        
        if index == tacoQuestions[currentQuestion].correctAnswer {
            score += 100
        }
        
        withAnimation(.spring(response: 0.3)) {
            showResult = true
        }
    }
    
    private func nextQuestion() {
        if currentQuestion < tacoQuestions.count - 1 {
            withAnimation {
                currentQuestion += 1
                selectedAnswer = nil
                showResult = false
            }
        } else {
            withAnimation {
                showCompletion = true
            }
        }
    }
}

struct TacoAnswerButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let showResult: Bool
    let action: () -> Void
    
    var background: some View {
        if showResult {
            if isSelected {
                return isCorrect ?
                LinearGradient(colors: [Color.green, Color.green.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing) :
                LinearGradient(colors: [Color.red, Color.red.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
            } else if isCorrect {
                return LinearGradient(colors: [Color.green.opacity(0.7), Color.green.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        }
        return LinearGradient(colors: [Color.white.opacity(isSelected ? 0.3 : 0.2), Color.white.opacity(isSelected ? 0.2 : 0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.custom("Mexicana", size: 18))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                if showResult && (isSelected || isCorrect) {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
                }
            }
            .padding()
            .background(background)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
        }
        .disabled(showResult)
    }
}

#Preview {
    GamesView()
        .environmentObject(AppState())
}
