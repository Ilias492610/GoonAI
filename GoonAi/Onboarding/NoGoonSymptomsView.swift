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
                // Header with back button and title
                ZStack {
                    HStack {
                        Button {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            onBack()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(
                                    Circle()
                                        .fill(Color.white.opacity(0.15))
                                )
                        }
                        Spacer()
                    }
                    
                    Text("Symptoms")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // Red-orange info banner
                Text("Excessive porn use can have negative impacts psychologically.")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 1.0, green: 0.4, blue: 0.2))
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                
                // Select symptoms text
                Text("Select any symptoms below:")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                
                // Scrollable symptoms list with button at end
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(SymptomCategory.allCases, id: \.self) { category in
                            if let symptoms = symptomsByCategory[category], !symptoms.isEmpty {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(category.rawValue)
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(.white.opacity(0.7))
                                        .padding(.horizontal, 24)
                                        .padding(.top, 8)
                                    
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
                        
                        // Reboot my brain button (red-orange) at end of scroll
                        Button {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            AnalyticsManager.shared.trackEvent(eventName: "symptoms_selected", properties: ["count": quizState.selectedSymptoms.count])
                            onComplete()
                        } label: {
                            Text("Reboot my brain")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 18)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color(red: 1.0, green: 0.4, blue: 0.2))
                                )
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                    .padding(.top, 8)
                }
            }
        }
    }
}

// MARK: - Symptom Checkbox Row

struct SymptomCheckboxRow: View {
    let symptom: Symptom
    let isSelected: Bool
    let action: () -> Void
    
    // Red-orange color
    private let redOrange = Color(red: 1.0, green: 0.4, blue: 0.2)
    
    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            action()
        } label: {
            HStack(spacing: 12) {
                // Checkbox circle
                ZStack {
                    Circle()
                        .stroke(isSelected ? redOrange : Color.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 28, height: 28)
                    
                    if isSelected {
                        Circle()
                            .fill(redOrange)
                            .frame(width: 28, height: 28)
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                // Symptom text with bold keywords
                Text(symptom.text)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? redOrange.opacity(0.25) : Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(isSelected ? redOrange.opacity(0.4) : Color.white.opacity(0.1), lineWidth: 1)
                    )
            )
        }
        .padding(.horizontal, 20)
    }
}
