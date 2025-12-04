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
            
            VStack(spacing: 0) {
                // Title Section
                VStack(spacing: 12) {
                    Text("Let's Go!")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Welcome to NoGoon. Here's your tracked profile card.")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                .padding(.top, 60)
                
                Spacer()
                
                // Profile Card with sparkle decoration
                ZStack(alignment: .topTrailing) {
                    QTRCard()
                    
                    // Sparkle decoration
                    Image(systemName: "sparkle")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.orange)
                        .offset(x: 30, y: -30)
                }
                
                Spacer()
                
                // Bottom section
                VStack(spacing: 24) {
                    // Text
                    Text("Now, let's build the app around you.")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.8))
                    
                    // Next Button
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        onComplete()
                    }) {
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
                                            colors: [Color(red: 0.2, green: 0.4, blue: 0.9), Color(red: 0.3, green: 0.5, blue: 1.0)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                            )
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.3)) {
                showCard = true
            }
        }
    }
}
