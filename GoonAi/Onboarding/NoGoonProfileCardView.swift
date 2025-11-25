//
//  NoGoonProfileCardView.swift
//  GoonAi
//
//  Profile card reveal screen
//

import SwiftUI

struct NoGoonProfileCardView: View {
    @ObservedObject var quizState: OnboardingQuizState
    let onComplete: () -> Void
    let onBack: () -> Void
    
    @State private var showCard = false
    
    private var freeSinceDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return formatter.string(from: Date())
    }
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 40) {
                // Top Bar
                HStack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)
                
                Spacer()
                
                // Title
                VStack(spacing: 16) {
                    Text("Let's Go!")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Welcome to NoGoon. Here's your tracked profile card.")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                // Profile Card
                VStack(spacing: 0) {
                    // Gradient top section
                    VStack(spacing: 20) {
                        HStack {
                            // Logo
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 60, height: 60)
                                
                                Text("NG")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                            
                            // Icon
                            Image(systemName: "person.crop.circle.badge.checkmark")
                                .font(.system(size: 32))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                        
                        Spacer()
                        
                        // Streak Info
                        VStack(spacing: 8) {
                            Text("Active Streak")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                            
                            Text("0 days")
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 24)
                    }
                    .frame(height: 280)
                    .background(
                        LinearGradient(
                            colors: [
                                Color(red: 1.0, green: 0.4, blue: 0.2),
                                Color(red: 1.0, green: 0.6, blue: 0.3),
                                Color(red: 0.2, green: 0.6, blue: 0.9)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    
                    // Dark bottom section
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Name")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                            
                            Text(quizState.userName.isEmpty ? "User" : quizState.userName)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("Free since")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                            
                            Text(freeSinceDate)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(24)
                    .background(
                        Color(red: 0.15, green: 0.15, blue: 0.2)
                    )
                }
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 20)
                .padding(.horizontal, 30)
                .scaleEffect(showCard ? 1.0 : 0.8)
                .opacity(showCard ? 1.0 : 0)
                
                // Sparkle icon
                if showCard {
                    Image(systemName: "sparkles")
                        .font(.system(size: 60))
                        .foregroundColor(.yellow)
                        .rotationEffect(.degrees(15))
                        .transition(.scale.combined(with: .opacity))
                }
                
                Spacer()
                
                // Text
                Text("Now, let's build the app around you.")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.horizontal, 40)
                
                // Next Button
                Button(action: onComplete) {
                    Text("Next")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [.blue, .cyan],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .shadow(color: .cyan.opacity(0.4), radius: 15, x: 0, y: 10)
                        )
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
                .opacity(showCard ? 1.0 : 0)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.3)) {
                showCard = true
            }
        }
    }
}

// MARK: - Reflection Screen

struct NoGoonReflectionView: View {
    let onComplete: () -> Void
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.05, blue: 0.2),
                    Color(red: 0.3, green: 0.1, blue: 0.3),
                    Color(red: 0.05, green: 0.1, blue: 0.2)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Starry overlay
            StarryBackgroundView()
                .opacity(0.5)
            
            // Shooting star effect
            VStack {
                Spacer()
                
                VStack(spacing: 24) {
                    Text("NOGOON")
                        .font(.system(size: 42, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .tracking(4)
                    
                    VStack(spacing: 16) {
                        Text("Embrace this pause.")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Text("Reflect before you relapse.")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                
                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                onComplete()
            }
        }
    }
}

