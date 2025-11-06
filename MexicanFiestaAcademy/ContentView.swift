import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
            } else if appState.isFirstLaunch {
                OnboardingView()
            } else {
                MainTabView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showSplash = false
                }
            }
        }
    }
}

// MARK: - Splash View
struct SplashView: View {
    @State private var scale: CGFloat = 0.5
    @State private var rotation: Double = 0
    
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
            
            VStack(spacing: 20) {
                Image(.cap)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaleEffect(scale)
                    .rotationEffect(.degrees(rotation))
                
                Text("¡Viva México!")
                    .font(.custom("Mexicana", size: 48))
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 3)
                
                Text("FIESTA ACADEMY")
                     .font(.custom("Mexicana", size: 24))
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0).opacity(0.9))
                    .tracking(3)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 1.0, dampingFraction: 0.6)) {
                scale = 1.2
            }
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                rotation = 10
            }
        }
    }
}



#Preview {
    ContentView()
        .environmentObject(AppState())
}
