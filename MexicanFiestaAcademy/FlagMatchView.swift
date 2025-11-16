import SwiftUI

struct FlagMatchView: View {
    struct FlagItem: Identifiable, Equatable {
        let id = UUID()
        let emoji: String
        let country: String
    }

    private let allFlags: [FlagItem] = [
        .init(emoji: "🇲🇽", country: "Mexico"),
        .init(emoji: "🇪🇸", country: "Spain"),
        .init(emoji: "🇦🇷", country: "Argentina"),
        .init(emoji: "🇨🇱", country: "Chile"),
        .init(emoji: "🇨🇴", country: "Colombia"),
        .init(emoji: "🇵🇪", country: "Peru"),
        .init(emoji: "🇧🇷", country: "Brazil"),
        .init(emoji: "🇺🇾", country: "Uruguay"),
        .init(emoji: "🇨🇷", country: "Costa Rica"),
        .init(emoji: "🇬🇹", country: "Guatemala"),
        .init(emoji: "🇵🇦", country: "Panama"),
        .init(emoji: "🇩🇴", country: "Dominican Republic"),
        .init(emoji: "🇨🇺", country: "Cuba"),
        .init(emoji: "🇻🇪", country: "Venezuela"),
        .init(emoji: "🇵🇷", country: "Puerto Rico")
    ]
    
    // MARK: - State
    @State private var currentIndex = 0
    @State private var currentFlag: FlagItem?
    @State private var options: [FlagItem] = []
    @State private var showResult = false
    @State private var isCorrect = false
    @State private var score = 0
    @State private var quizCompleted = false
    
    let totalQuestions = 10

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue.opacity(0.4), .black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            if quizCompleted {
                VStack(spacing: 20) {
                    Text("🏆 Flag Quiz Completed!")
                        .font(.custom("Mexicana", size: 32))
                        .foregroundColor(.yellow)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
                    
                    Text("You got \(score) / \(totalQuestions) correct")
                        .font(.custom("Mexicana", size: 22))
                        .foregroundColor(.white)
                    
                    Button("🔁 Play Again") {
                        restartQuiz()
                    }
                    .font(.custom("Mexicana", size: 18))
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.yellow))
                    .padding(.horizontal)
                }
                .padding()
            } else {
                VStack(spacing: 30) {
                    Text("🚩 Match the Flag!")
                        .font(.custom("Mexicana", size: 32))
                        .foregroundColor(.yellow)
                    
                    Text("Question \(currentIndex + 1) / \(totalQuestions)")
                        .font(.custom("Mexicana", size: 18))
                        .foregroundColor(.white.opacity(0.8))
                    
                    if let flag = currentFlag {
                        Text(flag.emoji)
                            .font(.system(size: 120))
                            .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 2)
                    }
                    
                    VStack(spacing: 16) {
                        ForEach(options) { flag in
                            Button(flag.country) {
                                checkAnswer(flag)
                            }
                            .font(.custom("Mexicana", size: 22))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.15))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        showResult && flag == currentFlag
                                        ? Color.green
                                        : showResult && flag != currentFlag && flag.country == currentFlag?.country
                                          ? Color.red
                                          : Color.clear,
                                        lineWidth: 2
                                    )
                            )
                            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: showResult)
                        }
                    }
                    .padding(.horizontal)
                    
                    if showResult {
                        Text(isCorrect ? "✅ Correct!" : "❌ Wrong!")
                            .foregroundColor(isCorrect ? .green : .red)
                            .font(.custom("Mexicana", size: 22))
                            .padding(.top, 10)
                        
                        Button("Next ▶️") {
                            nextQuestion()
                        }
                        .font(.custom("Mexicana", size: 18))
                        .foregroundColor(.black)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.yellow))
                    }
                }
                .padding()
                .onAppear(perform: startQuiz)
            }
        }
    }

    private func startQuiz() {
        currentIndex = 0
        score = 0
        quizCompleted = false
        loadQuestion()
    }

    private func loadQuestion() {
        let shuffled = allFlags.shuffled()
        currentFlag = shuffled.first
        options = Array(shuffled.prefix(4)).shuffled()
        showResult = false
        isCorrect = false
    }

    private func checkAnswer(_ flag: FlagItem) {
        guard let current = currentFlag else { return }
        showResult = true
        isCorrect = flag == current
        if isCorrect { score += 1 }
    }

    private func nextQuestion() {
        if currentIndex + 1 < totalQuestions {
            currentIndex += 1
            loadQuestion()
        } else {
            quizCompleted = true
        }
    }

    private func restartQuiz() {
        startQuiz()
    }
}
