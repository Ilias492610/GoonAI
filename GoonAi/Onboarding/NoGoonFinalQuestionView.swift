//
//  NoGoonFinalQuestionView.swift
//  GoonAi
//
//  Final question screen for name and age
//

import SwiftUI

struct NoGoonFinalQuestionView: View {
    @ObservedObject var quizState: OnboardingQuizState
    let onComplete: () -> Void
    let onBack: () -> Void
    
    var body: some View {
        ZStack {
            // Dark blue gradient background (matching NoGoonQuizView)
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.1, blue: 0.2),
                    Color(red: 0.08, green: 0.15, blue: 0.25)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar with back button and progress bar
                HStack(spacing: 16) {
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        onBack()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    // Progress bar (full)
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            // Background
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.white.opacity(0.2))
                                .frame(height: 6)
                            
                            // Progress (full)
                            RoundedRectangle(cornerRadius: 4)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.cyan, Color.blue],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: geometry.size.width, height: 6)
                        }
                    }
                    .frame(height: 6)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Title
                Text("Finally")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                // Subtitle
                Text("A little more about you")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                
                // Name TextField
                TextField("", text: $quizState.userName, prompt: Text("Your name").foregroundColor(.white.opacity(0.5)))
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white.opacity(0.15), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                
                // Age TextField
                TextField("", text: $quizState.userAge, prompt: Text("Your age").foregroundColor(.white.opacity(0.5)))
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .keyboardType(.numberPad)
                    .onChange(of: quizState.userAge) { newValue in
                        // Filter out non-numeric characters
                        let filtered = newValue.filter { $0.isNumber }
                        if filtered != newValue {
                            quizState.userAge = filtered
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white.opacity(0.15), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                
                // Complete Quiz Button
                Button {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    // Save to UserDefaults
                    UserDefaults.standard.set(quizState.userName, forKey: "name")
                    if let age = Int(quizState.userAge) {
                        UserDefaults.standard.set(age, forKey: "age")
                    }
                    AnalyticsManager.shared.updateUserAttributes(attributes: ["name": quizState.userName, "age": quizState.userAge])
                    onComplete()
                } label: {
                    Text("Complete Quiz")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white)
                        )
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .disabled(quizState.userName.isEmpty || quizState.userAge.isEmpty)
                .opacity(quizState.userName.isEmpty || quizState.userAge.isEmpty ? 0.5 : 1.0)
                
                Spacer()
            }
        }
    }
}

// Note: PrimaryButtonStyle, SecondaryButtonStyle, and ProgressBar are defined in OnboardingView.swift

