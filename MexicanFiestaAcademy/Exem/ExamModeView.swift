import SwiftUI

struct Question {
    let text: String
    let options: [String]
    let correctAnswer: Int
    let explanation: String
}


struct ExamModeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    @StateObject private var examManager = ExamManager()
    
    var body: some View {
        ZStack {
            if !examManager.hasStarted {
                ExamIntroView(onStart: {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        examManager.startExam()
                    }
                }, onDismiss: {
                    dismiss()
                })
            } else if examManager.isCompleted {
                ExamCompletionView(
                    score: examManager.score,
                    totalQuestions: examManager.totalQuestions,
                    percentage: examManager.percentage,
                    timeUsed: examManager.timeUsed,
                    onDismiss: {
                        appState.userProgress.addScore(examManager.score * 100)
                        dismiss()
                    }
                )
            } else {
                ExamQuestionView(examManager: examManager)
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Exam Manager
class ExamManager: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var selectedAnswer: Int? = nil
    @Published var score = 0
    @Published var hasStarted = false
    @Published var isCompleted = false
    @Published var timeRemaining: TimeInterval = 600 // 10 minutes
    @Published var answers: [Int?] = []
    @Published var showExplanation = false
    
    private var timer: Timer?
    let totalQuestions = 15
    let timeLimit: TimeInterval = 600
    var startTime: Date?
    
    var timeUsed: TimeInterval {
        guard let start = startTime else { return 0 }
        return Date().timeIntervalSince(start)
    }
    
    var percentage: Int {
        return Int((Double(score) / Double(totalQuestions)) * 100)
    }
    
    var currentQuestion: Question? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }
    
    func startExam() {
        hasStarted = true
        startTime = Date()
        generateQuestions()
        answers = Array(repeating: nil, count: totalQuestions)
        startTimer()
    }
    
    private func generateQuestions() {
        questions = [
            Question(
                text: "What is the national dish of Mexico?",
                options: ["Tacos al pastor", "Mole poblano", "Chiles en nogada", "Pozole"],
                correctAnswer: 2,
                explanation: "Chiles en nogada are considered the national dish because of their patriotic colors (green, white, and red)"
                
            ),
            Question(
                text: "In what year did the Mexican Revolution begin?",
                options: ["1905", "1910", "1915", "1920"],
                correctAnswer: 1,
                explanation: "The Mexican Revolution began in 1910 against the government of Porfirio Díaz"
                
            ),
            Question(
                text: "What does 'fiesta' mean in Spanish?",
                options: ["Food", "Party", "Dance", "Music"],
                correctAnswer: 1,
                explanation: "'Fiesta' means 'party' in English - a celebration or festive gathering"
                
            ),
            Question(
                
                text: "What is the most characteristic musical instrument of Mexico?",
                options: ["Guitar", "Marimba", "Maracas", "Mariachi"],
                correctAnswer: 3,
                explanation: "The mariachi is the most representative musical group of Mexico"
            ),
            Question(
                text: "Which city is known as 'The City of Palaces'?",
                options: ["Guadalajara", "Monterrey", "Mexico City", "Puebla"],
                correctAnswer: 2,
                explanation: "Mexico City is known as 'The City of Palaces' because of its architecture"),
            Question(
                text: "How do you say 'thank you' in Spanish?",
                options: ["Please", "Thank you", "You're welcome", "Hello"],
                correctAnswer: 1,
                explanation: "'Thank you' is the way to say 'thank you' in Spanish"
                
            ),
            Question(
                text: "Which Mexican artist painted 'The Two Fridas'?",
                options: ["Diego Rivera", "Frida Kahlo", "David Alfaro Siqueiros", "José Clemente Orozco"],
                correctAnswer: 1,
                explanation: "Frida Kahlo painted 'The Two Fridas' in 1939, one of her most famous works"
                
            ),
            Question(
                text: "What is the traditional Mexican drink made from agave?",
                options: ["Mezcal", "Pulque", "Tequila", "All of the above"],
                correctAnswer: 3,
                explanation: "All of these drinks are traditional Mexican drinks made from different types of agave"
                
            ),
            Question(
                text: "What does the Day of the Dead celebrate in Mexico?",
                options: ["Independence", "The deceased", "The revolution", "Spring"],
                correctAnswer: 1,
                explanation: "The Day of the Dead is a tradition to honor and remember deceased loved ones"
                
            ),
            Question(
                text: "How do you say 'beautiful' in Spanish?",
                options: ["Bonito", "Hermoso", "Guapo", "Todos los antes"],
                correctAnswer: 3,
                explanation: "All of these words can mean 'beautiful' depending on the context"
                
            ),Question(
                text: "How do you say 'beautiful' in Spanish?",
                options: ["Bonito", "Hermoso", "Guapo", "Todos los antes"],
                correctAnswer: 3,
                explanation: "All of these words can mean 'beautiful' depending on the context"
                
            ),
            Question(
                text: "Which pre-Hispanic pyramid is near Mexico City?",
                options: ["Chichen Itza", "Teotihuacan", "Palenque", "Monte Alban"],
                correctAnswer: 1,
                explanation: "Teotihuacan, with the Pyramids of the Sun and the Moon, is 40 km from Mexico City"
                
            ),
            Question(
                text: "What is the traditional dance of Veracruz?",
                options: ["Jarabe Tapatío", "Danza de los Viejitos", "Son Jarocho", "Flor de Piña"],
                correctAnswer: 2,
                explanation: "Son Jarocho is the traditional dance of the state of Veracruz"
                
            ),
            Question(
                text: "What does 'mañana' mean in Spanish?",
                options: ["Morning", "Tomorrow", "Afternoon", "Evening"],
                correctAnswer: 1,
                
                explanation: "'Mañana' means 'tomorrow', while 'la mañana' means 'morning'"
                
            ),
            Question(
                text: "Who was the last Aztec emperor?",
                options: ["Moctezuma I", "Cuauhtémoc", "Moctezuma II", "Itzcóatl"],
                correctAnswer: 1,
                explanation: "Cuauhtémoc was the last Mexica tlatoani, executed by the Spanish in 1525"
                
            ),
            Question(
                text: "Which Mexican state is famous for its silver production?",
                options: ["Guanajuato", "Zacatecas", "Taxco", "All of the above"],
                correctAnswer: 3,
                explanation: "All of these states are famous for their silver production and craftsmanship")
        ]
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.completeExam()
            }
        }
    }
    
    func selectAnswer(_ index: Int) {
        selectedAnswer = index
        answers[currentQuestionIndex] = index
        
        if let question = currentQuestion, index == question.correctAnswer {
            score += 1
        }
        
        // Mostrar explicación después de seleccionar respuesta
        showExplanation = true
    }
    
    func nextQuestion() {
        showExplanation = false
        if currentQuestionIndex < totalQuestions - 1 {
            currentQuestionIndex += 1
            selectedAnswer = answers[currentQuestionIndex]
        } else {
            completeExam()
        }
    }
    
    func previousQuestion() {
        showExplanation = false
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            selectedAnswer = answers[currentQuestionIndex]
        }
    }
    
    private func completeExam() {
        timer?.invalidate()
        timer = nil
        isCompleted = true
    }
    
    deinit {
        timer?.invalidate()
    }
}

