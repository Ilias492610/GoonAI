//
//  NoGoonQuizView.swift
//  GoonAi
//
//  NoGoon quiz flow with questions
//

import SwiftUI

struct NoGoonQuizView: View {
    @ObservedObject var quizState: OnboardingQuizState
    let onComplete: () -> Void
    let onBack: () -> Void
    
    private var currentQuestion: QuizQuestion {
        QuizData.questions[quizState.currentQuestionIndex]
    }
    
    private var progress: Double {
        Double(quizState.currentQuestionIndex) / Double(max(QuizData.questions.count - 1, 1))
    }
    
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
                            if quizState.currentQuestionIndex > 0 {
                                withAnimation(.easeInOut) {
                                    quizState.currentQuestionIndex -= 1
                                }
                            } else {
                                onBack()
                            }
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
                        .foregroundColor(.white)
                }
                .padding(.vertical, 10)
                
                // Progress Bar (matching OnboardingView pattern)
                ProgressBar(progress: progress)
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                
                // Card (matching OnboardingView pattern)
                VStack(spacing: 16) {
                    Text("Question #\(currentQuestion.id)")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                    
                    Text(currentQuestion.title)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Options (matching OnboardingView single choice pattern)
                    VStack(spacing: 10) {
                        ForEach(Array(currentQuestion.options.enumerated()), id: \.element.id) { index, option in
                            let isSelected = quizState.answers[quizState.currentQuestionIndex]?.id == option.id
                            Button {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                withAnimation {
                                    quizState.answers[quizState.currentQuestionIndex] = option
                                }
                                
                                // Auto-advance after selection
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    advance()
                                }
                            } label: {
                                HStack {
                                    if let icon = getIconForOption(option, question: currentQuestion) {
                                        Image(systemName: icon)
                                            .imageScale(.medium)
                                            .frame(width: 24)
                                    }
                                    
                                    Text(option.text)
                                        .fontWeight(.medium)
                                    Spacer()
                                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                        .imageScale(.large)
                                        .symbolRenderingMode(.hierarchical)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(isSelected ? Color.white.opacity(0.3) : Color.white.opacity(0.1))
                                )
                                .foregroundColor(.white)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 8)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.15))
                )
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
                
                // Navigation (matching OnboardingView pattern)
                HStack(spacing: 12) {
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        withAnimation(.easeInOut) {
                            if quizState.currentQuestionIndex > 0 {
                                quizState.currentQuestionIndex -= 1
                            } else {
                                onBack()
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    .disabled(quizState.currentQuestionIndex == 0)

                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        advance()
                    } label: {
                        HStack {
                            Text(quizState.currentQuestionIndex == QuizData.questions.count - 1 ? "Finish" : "Continue")
                            Image(systemName: "chevron.right")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(quizState.answers[quizState.currentQuestionIndex] == nil)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
        }
        .animation(.easeInOut, value: quizState.currentQuestionIndex)
    }
    
    private func advance() {
        if quizState.currentQuestionIndex < QuizData.questions.count - 1 {
            withAnimation(.easeInOut) {
                quizState.currentQuestionIndex += 1
            }
        } else {
            onComplete()
        }
    }
    
    private func getIconForOption(_ option: QuizOption, question: QuizQuestion) -> String? {
        // Return SF Symbol for specific questions (e.g., social media icons for question 3)
        if question.id == 3 {
            switch option.text {
            case "TikTok": return "play.circle.fill"
            case "Instagram": return "camera.fill"
            case "TV": return "tv.fill"
            case "X": return "xmark"
            case "Google": return "magnifyingglass.circle.fill"
            case "Facebook": return "person.2.circle.fill"
            default: return nil
            }
        }
        return nil
    }
}

// Note: PrimaryButtonStyle, SecondaryButtonStyle, and ProgressBar are defined in OnboardingView.swift

