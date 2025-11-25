//
//  AchievementsView.swift
//  GoonAi
//
//  Achievements timeline screen
//

import SwiftUI

struct AchievementsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                    
                    Spacer()
                    
                    Text("Achievements")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        // Reload achievements
                        viewModel.unlockAchievement(for: viewModel.currentStreak)
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Progress indicator
                HStack(spacing: 8) {
                    ForEach(0..<9) { index in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(index == 0 ? Color.cyan : Color.white.opacity(0.3))
                            .frame(height: 4)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                // Title
                Text("Achievements")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        ForEach(Array(viewModel.achievements.enumerated()), id: \.element.id) { index, achievement in
                            AchievementTimelineCard(
                                achievement: achievement,
                                number: index + 1,
                                isLast: index == viewModel.achievements.count - 1
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                    .padding(.bottom, 100)
                }
            }
        }
    }
}

// MARK: - Achievement Timeline Card

struct AchievementTimelineCard: View {
    let achievement: Achievement
    let number: Int
    let isLast: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            // Left side: Timeline
            VStack(spacing: 0) {
                // Badge
                ZStack {
                    Circle()
                        .fill(
                            achievement.isUnlocked
                            ? LinearGradient(
                                colors: [.cyan, .blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            : LinearGradient(
                                colors: [.gray.opacity(0.3), .gray.opacity(0.2)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 80, height: 80)
                        .shadow(
                            color: achievement.isUnlocked ? .cyan.opacity(0.5) : .clear,
                            radius: 15,
                            x: 0,
                            y: 8
                        )
                    
                    if achievement.isUnlocked {
                        Image(systemName: achievement.iconName)
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white.opacity(0.5))
                    }
                }
                
                // Connecting line
                if !isLast {
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 2, height: 60)
                        .padding(.top, 8)
                }
            }
            
            // Right side: Content
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(achievement.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .fill(achievement.isUnlocked ? Color.cyan.opacity(0.3) : Color.white.opacity(0.2))
                            .frame(width: 40, height: 40)
                        
                        Text("\(number)")
                            .font(.headline)
                            .foregroundColor(achievement.isUnlocked ? .cyan : .white.opacity(0.6))
                    }
                }
                
                Text("\(achievement.daysRequired) Days Clean")
                    .font(.subheadline)
                    .foregroundColor(achievement.isUnlocked ? .cyan : .white.opacity(0.6))
                
                Text(achievement.description)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.top, 8)
        }
    }
}

