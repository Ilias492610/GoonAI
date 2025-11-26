//
//  AnalyticsCardComponents.swift
//  GoonAi
//
//  Reusable card components for Analytics
//

import SwiftUI

// MARK: - Streak Stats Row

struct StreakStatsRowAnalytics: View {
    let currentStreak: Int
    let highestStreak: Int
    
    var body: some View {
        HStack(spacing: 12) {
            StatCardMini(label: "Current streak", value: "\(currentStreak)d")
            StatCardMini(label: "Highest streak", value: "\(highestStreak)d")
        }
        .padding(.horizontal)
    }
}

struct StatCardMini: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .glassEffect()
    }
}

// MARK: - Benefits List

struct BenefitsListView: View {
    let benefits: [Benefit]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(benefits) { benefit in
                BenefitRow(benefit: benefit)
                
                if benefit.id != benefits.last?.id {
                    Divider()
                        .background(Color.white.opacity(0.1))
                        .padding(.horizontal)
                }
            }
        }
        .glassEffect()
        .padding(.horizontal)
    }
}

struct BenefitRow: View {
    let benefit: Benefit
    @State private var animateProgress = false
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {
                Text(benefit.emoji)
                    .font(.system(size: 32))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(benefit.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(benefit.description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
            }
            
            // Progress bar
            HStack(spacing: 8) {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.white.opacity(0.2))
                            .frame(height: 6)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(
                                LinearGradient(
                                    colors: [Color.cyan, Color.green],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * (animateProgress ? benefit.progress : 0), height: 6)
                    }
                }
                .frame(height: 6)
                
                Text("\(Int(benefit.progress * 100))%")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 40, alignment: .trailing)
            }
        }
        .padding()
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                animateProgress = true
            }
        }
    }
}