// MARK: - Exam Intro View
struct ExamIntroView: View {
    let onStart: () -> Void
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.85, green: 0.2, blue: 0.3),
                    Color(red: 1.0, green: 0.6, blue: 0.0),
                    Color(red: 0.95, green: 0.8, blue: 0.1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("🎓")
                        .font(.system(size: 60))
                        .rotationEffect(.degrees(-15))
                        .opacity(0.3)
                    Spacer()
                    Text("📚")
                        .font(.system(size: 50))
                        .rotationEffect(.degrees(10))
                        .opacity(0.3)
                }
                .padding(.horizontal, 40)
                
                Spacer()
                
                HStack {
                    Text("🌮")
                        .font(.system(size: 40))
                        .rotationEffect(.degrees(-5))
                        .opacity(0.3)
                    Spacer()
                    Text("🎭")
                        .font(.system(size: 60))
                        .rotationEffect(.degrees(15))
                        .opacity(0.3)
                }
                .padding(.horizontal, 40)
            }
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 20) {
                    Text("🎓")
                        .font(.system(size: 80))
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                    
                    VStack(spacing: 12) {
                        Text("Master's Exam")
                        
                            .font(.custom("Mexicana", size: 36))
                        
                            .foregroundColor(.white)
                        
                            .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
                        
                        Text("Demonstrate your knowledge of Mexican culture")
                            .font(.custom("Mexicana", size: 18))
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                    }
                }
                
                // Info Cards
                VStack(spacing: 16) {
                    ExamInfoCard(
                        icon: "🧠",
                        title: "15 Unique Questions",
                        description: "Culture, history, Spanish, and traditions",
                        color: Color(red: 0.2, green: 0.6, blue: 0.3));
                    
                    
                    
                    ExamInfoCard(
                        icon: "⏱️",
                        title: "10 Minutes",
                        description: "Time limit to complete",
                        color: Color(red: 1.0, green: 0.6, blue: 0.0));
                    
                    
                    ExamInfoCard(
                        icon: "🏆",
                        title: "Digital Certificate",
                        description: "Get your certificate upon passing",
                        color: Color(red: 0.95, green: 0.8, blue: 0.1));
                    
                    
                    ExamInfoCard(
                        icon: "⭐",
                        title: "Up to 1500 Points",
                        description: "Reward based in your score",
                        
                        color: Color(red: 0.85, green: 0.2, blue: 0.3)
                        
                    )
                }
                .padding(.horizontal)
                
                // Action Buttons
                VStack(spacing: 16) {
                    Button(action: onStart) {
                        HStack {
                            Text("🎯 Start Exam")
                                .font(.custom("Mexicana", size: 20))
                            Image(systemName: "arrow.right.circle.fill")
                        }
                        .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.3))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        )
                    }
                    
                    Button(action: onDismiss) {
                        Text("Back to Profile")
                            .font(.custom("Mexicana", size: 16))
                            .foregroundColor(.white)
                            .padding(.vertical, 14)
                    }
                }
                .padding(.horizontal, 40)
            }
            .padding()
        }
    }
}

