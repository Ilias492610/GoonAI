//
//  AnalyticsCardComponents.swift
//  GoonAi
//
//  Reusable card components for Analytics
//

import SwiftUI

// MARK: - Quit Date Card

struct QuitDateCard: View {
    let date: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Quit By")
                .font(.headline)
                .foregroundColor(.white.opacity(0.7))
            
            Text(date)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .glassEffect()
        .padding(.horizontal)
    }
}

// MARK: - Level Progress Card

struct LevelProgressCard: View {
    let level: RecoveryLevel
    
    var body: some View {
        HStack(spacing: 16) {
            // Level badge
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.white.opacity(0.3), Color.white.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 60)
                
                Image(systemName: "star.fill")
                    .font(.title2)
                    .foregroundColor(.yellow)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Level \(level.level)")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("\(Int(level.progress * 100))%")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                }
                
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.white.opacity(0.2))
                            .frame(height: 6)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.purple)
                            .frame(width: geometry.size.width * level.progress, height: 6)
                    }
                }
                .frame(height: 6)
                
                Text(level.description)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(2)
            }
        }
        .padding()
        .glassEffect()
        .padding(.horizontal)
    }
}

// MARK: - Streak Stats Row

struct StreakStatsRowAnalytics: View {
    let currentStreak: Int
    let highestStreak: Int
    let completedActivities: Int
    let totalActivities: Int
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                StatCardMini(label: "Current streak", value: "\(currentStreak)d")
                StatCardMini(label: "Highest streak", value: "\(highestStreak)d")
            }
            
            StatCardMini(label: "Daily activities completed", value: "\(completedActivities)/\(totalActivities)")
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
    
    var body: some View {
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
        }
        .padding()
    }
}

// MARK: - Overall Progress Chart

struct OverallProgressChart: View {
    let progressHistory: [ProgressPoint]
    let firstLoginDate: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Overall Progress")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("First Log In – \(firstLoginDate)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            // Simple line chart
            GeometryReader { geometry in
                Path { path in
                    guard !progressHistory.isEmpty else { return }
                    
                    let maxValue = progressHistory.map { $0.value }.max() ?? 1.0
                    let xStep = geometry.size.width / CGFloat(progressHistory.count - 1)
                    
                    for (index, point) in progressHistory.enumerated() {
                        let x = CGFloat(index) * xStep
                        let y = geometry.size.height - (CGFloat(point.value / maxValue) * geometry.size.height * 0.8)
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .stroke(
                    LinearGradient(
                        colors: [Color.cyan, Color.green],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
                )
                
                // Fill gradient
                Path { path in
                    guard !progressHistory.isEmpty else { return }
                    
                    let maxValue = progressHistory.map { $0.value }.max() ?? 1.0
                    let xStep = geometry.size.width / CGFloat(progressHistory.count - 1)
                    
                    path.move(to: CGPoint(x: 0, y: geometry.size.height))
                    
                    for (index, point) in progressHistory.enumerated() {
                        let x = CGFloat(index) * xStep
                        let y = geometry.size.height - (CGFloat(point.value / maxValue) * geometry.size.height * 0.8)
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                    
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(
                    LinearGradient(
                        colors: [Color.cyan.opacity(0.3), Color.green.opacity(0.1)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .frame(height: 150)
        }
        .padding()
        .glassEffect()
        .padding(.horizontal)
    }
}

// MARK: - Dimension Stats Grid

struct DimensionStatsGrid: View {
    let dimensions: [DimensionStat]
    let selectedDimension: DimensionType?
    let onSelect: (DimensionType) -> Void
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(dimensions) { dimension in
                DimensionStatCard(
                    dimension: dimension,
                    isSelected: selectedDimension == dimension.type,
                    onTap: { onSelect(dimension.type) }
                )
            }
        }
        .padding(.horizontal)
    }
}

struct DimensionStatCard: View {
    let dimension: DimensionStat
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(dimension.type.color.opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: dimension.type.icon)
                        .font(.title3)
                        .foregroundColor(dimension.type.color)
                }
                
                VStack(spacing: 4) {
                    Text("\(dimension.percentage)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(dimension.type.rawValue)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(isSelected ? Color.cyan : Color.white.opacity(0.2), lineWidth: isSelected ? 2 : 1)
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

