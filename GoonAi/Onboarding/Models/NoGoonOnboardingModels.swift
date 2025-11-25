//
//  NoGoonOnboardingModels.swift
//  GoonAi
//
//  Data models for NoGoon onboarding quiz and assessment
//

import Foundation
import Combine

// MARK: - Quiz Question

struct QuizQuestion: Identifiable {
    let id: Int
    let title: String
    let options: [QuizOption]
    let category: QuestionCategory
}

struct QuizOption: Identifiable {
    let id: Int
    let text: String
    let score: Int // Score contribution for dependency calculation
}

enum QuestionCategory {
    case frequency
    case behavior
    case demographics
    case symptoms
}

// MARK: - Quiz Data

struct QuizData {
    static let questions: [QuizQuestion] = [
        QuizQuestion(
            id: 1,
            title: "What is your gender?",
            options: [
                QuizOption(id: 1, text: "Female", score: 0),
                QuizOption(id: 2, text: "Male", score: 0)
            ],
            category: .demographics
        ),
        QuizQuestion(
            id: 2,
            title: "How often do you typically view pornography?",
            options: [
                QuizOption(id: 1, text: "Less than once a week", score: 1),
                QuizOption(id: 2, text: "A few times a week", score: 2),
                QuizOption(id: 3, text: "More than once a day", score: 4),
                QuizOption(id: 4, text: "Once a day", score: 3)
            ],
            category: .frequency
        ),
        QuizQuestion(
            id: 3,
            title: "Where did you hear about us?",
            options: [
                QuizOption(id: 1, text: "TikTok", score: 0),
                QuizOption(id: 2, text: "Instagram", score: 0),
                QuizOption(id: 3, text: "TV", score: 0),
                QuizOption(id: 4, text: "X", score: 0),
                QuizOption(id: 5, text: "Google", score: 0),
                QuizOption(id: 6, text: "Facebook", score: 0)
            ],
            category: .demographics
        ),
        QuizQuestion(
            id: 4,
            title: "Have you noticed a shift towards more extreme or graphic material?",
            options: [
                QuizOption(id: 1, text: "No", score: 0),
                QuizOption(id: 2, text: "Yes", score: 3)
            ],
            category: .behavior
        ),
        QuizQuestion(
            id: 5,
            title: "At what age did you first come across explicit content?",
            options: [
                QuizOption(id: 1, text: "12 or younger", score: 3),
                QuizOption(id: 2, text: "25 or older", score: 0),
                QuizOption(id: 3, text: "13 to 16", score: 2),
                QuizOption(id: 4, text: "17 to 24", score: 1)
            ],
            category: .demographics
        ),
        QuizQuestion(
            id: 6,
            title: "Do you find it difficult to achieve sexual arousal without pornography or fantasy?",
            options: [
                QuizOption(id: 1, text: "Occasionally", score: 2),
                QuizOption(id: 2, text: "Rarely or never", score: 0),
                QuizOption(id: 3, text: "Frequently", score: 3)
            ],
            category: .symptoms
        ),
        QuizQuestion(
            id: 7,
            title: "Do you use pornography as a way to cope with emotional discomfort or pain?",
            options: [
                QuizOption(id: 1, text: "Frequently", score: 3),
                QuizOption(id: 2, text: "Occasionally", score: 2),
                QuizOption(id: 3, text: "Rarely or never", score: 0)
            ],
            category: .behavior
        ),
        QuizQuestion(
            id: 8,
            title: "Do you turn to pornography when feeling stressed?",
            options: [
                QuizOption(id: 1, text: "Occasionally", score: 2),
                QuizOption(id: 2, text: "Frequently", score: 3),
                QuizOption(id: 3, text: "Rarely or never", score: 0)
            ],
            category: .behavior
        ),
        QuizQuestion(
            id: 9,
            title: "Do you watch pornography out of boredom?",
            options: [
                QuizOption(id: 1, text: "Rarely or never", score: 0),
                QuizOption(id: 2, text: "Occasionally", score: 2),
                QuizOption(id: 3, text: "Frequently", score: 3)
            ],
            category: .behavior
        ),
        QuizQuestion(
            id: 10,
            title: "Have you ever spent money on accessing explicit content?",
            options: [
                QuizOption(id: 1, text: "Yes", score: 2),
                QuizOption(id: 2, text: "No", score: 0)
            ],
            category: .behavior
        )
    ]
    
