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
                explanation: "Chiles en nogada are considered the national dish because of their patriotic colors."
            ),
            Question(
                text: "In what year did the Mexican Revolution begin?",
                options: ["1905", "1910", "1915", "1920"],
                correctAnswer: 1,
                explanation: "It began in 1910 against the regime of Porfirio Díaz."
            ),
            Question(
                text: "Which Mexican artist painted 'The Two Fridas'?",
                options: ["Diego Rivera", "Frida Kahlo", "David Siqueiros", "José Orozco"],
                correctAnswer: 1,
                explanation: "Frida Kahlo created it in 1939."
            ),
            Question(
                text: "What does 'amigo' mean in English?",
                options: ["Enemy", "Friend", "Family", "Neighbor"],
                correctAnswer: 1,
                explanation: "'Amigo' = friend."
            ),
            Question(
                text: "What is the capital of Yucatán?",
                options: ["Mérida", "Cancún", "Campeche", "Tulum"],
                correctAnswer: 0,
                explanation: "Mérida is the capital of Yucatán."
            ),
            Question(
                text: "Which volcano is near Puebla?",
                options: ["Popocatépetl", "Colima", "Paricutín", "Nevado de Toluca"],
                correctAnswer: 0,
                explanation: "Popocatépetl, also called 'El Popo'."
            ),
            Question(
                text: "How do you say 'apple' in Spanish?",
                options: ["Naranja", "Manzana", "Uva", "Pera"],
                correctAnswer: 1,
                explanation: "‘Manzana’ means apple."
            ),
            Question(
                text: "What is Mexico’s largest desert?",
                options: ["Chihuahuan Desert", "Sonoran Desert", "Atacama", "Baja Desert"],
                correctAnswer: 0,
                explanation: "The Chihuahuan Desert extends into the U.S. border."
            ),
            Question(
                text: "Who conquered the Aztec Empire?",
                options: ["Francisco Pizarro", "Hernán Cortés", "Pedro de Alvarado", "Diego de Velázquez"],
                correctAnswer: 1,
                explanation: "Hernán Cortés led the conquest in 1519–1521."
            ),
            Question(
                text: "What is the currency of Mexico?",
                options: ["Peso", "Dollar", "Real", "Bolivar"],
                correctAnswer: 0,
                explanation: "The Mexican Peso (MXN) is the official currency."
            ),
            Question(
                text: "Which flower is a symbol of the Day of the Dead?",
                options: ["Rose", "Cempasúchil", "Daisy", "Orchid"],
                correctAnswer: 1,
                explanation: "Cempasúchil, or marigold, symbolizes the sun and life."
            ),
            Question(
                text: "What’s the meaning of 'Hola'?",
                options: ["Hi", "Goodbye", "Thanks", "Please"],
                correctAnswer: 0,
                explanation: "‘Hola’ = hello."
            ),
            Question(
                text: "What is Mexico’s independence day?",
                options: ["May 5", "Sept 16", "July 4", "Oct 12"],
                correctAnswer: 1,
                explanation: "September 16, not Cinco de Mayo!"
            ),
            Question(
                text: "Which color is NOT on the Mexican flag?",
                options: ["Red", "Blue", "White", "Green"],
                correctAnswer: 1,
                explanation: "The flag is green, white, and red."
            ),
            Question(
                text: "Where is Chichen Itzá located?",
                options: ["Yucatán", "Oaxaca", "Puebla", "Guerrero"],
                correctAnswer: 0,
                explanation: "Chichen Itzá is in Yucatán, one of the New 7 Wonders."
            )
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

