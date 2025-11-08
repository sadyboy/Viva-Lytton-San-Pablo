import SwiftUI

struct LessonDetailView: View {
    let lesson: LessonNode
    @Environment(\.dismiss) var dismiss
    @StateObject var appState =  AppState()
    @State private var currentQuestion = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showResult = false
    @State private var score = 0
    @State private var isCorrect = false
    @State private var showCompletion = false
    @State private var showCelebration = false
    
    private var questions: [Question] {
        switch lesson.title {
        case "Greetings":
            return greetingsQuestions
        case "Introductions":
            return introductionsQuestions
        case "Numbers":
            return numbersQuestions
        case "Colors":
            return colorsQuestions
        default:
            return greetingsQuestions
        }
    }

    // Questions for "Greetings" theme
    private let greetingsQuestions = [
        Question(
            text: "How do you say 'Hello' in Spanish?",
            options: ["Goodbye", "Hello", "Good night", "See you later"],
            correctAnswer: 1,
            explanation: "Correct! 'Hola' is the most common way to greet in Spanish."
        ),
        Question(
            text: "What does '¿Cómo estás?' mean in English?",
            options: ["How are you?", "Thank you", "Goodbye", "Hello"],
            correctAnswer: 0,
            explanation: "Excellent! '¿Cómo estás?' means 'How are you?'"
        ),
        Question(
            text: "How would you respond to 'Buenos días'?",
            options: ["Good night", "Good morning too", "Goodbye", "See you tomorrow"],
            correctAnswer: 1,
            explanation: "Perfect! It's polite to respond with 'Buenos días' back."
        ),
        Question(
            text: "What does 'Mucho gusto' mean?",
            options: ["Goodbye", "Nice to meet you", "Thank you", "Excuse me"],
            correctAnswer: 1,
            explanation: "Good! 'Mucho gusto' is used when you meet someone for the first time."
        ),
        Question(
            text: "How do you say 'Goodbye' formally?",
            options: ["Goodbye", "Hello", "See you later", "Good morning"],
            correctAnswer: 0,
            explanation: "Correct! 'Adiós' is the formal way to say goodbye."
        ),
        Question(
            text: "What expression would you use in the afternoon?",
            options: ["Good morning", "Good afternoon", "Good night", "Hello"],
            correctAnswer: 1,
            explanation: "Exactly! 'Buenas tardes' is used from noon until evening."
        ),
        Question(
            text: "How do you respond to '¿Qué tal?'?",
            options: ["Fine, thanks", "See you later", "Good morning", "Nice to meet you"],
            correctAnswer: 0,
            explanation: "Very good! 'Bien, gracias' is the most common response."
        ),
        Question(
            text: "What is the informal way to say goodbye?",
            options: ["Goodbye", "See you", "Good night", "Nice to meet you"],
            correctAnswer: 1,
            explanation: "Correct! 'Nos vemos' is informal and friendly."
        ),
        Question(
            text: "What does 'Hasta mañana' mean?",
            options: ["See you tomorrow", "Good night", "Good morning", "See you later"],
            correctAnswer: 0,
            explanation: "Excellent! 'Hasta mañana' means 'See you tomorrow'."
        ),
        Question(
            text: "How do you greet at night?",
            options: ["Good morning", "Good afternoon", "Good night", "Hello"],
            correctAnswer: 2,
            explanation: "Perfect! 'Buenas noches' is used at night."
        ),
        Question(
            text: "What expression do you use to introduce yourself?",
            options: ["My name is...", "How are you?", "Fine, thanks", "See you later"],
            correctAnswer: 0,
            explanation: "Very good! 'Me llamo...' means 'My name is...'"
        ),
        Question(
            text: "How do you say 'See you later' in Spanish?",
            options: ["Goodbye", "See you later", "Good morning", "Nice to meet you"],
            correctAnswer: 1,
            explanation: "Correct! 'Hasta luego' is 'See you later'."
        ),
        Question(
            text: "What does 'Encantado/a' mean?",
            options: ["Goodbye", "Nice to meet you", "Thank you", "Hello"],
            correctAnswer: 1,
            explanation: "Good! 'Encantado/a' is another way to say 'Mucho gusto'."
        )
    ]

