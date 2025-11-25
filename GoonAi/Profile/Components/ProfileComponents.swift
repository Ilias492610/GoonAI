//
//  ProfileComponents.swift
//  GoonAi
//
//  Reusable components for Profile screens
//

import SwiftUI

// MARK: - Settings Row

struct SettingsRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(iconColor.opacity(0.2))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundColor(iconColor)
                }
                
                Text(title)
                    .font(.body)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.vertical, 12)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Settings Toggle Row

struct SettingsToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .foregroundColor(.white)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.cyan)
        }
        .padding(.vertical, 12)
    }
}

// MARK: - Profile Field Row

struct ProfileFieldRow: View {
    let label: String
    let value: String
    let isEditable: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                
                HStack {
                    Text(value)
                        .font(.title3)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if isEditable {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.5))
                    }
                }
            }
            .padding(.vertical, 12)
        }
        .buttonStyle(.plain)
        .disabled(!isEditable)
    }
}

// MARK: - Achievement Badge

struct AchievementBadgeView: View {
    let achievement: Achievement
    let size: CGFloat = 70
    
    var body: some View {
        VStack(spacing: 8) {
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
                    .frame(width: size, height: size)
                    .shadow(
                        color: achievement.isUnlocked ? .cyan.opacity(0.5) : .clear,
                        radius: 10,
                        x: 0,
                        y: 5
                    )
                
                if achievement.isUnlocked {
                    Image(systemName: achievement.iconName)
                        .font(.system(size: size * 0.4))
                        .foregroundColor(.white)
                } else {
                    Image(systemName: "lock.fill")
                        .font(.system(size: size * 0.3))
                        .foregroundColor(.white.opacity(0.5))
                }
            }
        }
    }
}

// MARK: - Leaderboard Row

struct LeaderboardRowView: View {
    let entry: LeaderboardEntry
    
    var body: some View {
        HStack(spacing: 16) {
            // Rank badge
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(entry.rankColor.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Text("\(entry.rank)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(entry.rankColor)
            }
            
            // Avatar placeholder
            Circle()
                .fill(Color.white.opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.white.opacity(0.5))
                )
            
            // Name
            Text(entry.name)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.white)
            
            Spacer()
            
            // Days clean
            Text("\(entry.daysClean) days")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Stats Card

struct ProfileStatsCard: View {
    let bestStreak: Int
    let tilSober: Int
    let currentStreak: Int
    let currentLevel: Int
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 20) {
                // Best Streak
                VStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.title2)
                        .foregroundColor(.orange)
                    
                    Text("\(bestStreak)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Best Streak")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                    .background(Color.white.opacity(0.3))
                    .frame(height: 60)
                
                // Til Sober
                VStack(spacing: 4) {
                    Image(systemName: "hourglass")
                        .font(.title2)
                        .foregroundColor(.cyan)
                    
                    Text("\(tilSober)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Til Sober")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                .frame(maxWidth: .infinity)
            }
            
            Divider()
                .background(Color.white.opacity(0.2))
            
            // Achievement Progress
            HStack(spacing: 12) {
                Image(systemName: "leaf.circle.fill")
                    .font(.title)
                    .foregroundColor(.green)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Sprout")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("0/5 days clean")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Spacer()
                
                // Progress bar
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 120, height: 8)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                        .frame(width: 120 * CGFloat(currentStreak) / 5.0, height: 8)
                }
            }
        }
        .padding(20)
        .glassEffect(cornerRadius: 24, opacity: 0.2)
    }
}

// MARK: - Action Button (Destructive)

struct DestructiveActionButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 12)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Glass Back Button

struct GlassBackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 44, height: 44)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
    }
}

