//
//  HomeModels.swift
//  GoonAi
//
//  Created for NoGoon Home Feature
//

import Foundation
import SwiftUI

// MARK: - Streak State

struct StreakState: Codable {
    var startDate: Date
    var relapseCount: Int
    var lastRelapseDate: Date?
    var goalDays: Int // e.g., 90 days for "sober"
    var hasEditedStartDate: Bool // For leaderboard exclusion
    
    init(startDate: Date = Date(), relapseCount: Int = 0, lastRelapseDate: Date? = nil, goalDays: Int = 90, hasEditedStartDate: Bool = false) {
        self.startDate = startDate
        self.relapseCount = relapseCount
        self.lastRelapseDate = lastRelapseDate
        self.goalDays = goalDays
        self.hasEditedStartDate = hasEditedStartDate
    }
    
    var currentStreakDays: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: Date()).day ?? 0
    }
    
    var timeSinceStart: TimeInterval {
        Date().timeIntervalSince(startDate)
    }
    
    var daysUntilGoal: Int {
        max(0, goalDays - currentStreakDays)
    }
    
    var currentTier: StreakTier {
        StreakTier.tier(for: currentStreakDays)
    }
    
    var nextTier: StreakTier? {
        currentTier.next
    }
    
    var progressToNextTier: Double {
        guard let next = nextTier else { return 1.0 }
        let tierRange = Double(next.minDays - currentTier.minDays)
        let progress = Double(currentStreakDays - currentTier.minDays)
        return min(1.0, max(0.0, progress / tierRange))
    }
}

// MARK: - Streak Tier

enum StreakTier: CaseIterable {
    case sprout
    case warrior
    case champion
    case legend
    
    var name: String {
        switch self {
        case .sprout: return "Sprout"
        case .warrior: return "Warrior"
        case .champion: return "Champion"
        case .legend: return "Legend"
        }
    }
    
    var minDays: Int {
        switch self {
        case .sprout: return 0
        case .warrior: return 15
        case .champion: return 30
        case .legend: return 90
        }
    }
    
    var next: StreakTier? {
        let all = StreakTier.allCases
        guard let index = all.firstIndex(of: self), index < all.count - 1 else { return nil }
        return all[index + 1]
    }
    
    static func tier(for days: Int) -> StreakTier {
        if days >= 90 { return .legend }
        if days >= 30 { return .champion }
        if days >= 15 { return .warrior }
        return .sprout
    }
}

// MARK: - Pledge State

struct PledgeState: Codable {
    var isActive: Bool
    var startDate: Date?
    var nextCheckInDate: Date?
    
    init(isActive: Bool = false, startDate: Date? = nil, nextCheckInDate: Date? = nil) {
        self.isActive = isActive
        self.startDate = startDate
        self.nextCheckInDate = nextCheckInDate
    }
    
    var hoursUntilCheckIn: Int? {
        guard let checkIn = nextCheckInDate else { return nil }
        let diff = Calendar.current.dateComponents([.hour], from: Date(), to: checkIn).hour ?? 0
        return max(0, diff)
    }
}

// MARK: - Relapse State

struct RelapseState: Codable {
    var selectedFeeling: Feeling?
    var hasRelapsedToday: Bool
    
    init(selectedFeeling: Feeling? = nil, hasRelapsedToday: Bool = false) {
        self.selectedFeeling = selectedFeeling
        self.hasRelapsedToday = hasRelapsedToday
    }
    
    enum Feeling: String, Codable {
        case happy
        case neutral
        case sad
        
        var emoji: String {
            switch self {
            case .happy: return "😊"
            case .neutral: return "😐"
            case .sad: return "😔"
            }
        }
        
        var displayText: String {
            switch self {
            case .happy: return "Controlled"
            case .neutral: return "Neutral"
            case .sad: return "Struggling"
            }
        }
    }
}

// MARK: - Checklist State

struct ChecklistState: Codable {
    var items: [ChecklistItem]
    
    init(items: [ChecklistItem] = ChecklistItem.defaultItems) {
        self.items = ChecklistItem.normalizedItems(from: items)
    }
}