    // Questions for "Introductions" theme
    private let introductionsQuestions = [
        Question(
            text: "How do you say 'My name is Carlos'?",
            options: ["My name is Carlos", "I am Carlos", "My name Carlos", "I Carlos"],
            correctAnswer: 0,
            explanation: "Correct! 'Me llamo Carlos' is the most common way."
        ),
        Question(
            text: "What do you ask to know someone's name?",
            options: ["What's your name?", "How's it going?", "Where are you from?", "How old are you?"],
            correctAnswer: 0,
            explanation: "Excellent! '¿Cómo te llamas?' means 'What's your name?'"
        ),
        Question(
            text: "How do you respond to 'Mucho gusto'?",
            options: ["Likewise", "Goodbye", "Fine", "Hello"],
            correctAnswer: 0,
            explanation: "Perfect! 'Igualmente' means 'Likewise' or 'Nice to meet you too'."
        ),
        Question(
            text: "What does 'Soy de México' mean?",
            options: ["I'm from Mexico", "I live in Mexico", "I like Mexico", "I visit Mexico"],
            correctAnswer: 0,
            explanation: "Good! 'Soy de...' means 'I'm from...'"
        ),
        Question(
            text: "How do you ask where someone is from?",
            options: ["Where do you live?", "Where are you from?", "What do you do?", "How are you?"],
            correctAnswer: 1,
            explanation: "Correct! '¿De dónde eres?' means 'Where are you from?'"
        ),
        Question(
            text: "What does '¿A qué te dedicas?' mean?",
            options: ["What do you do?", "Where do you live?", "How old are you?", "What's your name?"],
            correctAnswer: 0,
            explanation: "Excellent! It's a way to ask about work or studies."
        ),
        Question(
            text: "How do you say 'I am a student'?",
            options: ["I am student", "I am being student", "I have student", "I do student"],
            correctAnswer: 0,
            explanation: "Very good! You use 'ser' for professions and occupations."
        ),
        Question(
            text: "What does 'Vivo en Madrid' mean?",
            options: ["I work in Madrid", "I study in Madrid", "I live in Madrid", "I visit Madrid"],
            correctAnswer: 2,
            explanation: "Correct! 'Vivo en...' means 'I live in...'"
        ),
        Question(
            text: "How do you ask someone's age?",
            options: ["What age do you have?", "How many years do you have?", "How are you of age?", "What years?"],
            correctAnswer: 1,
            explanation: "Perfect! '¿Cuántos años tienes?' is the correct way."
        ),
        Question(
            text: "What does 'Tengo veinte años' mean?",
            options: ["I have 20 brothers", "I am 20 years old", "I live 20 years", "I work 20 hours"],
            correctAnswer: 1,
            explanation: "Good! 'Tengo... años' means 'I am... years old'."
        ),
        Question(
            text: "How do you say 'Nice to meet you' formally?",
            options: ["Mucho gusto", "Encantado/a", "Es un placer", "All of the above"],
            correctAnswer: 3,
            explanation: "Excellent! All are correct ways to say it."
        ),
        Question(
            text: "What does '¿Hablas inglés?' mean?",
            options: ["Do you speak English?", "Where is English?", "I speak English", "English is easy"],
            correctAnswer: 0,
            explanation: "Correct! '¿Hablas...?' means 'Do you speak...?'"
        )
    ]

