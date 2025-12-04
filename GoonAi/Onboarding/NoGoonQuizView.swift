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
        Double(quizState.currentQuestionIndex + 1) / Double(QuizData.questions.count)
    }
    
    var body: some View {
        ZStack {
            // Dark blue gradient background
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
                        if quizState.currentQuestionIndex > 0 {
                            withAnimation(.easeInOut) {
                                quizState.currentQuestionIndex -= 1
                            }
                        } else {
                            onBack()
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    // Progress bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            // Background
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.white.opacity(0.2))
                                .frame(height: 6)
                            
                            // Progress
                            RoundedRectangle(cornerRadius: 4)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.cyan, Color.blue],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: geometry.size.width * progress, height: 6)
                        }
                    }
                    .frame(height: 6)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Question title with underline
                VStack(spacing: 8) {
                    Text("Question #\(currentQuestion.id)")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                .padding(.top, 40)
                
                // Question text
                Text(currentQuestion.title)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                
                // Options
                VStack(spacing: 16) {
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
                            HStack(spacing: 16) {
                                // Numbered circle
                                ZStack {
                                    Circle()
                                        .fill(Color.cyan)
                                        .frame(width: 36, height: 36)
                                    
                                    Text("\(index + 1)")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                
                                Text(option.text)
                                    .font(.system(size: 17, weight: .medium))
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(isSelected ? Color.white.opacity(0.25) : Color.white.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(isSelected ? Color.cyan.opacity(0.5) : Color.white.opacity(0.15), lineWidth: 1)
                                    )
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                
                Spacer()
                
                // Skip button at bottom
                Button {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    advance()
                } label: {
                    Text("Skip")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.bottom, 40)
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

