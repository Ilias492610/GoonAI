//
//  AnalyticsModels.swift
//  GoonAi
//
//  Analytics models for NoGoon
//

import Foundation
import SwiftUI

// MARK: - Analytics Mode

enum AnalyticsMode: String, CaseIterable {
    case ring = "Ring"
    case radar = "Radar"
}

// MARK: - Dimension Stats

enum DimensionType: String, CaseIterable {
    case physical = "Physical"
    case mental = "Mental"
    case ambition = "Ambition"
    case discipline = "Discipline"
    case relationship = "Relationship"
    case intellect = "Intellect"
    
    var icon: String {
        switch self {
        case .physical: return "heart.fill"
        case .mental: return "brain.head.profile"
        case .ambition: return "target"
        case .discipline: return "list.clipboard.fill"
        case .relationship: return "person.2.fill"
        case .intellect: return "graduationcap.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .physical: return Color.orange
        case .mental: return Color.yellow
        case .ambition: return Color.red
        case .discipline: return Color.blue
        case .relationship: return Color.purple
        case .intellect: return Color.green
        }
    }
}

struct DimensionStat: Identifiable {
    let id = UUID()
    let type: DimensionType
    var value: Double // 0.0 to 1.0
    
    var percentage: Int {
        Int(value * 100)
    }
}

// MARK: - Benefit Model

struct Benefit: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let description: String
    
    static let defaultBenefits: [Benefit] = [
        Benefit(emoji: "💬", title: "Improved confidence", description: "Confidence grows, especially in social and personal interactions."),
        Benefit(emoji: "🌟", title: "Increased Self-Esteem", description: "Improving control boosts your self-image and self-esteem."),
        Benefit(emoji: "🧘", title: "Mental Clarity", description: "Clear thinking and focus returns after quitting."),
        Benefit(emoji: "🔥", title: "Increased Sex Drive", description: "Healthier sex drive and performance after 30-45 days."),
        Benefit(emoji: "🧠", title: "Healthier Thoughts", description: "Less anxiety; healthier views on sex and relationships develop over time."),
        Benefit(emoji: "⏰", title: "More Time & Productivity", description: "More energy and focus for meaningful, productive daily activities."),
        Benefit(emoji: "😴", title: "Better Sleep", description: "Improved sleep quality often seen within a few days.")
    ]
}

// MARK: - Level Model

struct RecoveryLevel: Identifiable {
    let id = UUID()
    let level: Int
    let progress: Double // 0.0 to 1.0
    let title: String
    let description: String
    
    static func current(for days: Int) -> RecoveryLevel {
        // Simple level system: every 10 days = 1 level, each level = 10% progress
        let level = max(1, days / 10 + 1)
        let progressInLevel = Double(days % 10) / 10.0
        
        return RecoveryLevel(
            level: level,
            progress: progressInLevel,
            title: "Level \(level)",
            description: "You don't have urges anymore, mind is clear and physical form is almost at it's peak."
        )
    }
}

// MARK: - Progress Point

struct ProgressPoint: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}

