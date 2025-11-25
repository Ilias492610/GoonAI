//
//  TierUnlockView.swift
//  GoonAi
//
//  Tier unlock celebration overlay
//

import SwiftUI

struct TierUnlockView: View {
    let tier: StreakTier
    let days: Int
    let onContinue: () -> Void
    
    @State private var animateOrb = false
    
    var body: some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Glowing orb (similar to main orb but celebratory)
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.yellow.opacity(0.6),
                                    Color.orange.opacity(0.3),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 50,
                                endRadius: 150
                            )
                        )
                        .frame(width: 300, height: 300)
                        .blur(radius: 30)
                        .scaleEffect(animateOrb ? 1.2 : 1.0)
                    
                    Circle()
                        .fill(
                            AngularGradient(
                                colors: [
                                    Color(red: 0.9, green: 0.85, blue: 0.7),
                                    Color(red: 0.95, green: 0.9, blue: 0.75),
                                    Color(red: 0.85, green: 0.8, blue: 0.68),
                                    Color(red: 0.9, green: 0.85, blue: 0.7)
                                ],
                                center: .center
                            )
                        )
                        .frame(width: 180, height: 180)
                        .overlay(
                            RadialGradient(
                                colors: [
                                    Color.white.opacity(0.6),
                                    Color.clear,
                                    Color.black.opacity(0.2)
                                ],
                                center: .topLeading,
                                startRadius: 20,
                                endRadius: 120
                            )
                        )
                        .shadow(color: Color.yellow.opacity(0.5), radius: 30)
                }
                
                // Celebration text
                VStack(spacing: 12) {
                    Text("🏆 \(tier.name) unlocked!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("\(percentTowardGoal)% toward complete sobriety")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("\(days)/\(days) Days")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                .multilineTextAlignment(.center)
                
                Spacer()
                
                // Continue button
                Button {
                    onContinue()
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                        )
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                animateOrb = true
            }
        }
    }
    
    private var percentTowardGoal: Int {
        // Assuming 90 days is the goal
        return min(100, (days * 100) / 90)
    }
}

