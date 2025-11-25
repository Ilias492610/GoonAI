//
//  NoGoonAllInOneView.swift
//  GoonAi
//
//  All-in-one tools overview screen
//

import SwiftUI

struct NoGoonAllInOneView: View {
    let onComplete: () -> Void
    
    var body: some View {
        ZStack {
            // Dark gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.1, blue: 0.2),
                    Color(red: 0.1, green: 0.15, blue: 0.3)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            StarryBackgroundView()
            
            VStack(spacing: 40) {
                Spacer()
                
                // QUITTR logo
                Text("QUITTR")
                    .font(.system(size: 24, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .tracking(3)
                
                // Title
                Text("All in one place")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                // Subtitle
                Text("Content filtering, meditations and more to help maintain control.")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                // Phone mockup image placeholder
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 300, height: 600)
                    .overlay(
                        VStack(spacing: 20) {
                            Text("📱")
                                .font(.system(size: 80))
                            
                            Text("Library Tab Preview")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.6))
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("• Breathing Exercise")
                                Text("• Melius AI Therapist")
                                Text("• Meditate")
                                Text("• Porn Research")
                                Text("• Articles")
                                Text("• Podcasts")
                                Text("• Leaderboard")
                            }
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        }
                    )
                
                Spacer()
                
                // Continue button
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    onComplete()
                }) {
                    Text("Continue")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
        }
    }
}

