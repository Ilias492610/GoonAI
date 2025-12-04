//
//  NoGoonAnalysisView.swift
//  GoonAi
//
//  Analysis results screen with bar chart
//

import SwiftUI

struct NoGoonAnalysisView: View {
    @ObservedObject var quizState: OnboardingQuizState
    let onContinue: () -> Void
    let onBack: () -> Void
    
    // Fixed values matching the mock design
    private let userPercentage: Int = 64
    private let averagePercentage: Int = 40
    
    private var comparisonPercentage: Int {
        userPercentage - averagePercentage
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
                // Back button
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
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // Analysis Complete Header
                HStack(spacing: 8) {
                    Text("Analysis Complete")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.green)
                }
                .padding(.top, 30)
                
                // Message
                VStack(spacing: 12) {
                    Text("We've got some news to break to you...")
                        .font(.system(size: 17))
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("Your responses indicate a clear\ndependance on internet porn*")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 16)
                
                Spacer()
                
                // Bar Chart
                HStack(alignment: .bottom, spacing: 30) {
                    // User's Score - 64% (taller bar)
                    VStack(spacing: 8) {
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color.red)
                                .frame(width: 80, height: 280) // Fixed height for 64%
                            
                            Text("64%")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.top, 12)
                        }
                        
                        Text("Your Score")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    // Average Score - 40% (shorter bar)
                    VStack(spacing: 8) {
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color.green)
                                .frame(width: 80, height: 175) // Fixed height for 40%
                            
                            Text("40%")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.top, 12)
                        }
                        
                        Text("Average")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                // Comparison Text
                HStack(spacing: 4) {
                    Text("64%")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.red)
                    
                    Text("higher dependence on porn")
                        .font(.system(size: 17))
                        .foregroundColor(.white.opacity(0.9))
                    
                    Image(systemName: "chart.line.downtrend.xyaxis")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.6))
                }
                .padding(.top, 20)
                
                // Disclaimer
                Text("* This result is an indication only, not a medical diagnosis.")
                    .font(.system(size: 13))
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.top, 16)
                
                // Check Symptoms Button
                Button {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    onContinue()
                } label: {
                    Text("Check your symptoms")
                        .font(.system(size: 17, weight: .semibold))
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
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 40)
            }
        }
    }
}