struct ChecklistItem: Codable, Identifiable {
    var id: String
    var title: String
    var description: String
    var iconName: String
    var isCompleted: Bool
    var hasLaunched: Bool = false
    var actionType: ActionType
    
    enum ActionType: String, Codable {
        case enableNotifications
        case plantTree
        case joinCommunity
        case enableBlocker
        case createPost
    }
    
    static var defaultItems: [ChecklistItem] {
        templateItems
    }
    
    private static var templateItems: [ChecklistItem] {
        [
            ChecklistItem(
                id: "notifications",
                title: "Enable Notifications",
                description: "Get daily notifications that inspire you to stay strong. Click here to enable.",
                iconName: "bell.fill",
                isCompleted: false,
                hasLaunched: false,
                actionType: .enableNotifications
            ),
            ChecklistItem(
                id: "community",
                title: "Join Community",
                description: "We have an exclusive chat for members on Telegram. Click here to join.",
                iconName: "person.3.fill",
                isCompleted: false,
                hasLaunched: false,
                actionType: .joinCommunity
            ),
            ChecklistItem(
                id: "blocker",
                title: "Enable Content Blocker",
                description: "Stop pesky websites from causing you to relapse with the NoGoon blocker. Click here to enable.",
                iconName: "shield.fill",
                isCompleted: false,
                hasLaunched: false,
                actionType: .enableBlocker
            )
        ]
    }
    
    static func normalizedItems(from storedItems: [ChecklistItem]) -> [ChecklistItem] {
        let lookup = Dictionary(uniqueKeysWithValues: storedItems.map { ($0.id, $0) })
        return templateItems.compactMap { template in
            if let stored = lookup[template.id], !stored.isCompleted {
                return stored
            }
            return template
        }
    }
}

// MARK: - Journal Entry

struct JournalEntry: Codable, Identifiable {
    var id: String
    var title: String
    var body: String
    var createdAt: Date
    
    init(id: String = UUID().uuidString, title: String, body: String, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.body = body
        self.createdAt = createdAt
    }
}

// MARK: - Quitting Reason

struct QuittingReason: Codable {
    var text: String
    var lastUpdated: Date
    
    init(text: String = "", lastUpdated: Date = Date()) {
        self.text = text
        self.lastUpdated = lastUpdated
    }
}

// MARK: - Daily Check-In

struct DailyCheckIn: Codable, Identifiable {
    var id: String
    var date: Date
    var didSucceed: Bool
    var feeling: String
    var notes: String?
    
    init(id: String = UUID().uuidString, date: Date = Date(), didSucceed: Bool, feeling: String, notes: String? = nil) {
        self.id = id
        self.date = date
        self.didSucceed = didSucceed
        self.feeling = feeling
        self.notes = notes
    }
}

// MARK: - Brain Rewiring Progress

struct BrainRewiringProgress {
    var percentComplete: Int {
        // Simple calculation: 1% per day, max 100%
        // Can be customized based on streak
        return min(100, max(0, 0)) // TODO: Link to actual streak days
    }
}

// MARK: - Home Sheet Type

enum HomeSheetType: Identifiable {
    case streakOptions
    case pledge
    case pledgeConfirmation
    case relapseReflection
    case relapseResult
    case relapseCheckIn
    case relapseFeeling
    case relapseCommunityStats
    case urgeSupport
    case journalAdd
    case quittingReason
    case dailyCheckIn
    case contentBlocker
    case panicButton
    case meditation
    
    var id: String {
        switch self {
        case .streakOptions: return "streakOptions"
        case .pledge: return "pledge"
        case .pledgeConfirmation: return "pledgeConfirmation"
        case .relapseReflection: return "relapseReflection"
        case .relapseResult: return "relapseResult"
        case .relapseCheckIn: return "relapseCheckIn"
        case .relapseFeeling: return "relapseFeeling"
        case .relapseCommunityStats: return "relapseCommunityStats"
        case .urgeSupport: return "urgeSupport"
        case .journalAdd: return "journalAdd"
        case .quittingReason: return "quittingReason"
        case .dailyCheckIn: return "dailyCheckIn"
        case .contentBlocker: return "contentBlocker"
        case .panicButton: return "panicButton"
        case .meditation: return "meditation"
        }
    }
}

