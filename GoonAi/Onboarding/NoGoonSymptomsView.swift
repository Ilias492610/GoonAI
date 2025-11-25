//
//  NoGoonSymptomsView.swift
//  GoonAi
//
//  Symptoms checklist screen
//

import SwiftUI

struct NoGoonSymptomsView: View {
    @ObservedObject var quizState: OnboardingQuizState
    let onComplete: () -> Void
    let onBack: () -> Void
    
    private var symptomsByCategory: [SymptomCategory: [Symptom]] {
        Dictionary(grouping: SymptomData.symptoms, by: \.category)
    }
    
    var body: some View {
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

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Title (matching OnboardingView pattern)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Symptoms Checklist")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)

                        Text("Excessive porn use can have negative impacts psychologically. Select any symptoms you've experienced:")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                    // Symptoms by Category
                    ForEach(SymptomCategory.allCases, id: \.self) { category in
                        if let symptoms = symptomsByCategory[category], !symptoms.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(category.rawValue)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)

                                ForEach(symptoms) { symptom in
                                    SymptomCheckboxRow(
                                        symptom: symptom,
                                        isSelected: quizState.selectedSymptoms.contains(symptom.id)
                                    ) {
                                        if quizState.selectedSymptoms.contains(symptom.id) {
                                            quizState.selectedSymptoms.remove(symptom.id)
                                        } else {
                                            quizState.selectedSymptoms.insert(symptom.id)
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Continue Button (matching OnboardingView pattern)
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        AnalyticsManager.shared.trackEvent(eventName: "symptoms_selected", properties: ["count": quizState.selectedSymptoms.count])
                        onComplete()
                    }) {
                        Text("Continue")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 50)
                }
            }
        }
        .background(Color.white)
    }
}

// MARK: - Symptom Checkbox Row

struct SymptomCheckboxRow: View {
    let symptom: Symptom
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 35, style: .continuous)
                    .fill(getCategoryColor(for: symptom.category).opacity(isSelected ? 0.5 : (UITraitCollection.current.userInterfaceStyle == .dark ? 0.3 : 0.1)))
                    .frame(height: 65)
                    .shadow(color: Color.black.opacity(0.3), radius: 1)
                
                HStack {
                    Image(systemName: symptom.icon)
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(getCategoryColor(for: symptom.category))
                        .cornerRadius(15)
                        .padding(.trailing, 5)
                    
                    Text(symptom.text)
                        .foregroundColor(.primary)
                        .font(.headline)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.black.opacity(0.7), .white)
                    } else {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                            .foregroundColor(Color(.systemGray6))
                    }
                }
                .padding()
            }
        }
        .padding(.horizontal, 10)
    }
    
    private func getCategoryColor(for category: SymptomCategory) -> Color {
        switch category {
        case .physical: return .red
        case .social: return .blue
        case .mental: return .purple
        case .faith: return .green
        }
    }
}
