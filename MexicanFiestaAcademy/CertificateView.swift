import Foundation
import SwiftUI

struct CertificateView: View {
    @Environment(\.dismiss) var dismiss
    let percentage: Int
    let score: Int
    let totalQuestions: Int
    
    var body: some View {
        ZStack {
            // Certificate background with Mexican pattern
            LinearGradient(
                colors: [
                    Color(red: 0.98, green: 0.95, blue: 0.9),
                    Color(red: 1.0, green: 0.98, blue: 0.95)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Decorative border
            Rectangle()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color(red: 0.85, green: 0.2, blue: 0.3),
                            Color(red: 1.0, green: 0.6, blue: 0.0),
                            Color(red: 0.95, green: 0.8, blue: 0.1)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 8
                )
                .padding(20)
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
                
                Spacer()
                
                VStack(spacing: 24) {
                    Text("🎓")
                        .font(.system(size: 80))
                    
                    Text("Certificate of Excellence")
                    
                        .font(.custom("Mexicana", size: 32))
                    
                        .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.3))
                    
                    Text("Mexican Fiesta Academy")
                    
                        .font(.custom("Mexicana", size: 20))
                    
                        .foregroundColor(.gray)
                    
                    Divider()
                    
                        .padding(.vertical)
                    
                    Text("This certificate is awarded to")
                    
                        .font(.custom("Mexicana", size: 18))
                    
                        .foregroundColor(.gray)
                    
                    Text("[Outstanding Student]")
                    
                        .font(.custom("Mexicana", size: 28))
                    
                        .foregroundColor(Color(red: 0.85, green: 0.2, blue: 0.3))
                    
                    Text("For demonstrating exceptional mastery of the Mexican culture exam")
                        .font(.custom("Mexicana", size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(spacing: 8) {
                        Text("Calificación: \(percentage)%")
                            .font(.custom("Mexicana", size: 20))
                            .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.3))
                        
                        Text("\(score) de \(totalQuestions) preguntas correctas")
                            .font(.custom("Mexicana", size: 16))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(red: 0.2, green: 0.6, blue: 0.3).opacity(0.1))
                    )
                    
                    Text(Date(), style: .date)
                        .font(.custom("Mexicana", size: 16))
                        .foregroundColor(.gray)
                        .padding(.top)
                }
                .padding(40)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
                )
                .padding(40)
                
                Spacer()
            }
        }
    }
}
