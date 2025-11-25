//
//  StreakOrbView.swift
//  GoonAi
//
//  Streak orb component for Home
//

import SwiftUI

struct StreakOrbView: View {
    let currentTier: StreakTier
    let nextTier: StreakTier?
    let currentDays: Int
    let onTap: () -> Void
    
    @State private var animateGlow = false
    
    var body: some View {
        ZStack {
            // Next tier ghost orb (background)
            if let next = nextTier {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.1),
                                Color.white.opacity(0.05)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 180, height: 180)
                    .blur(radius: 20)
                    .offset(x: 80, y: -20)
                    .overlay(
                        VStack(spacing: 4) {
                            Text(next.name)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                            Text("\(next.minDays) days")
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.4))
                        }
                        .offset(x: 80, y: 80)
                    )
            }
            
            // Main current tier orb
            VStack(spacing: 0) {
                ZStack {
                    // Outer glow
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.white.opacity(0.4),
                                    Color.white.opacity(0.0)
                                ],
                                center: .center,
                                startRadius: 80,
                                endRadius: 120
                            )
                        )
                        .frame(width: 240, height: 240)
                        .opacity(animateGlow ? 1.0 : 0.5)
                    
                    // Main orb with metallic gradient
                    Circle()
                        .fill(
                            AngularGradient(
                                colors: [
                                    Color(red: 0.8, green: 0.85, blue: 0.9),
                                    Color(red: 0.9, green: 0.92, blue: 0.95),
                                    Color(red: 0.75, green: 0.8, blue: 0.88),
                                    Color(red: 0.85, green: 0.88, blue: 0.92),
                                    Color(red: 0.8, green: 0.85, blue: 0.9)
                                ],
                                center: .center,
                                angle: .degrees(animateGlow ? 360 : 0)
                            )
                        )
                        .frame(width: 200, height: 200)
                        .overlay(
                            // Subtle radial gradient overlay for depth
                            RadialGradient(
                                colors: [
                                    Color.white.opacity(0.6),
                                    Color.clear,
                                    Color.black.opacity(0.2)
                                ],
                                center: .topLeading,
                                startRadius: 20,
                                endRadius: 150
                            )
                        )
                        .shadow(color: Color.white.opacity(0.3), radius: 20, x: 0, y: 0)
                    
                    // Inner highlight
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.white.opacity(0.8),
                                    Color.white.opacity(0.0)
                                ],
                                center: .topLeading,
                                startRadius: 0,
                                endRadius: 100
                            )
                        )
                        .frame(width: 200, height: 200)
                        .blur(radius: 10)
                }
                
                // Streak info below orb
                VStack(spacing: 8) {
                    Text(currentTier.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("\(currentDays) days")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.top, 20)
            }
        }
        .onTapGesture {
            onTap()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true)) {
                animateGlow = true
            }
        }
    }
}

