import Foundation
import SwiftUI

// MARK: - Custom Tab Bar
struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    private let tabs = [
        TabItem(icon: "house.fill", title: "Home", color: Color(red: 1.0, green: 0.8, blue: 0.0)),
        TabItem(icon: "book.fill", title: "Learn", color: Color(red: 1.0, green: 0.8, blue: 0.0)),
        TabItem(icon: "gamecontroller.fill", title: "Games", color: Color(red: 1.0, green: 0.8, blue: 0.0)),
        TabItem(icon: "person.fill", title: "Profile", color: Color(red: 1.0, green: 0.8, blue: 0.0))
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = index
                    }
                } label: {
                    VStack(spacing: 6) {
                        Image(tabs[index].icon)
                            .resizable()
                            .frame(width: selectedTab == index ? 34 : 32, height: selectedTab == index ? 34 : 32)
                            .fontWeight(selectedTab == index ? .bold : .medium)
                            .foregroundColor(selectedTab == index ? tabs[index].color : .gray)
                            .frame(width: 30, height: 30)
                        
                        Text(tabs[index].title)
                            .font(.custom("Mexicana", size: 10))
                            .foregroundColor(selectedTab == index ? tabs[index].color : .gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        selectedTab == index ?
                        AnyView(
                            LinearGradient(
                                colors: [
                                    Color(red: 1.0, green: 0.8, blue: 0.0).opacity(0.3),
                                    Color(red: 0.9, green: 0.7, blue: 0.0).opacity(0.2)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        ) : AnyView(Color.clear)
                    )
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.15, green: 0.15, blue: 0.15),
                            Color(red: 0.2, green: 0.2, blue: 0.2),
                            Color(red: 0.25, green: 0.25, blue: 0.25)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(color: .black.opacity(0.4), radius: 15, x: 0, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color(red: 1.0, green: 0.8, blue: 0.0).opacity(0.3), lineWidth: 1)
                )
        )
        .padding(.horizontal, 20)
    }
}

struct TabItem {
    let icon: String
    let title: String
    let color: Color
}
