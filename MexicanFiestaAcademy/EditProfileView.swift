import Foundation
import SwiftUI
// MARK: - Edit Profile View
struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    @State private var name: String = ""
    @State private var selectedAvatar = "🌮"
    
    private let avatars = ["🌮", "🌯", "🫔", "🥑", "🌶️", "🎉", "🎭", "🎸", "💃", "🏴"]
    
    var body: some View {
        NavigationView {
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
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Avatar selection
                        VStack(spacing: 16) {
                            Text("Elige tu avatar")
                                .font(.custom("Mexicana", size: 24))
                                .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                                .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 16) {
                                ForEach(avatars, id: \.self) { avatar in
                                    Button {
                                        selectedAvatar = avatar
                                    } label: {
                                        Text(avatar)
                                            .font(.system(size: 40))
                                            .frame(width: 60, height: 60)
                                            .background(
                                                Circle()
                                                    .fill(
                                                        selectedAvatar == avatar ?
                                                        LinearGradient(
                                                            colors: [Color(red: 1.0, green: 0.8, blue: 0.0), Color(red: 0.9, green: 0.7, blue: 0.0)],
                                                            startPoint: .topLeading,
                                                            endPoint: .bottomTrailing
                                                        ) :
                                                            LinearGradient(
                                                                colors: [Color(red: 3.0, green: 2.8, blue: 3.0), Color(red: 1.9, green: 1.7, blue: 0.0)],
                                                                startPoint: .topLeading,
                                                                endPoint: .bottomTrailing
                                                            )
                                                    )
                                            )
                                            .overlay(
                                                selectedAvatar == avatar ?
                                                Circle()
                                                    .stroke(Color.white, lineWidth: 3)
                                                    .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
                                                : nil
                                            )
                                            .scaleEffect(selectedAvatar == avatar ? 1.1 : 1.0)
                                    }
                              
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.1))
                        )
                        .padding(.horizontal)
                        
                        // Name input
                        VStack(alignment: .leading, spacing: 8) {
                        Text("Your name")
                        .font(.custom("Mexican", size: 18))
                        .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                        .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)

                        TextField("Name", text: $name)
                        .font(.custom("Mexican", size: 18))
                        .foregroundColor(.white)
                        .padding()
                        .background(
                        RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.1))
                        )
                        .overlay(
                        RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                        }
                        .padding(.horizontal)
                        
                        Button {
                            saveProfile()
                        } label: {
                        Text("Save changes")
                        .font(.custom("Mexican", size: 18))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                        RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 1.0, green: 0.8, blue: 0.0))
                        .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 3)
                        )
                        }
                        .padding(.horizontal)
                        }
                        .padding(.vertical)
                        }
                        }
                        .navigationTitle("Edit profile")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Close") {
                        dismiss()
                        }
                        .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.0))
                        }
            }
        }
        .onAppear {
            name = appState.currentUser?.name ?? ""
            selectedAvatar = appState.currentUser?.avatar ?? "🌮"
        }
    }
    
    private func saveProfile() {
        appState.currentUser?.name = name
        appState.currentUser?.avatar = selectedAvatar
        dismiss()
    }
}
