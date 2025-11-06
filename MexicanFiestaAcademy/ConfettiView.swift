import Foundation
import SwiftUI

struct ConfettiView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            ForEach(0..<50) { i in
                Text(["🎉", "🎊", "⭐", "🌟", "🎈", "🏆"].randomElement()!)
                    .font(.system(size: 20))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: animate ? UIScreen.main.bounds.height + 100 : -100
                    )
                    .animation(
                        Animation.spring(response: 0.8, dampingFraction: 0.6)
                            .delay(Double(i) * 0.05),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
    }
}