    // Finally screen for name and age
    static let finalQuestion = QuizQuestion(
        id: 11,
        title: "Finally",
        options: [],
        category: .demographics
    )
}

// MARK: - Symptoms

struct Symptom: Identifiable, Hashable {
    let id: String
    let text: String
    let category: SymptomCategory
    let icon: String // SF Symbol name
}

enum SymptomCategory: String, CaseIterable {
    case physical = "Physical"
    case social = "Social"
    case mental = "Mental"
    case faith = "Faith"
}

struct SymptomData {
    static let symptoms: [Symptom] = [
        // Physical
        Symptom(id: "physical_1", text: "Tiredness and lethargy", category: .physical, icon: "bed.double.fill"),
        Symptom(id: "physical_2", text: "Low sex drive or desire", category: .physical, icon: "heart.slash.fill"),
        Symptom(id: "physical_3", text: "Weak erections without porn", category: .physical, icon: "bolt.slash.fill"),
        
        // Social
        Symptom(id: "social_1", text: "Low self-confidence", category: .social, icon: "person.fill.questionmark"),
        Symptom(id: "social_2", text: "Unsuccessful or unenjoyable sex", category: .social, icon: "hand.thumbsdown.fill"),
        Symptom(id: "social_3", text: "Feeling unattractive or unworthy of love", category: .social, icon: "heart.slash"),
        Symptom(id: "social_4", text: "Reduced desire to socialize", category: .social, icon: "person.2.slash"),
        Symptom(id: "social_5", text: "Feeling isolated from others", category: .social, icon: "figure.stand.line.dotted.figure.stand"),
        
        // Mental
        Symptom(id: "mental_1", text: "Feeling unmotivated", category: .mental, icon: "chart.line.downtrend.xyaxis"),
        Symptom(id: "mental_2", text: "General anxiety", category: .mental, icon: "exclamationmark.triangle.fill"),
        Symptom(id: "mental_3", text: "Lack of ambition to pursue goals", category: .mental, icon: "flag.slash.fill"),
        Symptom(id: "mental_4", text: "Poor memory or 'brain fog'", category: .mental, icon: "brain.head.profile"),
        Symptom(id: "mental_5", text: "Difficulty concentrating", category: .mental, icon: "eye.trianglebadge.exclamationmark"),
        
        // Faith
        Symptom(id: "faith_1", text: "Feeling distant from God", category: .faith, icon: "sparkles")
    ]
}

// MARK: - Quiz State

class OnboardingQuizState: ObservableObject {
    @Published var currentQuestionIndex = 0
    @Published var answers: [Int: QuizOption] = [:]
    @Published var selectedSymptoms: Set<String> = []
    @Published var userName: String = ""
    @Published var userAge: String = ""
    
    var totalScore: Int {
        answers.values.reduce(0) { $0 + $1.score }
    }
    
    var maxPossibleScore: Int {
        // Calculate max score from questions 2-10 (excluding demographics)
        let scorableQuestions = QuizData.questions.filter { q in
            q.category == .frequency || q.category == .behavior || q.category == .symptoms
        }
        return scorableQuestions.reduce(0) { max, question in
            max + (question.options.map(\.score).max() ?? 0)
        }
    }
    
    var dependencyPercentage: Int {
        guard maxPossibleScore > 0 else { return 0 }
        return Int((Double(totalScore) / Double(maxPossibleScore)) * 100)
    }
    
    // Average is 40% for display purposes
    let averagePercentage = 40
    
    func reset() {
        currentQuestionIndex = 0
        answers = [:]
        selectedSymptoms = []
        userName = ""
        userAge = ""
    }
}

