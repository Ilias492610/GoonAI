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
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            glowHalo
            baseSphere
            animatedSpectrum
            specularHighlights
        }
        .frame(width: 240, height: 240)
        .padding(.vertical, 30)
        .onAppear {
            withAnimation(.easeInOut(duration: 4.5).repeatForever(autoreverses: true)) {
                animateGlow = true
            }
            withAnimation(.linear(duration: 12).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

private extension StreakOrbView {
    var glowHalo: some View {
        Circle()
            .fill(
                RadialGradient(
                    colors: [
                        Color.white.opacity(0.35),
                        Color.white.opacity(0.0)
                    ],
                    center: .center,
                    startRadius: 60,
                    endRadius: 170
                )
            )
            .scaleEffect(animateGlow ? 1.15 : 1.0)
            .opacity(animateGlow ? 0.9 : 0.6)
    }
    
    var baseSphere: some View {
        Circle()
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 0.93, green: 0.97, blue: 1.0),
                        Color(red: 0.78, green: 0.86, blue: 1.0)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: 210, height: 210)
            .overlay(
                Circle()
                    .strokeBorder(Color.white.opacity(0.4), lineWidth: 1.5)
                    .blur(radius: 0.3)
            )
            .shadow(color: Color.white.opacity(0.4), radius: 30)
    }
    
    var animatedSpectrum: some View {
        Circle()
            .fill(
                AngularGradient(
                    colors: [
                        Color(red: 0.94, green: 0.99, blue: 1.0),
                        Color(red: 0.77, green: 0.86, blue: 1.0),
                        Color(red: 0.78, green: 0.73, blue: 0.99),
                        Color(red: 0.94, green: 0.99, blue: 1.0)
                    ],
                    center: .center,
                    angle: .degrees(rotation)
                )
            )
            .frame(width: 200, height: 200)
            .overlay(
                Circle()
                    .strokeBorder(
                        AngularGradient(
                            colors: [
                                Color.white.opacity(0.15),
                                Color.white.opacity(0.5),
                                Color.white.opacity(0.15)
                            ],
                            center: .center,
                            angle: .degrees(rotation)
                        ),
                        lineWidth: 8
                    )
                    .blur(radius: 18)
                    .opacity(0.8)
                    .blendMode(.screen)
                    .clipShape(Circle())
            )
            .overlay(
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color.white.opacity(0.9), Color.white.opacity(0.0)],
                            center: .topLeading,
                            startRadius: 0,
                            endRadius: 160
                        )
                    )
                    .blur(radius: 25)
                    .clipShape(Circle())
                    .opacity(0.9)
            )
    }
    
    var specularHighlights: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.white.opacity(0.4), lineWidth: 2)
                .blur(radius: 6)
                .blendMode(.screen)
                .frame(width: 215, height: 215)
            
            Circle()
                .trim(from: 0, to: 0.55)
                .stroke(
                    LinearGradient(
                        colors: [Color.white.opacity(0.0), Color.white.opacity(0.7)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .frame(width: 190, height: 190)
                .rotationEffect(.degrees(rotation / 1.5))
                .blur(radius: 3)
                .blendMode(.screen)
            
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(width: 140, height: 140)
                .blur(radius: 30)
                .blendMode(.screen)
        }
    }
}

