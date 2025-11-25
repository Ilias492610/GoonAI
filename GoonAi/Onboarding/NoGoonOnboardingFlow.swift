//
//  NoGoonOnboardingFlow.swift
//  GoonAi
//
//  Main coordinator for NoGoon onboarding flow
//

import SwiftUI
#if canImport(SuperwallKit)
import SuperwallKit
#endif

struct NoGoonOnboardingFlow: View {
    @StateObject private var quizState = OnboardingQuizState()
    @State private var currentScreen: OnboardingScreen = .welcome
    let onComplete: () -> Void
    
    var body: some View {
        ZStack {
            switch currentScreen {
            case .welcome:
                NoGoonWelcomeView(
                    onStartQuiz: {
                        withAnimation {
                            currentScreen = .reflection
                        }
                    },
                    onAlreadyJoined: {
                        // TODO: Show login screen
                        print("Already joined tapped")
                    }
                )
                .transition(.opacity)
                
            case .reflection:
                NoGoonReflectionView {
                    withAnimation {
                        currentScreen = .profileCard
                    }
                }
                .transition(.opacity)
                
            case .profileCard:
                NoGoonProfileCardView(
                    quizState: quizState,
                    onComplete: {
                        withAnimation {
                            currentScreen = .quiz
                        }
                    },
                    onBack: {
                        withAnimation {
                            currentScreen = .welcome
                        }
                    }
                )
                .transition(.opacity)
                
            case .quiz:
                NoGoonQuizView(
                    quizState: quizState,
                    onComplete: {
                        withAnimation {
                            currentScreen = .finalQuestion
                        }
                    },
                    onBack: {
                        withAnimation {
                            currentScreen = .profileCard
                        }
                    }
                )
                .transition(.opacity)
                
            case .finalQuestion:
                NoGoonFinalQuestionView(
                    quizState: quizState,
                    onComplete: {
                        withAnimation {
                            currentScreen = .calculating
                        }
                    },
                    onBack: {
                        withAnimation {
                            quizState.currentQuestionIndex = QuizData.questions.count - 1
                            currentScreen = .quiz
                        }
                    }
                )
                .transition(.opacity)
                
            case .calculating:
                NoGoonCalculatingView {
                    withAnimation {
                        currentScreen = .analysis
                    }
                }
                .transition(.opacity)
                
            case .analysis:
                NoGoonAnalysisView(
                    quizState: quizState,
                    onContinue: {
                        withAnimation {
                            currentScreen = .symptoms
                        }
                    },
                    onBack: {
                        withAnimation {
                            currentScreen = .finalQuestion
                        }
                    }
                )
                .transition(.opacity)
                
            case .symptoms:
                NoGoonSymptomsView(
                    quizState: quizState,
                    onComplete: {
                        withAnimation {
                            currentScreen = .education
                        }
                    },
                    onBack: {
                        withAnimation {
                            currentScreen = .analysis
                        }
                    }
                )
                .transition(.opacity)
                
            case .education:
                NoGoonEducationView {
                    withAnimation {
                        currentScreen = .infoPages
                    }
                }
                .transition(.opacity)
                
            case .infoPages:
                NoGoonInfoPagesView {
                    withAnimation {
                        currentScreen = .testimonials
                    }
                }
                .transition(.opacity)
                
            case .testimonials:
                NoGoonTestimonialsView {
                    withAnimation {
                        currentScreen = .goals
                    }
                }
                .transition(.opacity)
                
            case .goals:
                GoalSelectView {
                    withAnimation {
                        currentScreen = .rating
                    }
                }
                .transition(.opacity)
                
            case .rating:
                ReviewScreenView {
                    withAnimation {
                        currentScreen = .sevenDayPlan
                    }
                }
                .transition(.opacity)
                
            case .sevenDayPlan:
                NoGoon7DayPlanView {
                    // Directly go to paywall after \"Start my journey\" screen
                    withAnimation {
                        currentScreen = .paywall
                    }
                }
                .transition(.opacity)
                
            case .paywall:
                PaywallView {
                    // Mark onboarding as complete
                    PersistanceManager.shared.saveFile(.onboarded, value: true)
                    UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                    
                    // Complete onboarding
                    onComplete()
                }
                .transition(.opacity)
                
            case .referral:
                EmptyView()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: currentScreen)
    }
    
    private func showPaywallForAge() {
        guard let ageString = UserDefaults.standard.string(forKey: "age"),
              let userAge = Int(ageString) else {
            // Fallback if age not found
            showDefaultPaywall()
            return
        }
        
        #if canImport(SuperwallKit)
        let placement: String
        if userAge < 18 {
            placement = "under18"
        } else if userAge <= 22 {
            placement = "age18to22"
        } else if userAge <= 28 {
            placement = "age23to28"
        } else if userAge <= 40 {
            placement = "age29to40"
        } else {
            placement = "age40plus"
        }
        
        Superwall.shared.register(placement: placement)
        #else
        showDefaultPaywall()
        #endif
    }
    
    private func showDefaultPaywall() {
        #if canImport(SuperwallKit)
        Superwall.shared.register(placement: "default_onboarding")
        #endif
    }
}

// MARK: - Onboarding Screen Enum

enum OnboardingScreen {
    case welcome
    case reflection
    case profileCard
    case quiz
    case finalQuestion
    case calculating
    case analysis
    case symptoms
    case education
    case infoPages
    case testimonials
    case goals
    case rating
    case sevenDayPlan
    case paywall
    case referral
}

