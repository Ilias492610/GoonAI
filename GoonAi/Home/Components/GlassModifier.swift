//
//  GlassModifier.swift
//  GoonAi
//
//  Glassmorphism styling for NoGoon
//

import SwiftUI

struct GlassModifier: ViewModifier {
    var cornerRadius: CGFloat = 20
    var opacity: Double = 0.15
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .opacity(opacity)
            )
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

extension View {
    func glassEffect(cornerRadius: CGFloat = 20, opacity: Double = 0.15) -> some View {
        self.modifier(GlassModifier(cornerRadius: cornerRadius, opacity: opacity))
    }
}

// MARK: - Starry Background

struct StarryBackgroundView: View {
    @State private var animateStars = false
    
    var body: some View {
        ZStack {
            // Base gradient
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.05, blue: 0.15),
                    Color(red: 0.1, green: 0.15, blue: 0.25),
                    Color(red: 0.05, green: 0.1, blue: 0.2)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Stars layer
            Canvas { context, size in
                let stars = generateStars(in: size)
                for star in stars {
                    var circle = Circle()
                        .path(in: CGRect(x: star.x, y: star.y, width: star.size, height: star.size))
                    context.fill(circle, with: .color(Color.white.opacity(star.opacity)))
                }
            }
            .ignoresSafeArea()
            .opacity(animateStars ? 1.0 : 0.5)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                animateStars = true
            }
        }
    }
    
    private func generateStars(in size: CGSize) -> [(x: CGFloat, y: CGFloat, size: CGFloat, opacity: Double)] {
        var stars: [(CGFloat, CGFloat, CGFloat, Double)] = []
        let starCount = 80
        
        for _ in 0..<starCount {
            let x = CGFloat.random(in: 0...size.width)
            let y = CGFloat.random(in: 0...size.height)
            let starSize = CGFloat.random(in: 1...3)
            let opacity = Double.random(in: 0.3...0.9)
            stars.append((x, y, starSize, opacity))
        }
        
        return stars
    }
}

