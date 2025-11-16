import SwiftUI

struct BuildWordView: View {
    struct WordItem: Identifiable {
        let id = UUID()
        let word: String
        let hint: String
    }

    private let words: [WordItem] = [
        .init(word: "HOLA", hint: "Hello (in Spanish)"),
        .init(word: "AMIGO", hint: "Friend"),
        .init(word: "FIESTA", hint: "Party"),
        .init(word: "COLOR", hint: "Hue, tint"),
        .init(word: "CASA", hint: "House"),
        .init(word: "COMIDA", hint: "Food"),
        .init(word: "SOL", hint: "Sun"),
        .init(word: "LUNA", hint: "Moon"),
        .init(word: "AGUA", hint: "Water"),
        .init(word: "FLOR", hint: "Flower"),
        .init(word: "TIEMPO", hint: "Time / Weather"),
        .init(word: "FAMILIA", hint: "Family"),
        .init(word: "MUNDO", hint: "World"),
        .init(word: "ESCUELA", hint: "School"),
        .init(word: "MUSICA", hint: "Music")
    ]

    // MARK: - State
    @State private var currentIndex = 0
    @State private var shuffledLetters: [String] = []
    @State private var currentAnswer: [String] = []
    @State private var showResult = false
    @State private var isCorrect = false
    @State private var score = 0
    @State private var quizCompleted = false

    private var currentWord: WordItem {
        words[currentIndex]
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .gray], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            if quizCompleted {
                VStack(spacing: 25) {
                    Text("🏆 Word Builder Completed!")
                        .font(.custom("Mexicana", size: 30))
                        .foregroundColor(.yellow)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)

                    Text("You guessed \(score) / \(words.count) words")
                        .font(.custom("Mexicana", size: 22))
                        .foregroundColor(.white)

                    Button("🔁 Play Again") {
                        restartGame()
                    }
                    .font(.custom("Mexicana", size: 18))
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.yellow))
                    .padding(.horizontal)
                }
            } else {
                VStack(spacing: 30) {
                    Text("🔤 Build the Word!")
                        .font(.custom("Mexicana", size: 32))
                        .foregroundColor(.yellow)

                    Text("Word \(currentIndex + 1) / \(words.count)")
                        .font(.custom("Mexicana", size: 18))
                        .foregroundColor(.white.opacity(0.8))

                    Text(currentAnswer.joined())
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.2))
                        )

                    Text("💡 Hint: \(currentWord.hint)")
                        .font(.custom("Mexicana", size: 18))
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.bottom, 10)

                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 5), spacing: 12) {
                        ForEach(shuffledLetters, id: \.self) { letter in
                            Button(letter) {
                                handleLetterTap(letter)
                            }
                            .font(.system(size: 30, weight: .bold))
                            .frame(width: 60, height: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.orange.opacity(currentAnswer.contains(letter) ? 0.4 : 1.0))
                            )
                            .disabled(currentAnswer.contains(letter))
                        }
                    }
                    .padding(.horizontal)

                    if showResult {
                        Text(isCorrect ? "✅ Correct!" : "❌ Try again!")
                            .foregroundColor(isCorrect ? .green : .red)
                            .font(.custom("Mexicana", size: 22))
                            .padding(.top)

                        if isCorrect {
                            Button("Next ▶️") {
                                nextWord()
                            }
                            .font(.custom("Mexicana", size: 18))
                            .foregroundColor(.black)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.yellow))
                            .padding(.top, 10)
                        } else {
                            Button("🔄 Retry") {
                                retryWord()
                            }
                            .font(.custom("Mexicana", size: 18))
                            .foregroundColor(.black)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.yellow))
                            .padding(.top, 10)
                        }
                    }
                }
                .padding()
                .onAppear(perform: loadWord)
            }
        }
    }

    // MARK: - Game Logic
    private func loadWord() {
        currentAnswer.removeAll()
        shuffledLetters = Array(currentWord.word).map { String($0) }.shuffled()
        showResult = false
        isCorrect = false
    }

    private func handleLetterTap(_ letter: String) {
        currentAnswer.append(letter)
        checkAnswer()
    }

    private func checkAnswer() {
        let guess = currentAnswer.joined()
        if guess == currentWord.word {
            isCorrect = true
            showResult = true
            score += 1
        } else if guess.count == currentWord.word.count {
            isCorrect = false
            showResult = true
        }
    }

    private func nextWord() {
        if currentIndex + 1 < words.count {
            currentIndex += 1
            loadWord()
        } else {
            quizCompleted = true
        }
    }

    private func retryWord() {
        currentAnswer.removeAll()
        showResult = false
    }

    private func restartGame() {
        currentIndex = 0
        score = 0
        quizCompleted = false
        loadWord()
    }
}