    // Questions for "Numbers" theme
    private let numbersQuestions = [
        Question(
            text: "How do you say '1' in Spanish?",
            options: ["One", "Two", "Three", "Four"],
            correctAnswer: 0,
            explanation: "Correct! 'Uno' is the number 1."
        ),
        Question(
            text: "What number is 'cinco'?",
            options: ["3", "5", "7", "9"],
            correctAnswer: 1,
            explanation: "Excellent! 'Cinco' is the number 5."
        ),
        Question(
            text: "How do you say '10' in Spanish?",
            options: ["Eight", "Nine", "Ten", "Eleven"],
            correctAnswer: 2,
            explanation: "Perfect! 'Diez' is the number 10."
        ),
        Question(
            text: "What number is 'quince'?",
            options: ["12", "15", "17", "20"],
            correctAnswer: 1,
            explanation: "Good! 'Quince' is the number 15."
        ),
        Question(
            text: "How do you say '20' in Spanish?",
            options: ["Nineteen", "Twenty", "Twenty-one", "Thirty"],
            correctAnswer: 1,
            explanation: "Correct! 'Veinte' is the number 20."
        ),
        Question(
            text: "What does 'treinta y cinco' mean?",
            options: ["25", "35", "45", "55"],
            correctAnswer: 1,
            explanation: "Excellent! 'Treinta y cinco' is 35."
        ),
        Question(
            text: "How do you say '100' in Spanish?",
            options: ["One hundred", "One hundred (with noun)", "One thousand", "Ten"],
            correctAnswer: 0,
            explanation: "Very good! 'Cien' is the number 100."
        ),
        Question(
            text: "What number is 'setenta'?",
            options: ["60", "70", "80", "90"],
            correctAnswer: 1,
            explanation: "Correct! 'Setenta' is the number 70."
        ),
        Question(
            text: "How do you say '500' in Spanish?",
            options: ["Five hundred", "Five hundreds", "Five hundred", "Five hundred (feminine)"],
            correctAnswer: 0,
            explanation: "Perfect! 'Quinientos' is the number 500."
        ),
        Question(
            text: "What does 'mil' mean?",
            options: ["100", "500", "1000", "5000"],
            correctAnswer: 2,
            explanation: "Good! 'Mil' is the number 1000."
        ),
        Question(
            text: "How do you say 'first' in Spanish?",
            options: ["One", "First", "First (masculine)", "First (feminine)"],
            correctAnswer: 1,
            explanation: "Excellent! 'Primero' means 'first'."
        ),
        Question(
            text: "What does 'segundo' mean?",
            options: ["Second", "Third", "Fourth", "Fifth"],
            correctAnswer: 0,
            explanation: "Correct! 'Segundo' means 'second'."
        )
    ]

