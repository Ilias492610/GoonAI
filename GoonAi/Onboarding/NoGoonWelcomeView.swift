//
//  NoGoonWelcomeView.swift
//  GoonAi
//
//  NoGoon onboarding welcome screen (based on Root.swift pattern)
//

import SwiftUI

struct NoGoonWelcomeView: View {
    let onStartQuiz: () -> Void
    let onAlreadyJoined: () -> Void
    
    var body: some View {
        ZStack {
            // Gradient background (matching QUITTR)
            LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.6, blue: 0.8),
                    Color(red: 0.1, green: 0.3, blue: 0.6)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            StarryBackgroundView()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Logo
                Text("NOGOON")
                    .font(.system(size: 42, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .tracking(4)
            
            Spacer()
            
                    // Welcome Section
                    VStack(spacing: 24) {
                        Text("Welcome!")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("Let's start by finding out if you have a problem with porn")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        // Star Rating Visual
                        HStack(spacing: 4) {
                            ForEach(0..<5) { _ in
                                Image(systemName: "star.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(.yellow)
                            }
                        }
                        .padding(.top, 8)
                        
                        Text("Trusted by thousands on their recovery journey")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.7))
                    }
            
            Spacer()
            
                // Buttons
                VStack(spacing: 16) {
                    // Start Quiz Button
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        onStartQuiz()
                    }) {
                        Text("Start Quiz")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(30)
                    }
                    .padding(.horizontal, 30)
                    
                    // Already Joined Button
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        onAlreadyJoined()
                    }) {
                        Text("Already joined via web?")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.vertical, 12)
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            AnalyticsManager.shared.trackEvent(eventName: "welcome_view_shown")
        }
    }
}

