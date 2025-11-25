//
//  ProfileModels.swift
//  GoonAi
//
//  Data models for Profile feature
//

import SwiftUI

// MARK: - User Profile

struct UserProfile: Codable {
    var email: String
    var name: String
    var age: Int
    var gender: String
    var orientation: String
    var ethnicity: String
    var religiousContent: String
    var region: String
    var avatarImageName: String? // Future: actual image
    
    static var placeholder: UserProfile {
        UserProfile(
            email: "user@example.com",
            name: "Ilias",
            age: 22,
            gender: "Male",
            orientation: "Straight",
            ethnicity: "White",
            religiousContent: "Non-religious",
            region: "North America",
            avatarImageName: nil
        )
    }
}

// MARK: - Achievement

struct Achievement: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let daysRequired: Int
    let iconName: String
    var isUnlocked: Bool
    var unlockedDate: Date?
    
    // Display badge number (position in list)
    var badgeNumber: Int {
        return Achievement.allAchievements.firstIndex(where: { $0.id == id }) ?? 0
    }
    
    static let allAchievements: [Achievement] = [
        Achievement(
            id: "sprout",
            title: "Sprout",
            description: "The first few days are tough—but you're tougher. You're already proving your strength. Keep your reasons close.",
            daysRequired: 0,
            iconName: "leaf.circle.fill",
            isUnlocked: true,
            unlockedDate: Date()
        ),
        Achievement(
            id: "momentum",
            title: "Momentum",
            description: "You've made it through the hardest part. Your foundation is stronger. Reflect on how far you've come.",
            daysRequired: 7,
            iconName: "bolt.circle.fill",
            isUnlocked: false
        ),
        Achievement(
            id: "fortress",
            title: "Fortress",
            description: "You're building resilience. These early days are laying deep roots. Stay focused and keep moving forward.",
            daysRequired: 10,
            iconName: "shield.circle.fill",
            isUnlocked: false
        ),
        Achievement(
            id: "warrior",
            title: "Warrior",
            description: "Two weeks clean. You're proving to yourself that change is real. Your commitment is showing.",
            daysRequired: 14,
            iconName: "figure.strengthtraining.traditional",
            isUnlocked: false
        ),
        Achievement(
            id: "catalyst",
            title: "Catalyst",
            description: "Three weeks in, your brain is rewiring. The patterns are shifting. You're becoming who you want to be.",
            daysRequired: 21,
            iconName: "brain.head.profile",
            isUnlocked: false
        ),
        Achievement(
            id: "titan",
            title: "Titan",
            description: "30 days. A full month of freedom. You've proven you can do this. Keep building on this foundation.",
            daysRequired: 30,
            iconName: "crown.fill",
            isUnlocked: false
        ),
        Achievement(
            id: "legend",
            title: "Legend",
            description: "60 days clean. You're not just recovering—you're transforming. This is your new normal.",
            daysRequired: 60,
            iconName: "star.circle.fill",
            isUnlocked: false
        ),
        Achievement(
            id: "master",
            title: "Master",
            description: "90 days. The neural pathways have rewired. You've reached a milestone few achieve. This is true freedom.",
            daysRequired: 90,
            iconName: "sparkles",
            isUnlocked: false
        )
    ]
}

// MARK: - Leaderboard Entry

struct LeaderboardEntry: Identifiable {
    let id: String
    let rank: Int
    let name: String
    let daysClean: Int
    let avatarImageName: String?
    
    var rankColor: Color {
        switch rank {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return .white.opacity(0.5)
        }
    }
    
    static let mockLeaderboard: [LeaderboardEntry] = [
        LeaderboardEntry(id: "1", rank: 1, name: "Ari", daysClean: 1311, avatarImageName: nil),
        LeaderboardEntry(id: "2", rank: 2, name: "Blake", daysClean: 850, avatarImageName: nil),
        LeaderboardEntry(id: "3", rank: 3, name: "joel mhn", daysClean: 795, avatarImageName: nil),
        LeaderboardEntry(id: "4", rank: 4, name: "Alex", daysClean: 654, avatarImageName: nil),
        LeaderboardEntry(id: "5", rank: 5, name: "Jordan", daysClean: 543, avatarImageName: nil),
        LeaderboardEntry(id: "230666", rank: 230666, name: "Ilias", daysClean: 0, avatarImageName: nil)
    ]
}

// MARK: - Referral Data

struct ReferralData {
    let promoCode: String
    let guestPassDays: Int
    let earnedAmount: Double
    
    static var placeholder: ReferralData {
        ReferralData(
            promoCode: "IG3N2",
            guestPassDays: 30,
            earnedAmount: 0.0
        )
    }
}

