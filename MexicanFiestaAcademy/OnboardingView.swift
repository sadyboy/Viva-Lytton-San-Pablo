//
//  OnboardingView.swift
//  Mexican Fiesta Academy
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentPage = 0
    @State private var userName = ""
    @State private var showNameInput = false
    
    private let pages: [OnboardingPage] = [
        OnboardingPage(
            emoji: "🇲🇽",
            title: "Welcome to Mexico",
            description: "Explore Mexico's rich culture, language, and traditions through engaging games and lessons",
            color: Color(red: 0.85, green: 0.2, blue: 0.3)
        ),
        OnboardingPage(
            emoji: "📚",
            title: "Learn the fun way",
            description: "Learn Spanish, history, and geography through interactive lessons",
            color: Color(red: 1.0, green: 0.6, blue: 0.0)
        ),
        OnboardingPage(
            emoji: "🎮",
            title: "Play and earn",
            description: "Complete minigames, earn points, and unlock achievements",
            color: Color(red: 0.0, green: 0.5, blue: 0.3)
        )
    ]
    
    var body: some View {
        ZStack {
            // Background
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
                .animation(.easeInOut, value: currentPage)
            
            VStack {
                Spacer()
                
                if !showNameInput {
                    // Onboarding pages
                    VStack(spacing: 30) {
                        Text(pages[currentPage].emoji)
                            .font(.system(size: 120))
                            .transition(.scale.combined(with: .opacity))
                            .id("emoji-\(currentPage)")
                        
                        VStack(spacing: 16) {
                            Text(pages[currentPage].title)
                                .font(.custom("Mexicana", size: 36))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text(pages[currentPage].description)
                                .font(.custom("Mexicana", size: 18))
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        .transition(.opacity)
                        .id("text-\(currentPage)")
                    }
                    .padding(.bottom, 40)
                    
                    // Page indicator
                    HStack(spacing: 12) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Circle()
                                .fill(index == currentPage ? Color.white : Color.white.opacity(0.4))
                                .frame(width: index == currentPage ? 12 : 8, height: index == currentPage ? 12 : 8)
                                .animation(.spring(), value: currentPage)
                        }
                    }
                    .padding(.bottom, 30)
                    
                } else {
                    // Name input
                    VStack(spacing: 30) {
                        Text("👋")
                            .font(.system(size: 100))
                        
                        Text("What's your name?")
                        .font(.custom("Mexicana", size: 32))
                        .foregroundColor(.white)

                        TextField("Enter your name", text: $userName)
                            .font(.custom("Mexicana", size: 20))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .padding(.horizontal, 40)
                            .foregroundColor(.brand)
                    }
                    .padding(.bottom, 40)
                }
                
                // Buttons
                if !showNameInput {
                    Button {
                        if currentPage < pages.count - 1 {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                currentPage += 1
                            }
                        } else {
                            withAnimation {
                                showNameInput = true
                            }
                        }
                    } label: {
                        Text(currentPage < pages.count - 1 ? "Next": "Start")                     .font(.custom("Mexicana", size: 20))
                            .foregroundColor(pages[currentPage].color)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 40)
                    
                    if currentPage > 0 {
                        Button {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                currentPage -= 1
                            }
                        } label: {
                            Text("Back")
                                .font(.custom("Mexicana", size: 16))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.top, 10)
                    }
                } else {
                    Button {
                        startApp()
                    } label: {
                        Text("Let's go!")
                             .font(.custom("Mexicana", size: 20))
                            .foregroundColor(Color(red: 0.0, green: 0.5, blue: 0.3))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 40)
                    .disabled(userName.isEmpty)
                    .opacity(userName.isEmpty ? 0.5 : 1.0)
                }
                
                Spacer()
            }
        }
    }
    
    private func startApp() {
        let user = User(name: userName.isEmpty ? "Friend" : userName)
        appState.currentUser = user
        appState.isFirstLaunch = false
    }
}

struct OnboardingPage {
    let emoji: String
    let title: String
    let description: String
    let color: Color
}

#Preview {
    OnboardingView()
        .environmentObject(AppState())
}