    // Questions for "Colors" theme
    private let colorsQuestions = [
        Question(
            text: "How do you say 'red' in Spanish?",
            options: ["Blue", "Red", "Green", "Yellow"],
            correctAnswer: 1,
            explanation: "Correct! 'Rojo' is the color red."
        ),
        Question(
            text: "What color is 'azul'?",
            options: ["Red", "Blue", "Green", "Yellow"],
            correctAnswer: 1,
            explanation: "Excellent! 'Azul' is the color blue."
        ),
        Question(
            text: "How do you say 'green' in Spanish?",
            options: ["Red", "Blue", "Green", "White"],
            correctAnswer: 2,
            explanation: "Perfect! 'Verde' is the color green."
        ),
        Question(
            text: "What color is 'amarillo'?",
            options: ["Red", "Blue", "Yellow", "Orange"],
            correctAnswer: 2,
            explanation: "Good! 'Amarillo' is the color yellow."
        ),
        Question(
            text: "How do you say 'white' in Spanish?",
            options: ["Black", "White", "Gray", "Brown"],
            correctAnswer: 1,
            explanation: "Correct! 'Blanco' is the color white."
        ),
        Question(
            text: "What color is 'negro'?",
            options: ["White", "Black", "Gray", "Brown"],
            correctAnswer: 1,
            explanation: "Excellent! 'Negro' is the color black."
        ),
        Question(
            text: "How do you say 'pink' in Spanish?",
            options: ["Pink", "Purple", "Orange", "Light blue"],
            correctAnswer: 0,
            explanation: "Very good! 'Rosado' or 'rosa' is the color pink."
        ),
        Question(
            text: "What color is 'morado'?",
            options: ["Pink", "Purple", "Orange", "Brown"],
            correctAnswer: 1,
            explanation: "Correct! 'Morado' is the color purple."
        ),
        Question(
            text: "How do you say 'orange' in Spanish?",
            options: ["Pink", "Orange", "Yellow", "Red"],
            correctAnswer: 1,
            explanation: "Perfect! 'Naranja' is the color orange."
        ),
        Question(
            text: "What does 'marrón' mean?",
            options: ["Gray", "Brown", "Beige", "Gold"],
            correctAnswer: 1,
            explanation: "Good! 'Marrón' is the color brown."
        ),
        Question(
            text: "How do you say 'light blue' in Spanish?",
            options: ["Dark blue", "Light blue", "Navy blue", "Turquoise"],
            correctAnswer: 1,
            explanation: "Excellent! 'Celeste' is light blue."
        ),
        Question(
            text: "What color is 'dorado'?",
            options: ["Silver", "Gold", "Bronze", "Copper"],
            correctAnswer: 1,
            explanation: "Correct! 'Dorado' is the color gold."
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
            
            if showCelebration {
                ConfettiView()
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .font(.custom("Mexicana", size: 16))
                        .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(Color.black.opacity(0.6))
                                .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
                        )
                    }
                    
                    Spacer()
                    
                    // Progress bar
                    VStack(spacing: 8) {
                        Text("Question \(currentQuestion + 1)/\(questions.count)")
                            .font(.custom("Mexicana", size: 14))
                            .foregroundColor(.white.opacity(0.9))
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.black.opacity(0.4))
                                .frame(height: 8)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 1.0, green: 0.8, blue: 0.0),
                                            Color(red: 0.9, green: 0.7, blue: 0.0)
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: CGFloat(currentQuestion + 1) / CGFloat(questions.count) * 150, height: 8)
                        }
                        .frame(width: 150)
                    }
                    
                    Spacer()
                    
                    // Score
                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                            .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
                        
                        Text("\(score)")
                            .font(.custom("Mexicana", size: 18))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(Color.black.opacity(0.6))
                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                    )
                }
                .padding()
                
                ScrollView {
                    VStack(spacing: 30) {
                        VStack(spacing: 20) {
                            Text(lesson.emoji)
                                .font(.system(size: 80))
                                .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 3)
                            
                            VStack(spacing: 12) {
                                Text(lesson.title)
                                    .font(.custom("Mexicana", size: 32))
                                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                                
                                Text(lesson.description)
                                    .font(.custom("Mexicana", size: 18))
                                    .foregroundColor(.white.opacity(0.9))
                                    .multilineTextAlignment(.center)
                                    .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
                            }
                            
                            HStack(spacing: 8) {
                                Circle()
                                    .fill(lesson.difficulty.color)
                                    .frame(width: 12, height: 12)
                                
                                Text(lesson.difficulty.text)
                                    .font(.custom("Mexicana", size: 14))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(Color.black.opacity(0.6))
                            )
                        }
                        .padding(.vertical, 30)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white.opacity(0.1))
                                .shadow(color: .black.opacity(0.4), radius: 15, x: 0, y: 10)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white.opacity(0.2), lineWidth: 2)
                        )
                        .padding(.horizontal)
                        
                        if !showCompletion {
                            QuestionCard(
                                question: questions[currentQuestion],
                                selectedAnswer: $selectedAnswer,
                                showResult: $showResult,
                                isCorrect: $isCorrect
                            )
                        }
                        
                        if showResult && !showCompletion {
                            Button {
                                nextQuestion()
                            } label: {
                                HStack {
                                    Text(currentQuestion < questions.count - 1 ? "Next Question" : "End Lesson")
                                    .font(.custom("Mexicana", size: 18))
                                    
                                    Image(systemName: "arrow.right.circle.fill")
                                        .font(.system(size: 20))
                                }
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 18)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color(red: 1.0, green: 0.8, blue: 0.0))
                                        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
                                )
                            }
                            .padding(.horizontal, 40)
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
            
            if showCompletion {
                CompletionView(
                    score: score,
                    maxScore: questions.count * 100,
                    lessonTitle: lesson.title,
                    onDismiss: {
                        appState.userProgress.addScore(score)
                        appState.userProgress.completeLesson(lesson.id)
                        dismiss()
                    }
                )
            }
        }
        .navigationBarHidden(true)
    }
    
    private func nextQuestion() {
        if currentQuestion < questions.count - 1 {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                currentQuestion += 1
                selectedAnswer = nil
                showResult = false
                isCorrect = false
            }
        } else {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                showCompletion = true
                showCelebration = true
            }
        }
    }
}

