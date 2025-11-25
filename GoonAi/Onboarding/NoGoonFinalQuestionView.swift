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
            
            VStack(spacing: 0) {
                // Logo header (matching OnboardingView pattern)
                ZStack {
                    HStack {
                        Button {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            onBack()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.primary)
                                .padding(.leading)
                        }
                        
                        Spacer()
                    }
                    
                    Text("NOGOON")
                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                        .tracking(2)
                        .foregroundColor(.primary)
                }
                .padding(.vertical, 10)
                
                // Progress Bar (full - matching OnboardingView pattern)
                ProgressBar(progress: 1.0)
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                
                // Card (matching OnboardingView pattern)
                VStack(spacing: 16) {
                    Text("What's your name?")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("So we can personalize your plan.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Name TextField (matching OnboardingView pattern)
                    TextField("Enter your name", text: $quizState.userName)
                        .textFieldStyle(.roundedBorder)
                        .padding(.vertical, 6)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.06), radius: 20, x: 0, y: 10)
                )
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Age Card
                VStack(spacing: 16) {
                    Text("How old are you?")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Age helps us estimate daily targets more accurately.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Age TextField (matching OnboardingView pattern)
                    TextField("Enter your age", text: $quizState.userAge)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .padding(.vertical, 6)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.06), radius: 20, x: 0, y: 10)
                )
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                Spacer()
                
                // Navigation (matching OnboardingView pattern)
                HStack(spacing: 12) {
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        onBack()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(SecondaryButtonStyle())

                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        // Save to UserDefaults (matching OnboardingView pattern)
                        UserDefaults.standard.set(quizState.userName, forKey: "name")
                        if let age = Int(quizState.userAge) {
                            UserDefaults.standard.set(age, forKey: "age")
                        }
                        AnalyticsManager.shared.updateUserAttributes(attributes: ["name": quizState.userName, "age": quizState.userAge])
                        onComplete()
                    } label: {
                        HStack {
                            Text("Finish")
                            Image(systemName: "chevron.right")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(quizState.userName.isEmpty || quizState.userAge.isEmpty)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
        }
    }
}

// Note: PrimaryButtonStyle, SecondaryButtonStyle, and ProgressBar are defined in OnboardingView.swift

