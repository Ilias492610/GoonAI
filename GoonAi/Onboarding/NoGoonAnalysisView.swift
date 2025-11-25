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
    
    private var userPercentage: Int {
        quizState.dependencyPercentage
    }
    
    private var averagePercentage: Int {
        quizState.averagePercentage
    }
    
    private var comparisonPercentage: Int {
        userPercentage - averagePercentage
    }
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    // Top Section
                    VStack(spacing: 16) {
                        HStack {
                            Button(action: onBack) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 60)
                        
                        HStack {
                            Text("Analysis Complete")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.green)
                        }
                        .padding(.top, 20)
                    }
                    
                    // Message
                    VStack(spacing: 12) {
                        Text("We've got some news to break to you...")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                        
                        Text("Your responses indicate a clear dependance on internet porn*")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    .padding(.top, 20)
                    
                    // Bar Chart
                    HStack(alignment: .bottom, spacing: 60) {
                        // User's Score
                        VStack(spacing: 12) {
                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(Color.white.opacity(0.1))
                                    .frame(width: 100, height: 400)
                                
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            colors: [.red, .orange],
                                            startPoint: .bottom,
                                            endPoint: .top
                                        )
                                    )
                                    .frame(width: 100, height: CGFloat(userPercentage) / 100.0 * 400)
                                
                                Text("\(userPercentage)%")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.bottom, CGFloat(userPercentage) / 100.0 * 400 / 2)
                            }
                            
                            Text("Your Score")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                        
                        // Average Score
                        VStack(spacing: 12) {
                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(Color.white.opacity(0.1))
                                    .frame(width: 100, height: 400)
                                
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            colors: [.green, .cyan],
                                            startPoint: .bottom,
                                            endPoint: .top
                                        )
                                    )
                                    .frame(width: 100, height: CGFloat(averagePercentage) / 100.0 * 400)
                                
                                Text("\(averagePercentage)%")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.bottom, CGFloat(averagePercentage) / 100.0 * 400 / 2)
                            }
                            
                            Text("Average")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.vertical, 30)
                    
                    // Comparison Text
                    HStack(spacing: 8) {
                        Text("\(abs(comparisonPercentage))%")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        
                        Text(comparisonPercentage > 0 ? "higher dependence on porn" : "lower dependence on porn")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                        
                        Image(systemName: "arrow.up.right")
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                    .padding(.horizontal, 30)
                    
                    // Disclaimer
                    Text("* This result is an indication only, not a medical diagnosis.")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.horizontal, 40)
                        .padding(.top, 20)
                    
                    // Check Symptoms Button
                    Button(action: onContinue) {
                        Text("Check your symptoms")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                RoundedRectangle(cornerRadius: 30, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            colors: [.blue, .cyan],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .shadow(color: .cyan.opacity(0.4), radius: 15, x: 0, y: 10)
                            )
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    .padding(.bottom, 50)
                }
            }
        }
    }
}

