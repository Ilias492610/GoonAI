//
//  HomeViewModel.swift
//  GoonAi
//
//  Created for NoGoon Home Feature
//

import Foundation
import SwiftUI
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var streakState: StreakState
    @Published var pledgeState: PledgeState
    @Published var relapseState: RelapseState
    @Published var checklistState: ChecklistState
    @Published var journalEntries: [JournalEntry]
    @Published var quittingReason: QuittingReason
    @Published var dailyCheckIns: [DailyCheckIn]
    
    @Published var activeSheet: HomeSheetType?
    @Published var showStreakWarning = false
    @Published var showTierUnlock = false
    
    // MARK: - Computed Properties
    
    var quoteOfDay: String {
        // Can rotate based on date or streak progress
        let quotes = [
            "Today marks the beginning of a powerful journey. This decision is a commitment to a better you. Remember, small steps lead to great changes.",
            "You're building a legacy with every choice you make. This is a step toward the person you want to become.",
            "Every moment of resistance is a victory. You are stronger than your urges.",
            "The journey of a thousand miles begins with a single step. You've already started.",
            "Progress, not perfection. Every day clean is a win."
        ]
        let dayIndex = streakState.currentStreakDays % quotes.count
        return quotes[dayIndex]
    }
    
    var brainRewiringProgress: Int {
        // Simple: 1% per day for first 100 days
        return min(100, max(0, streakState.currentStreakDays))
    }
    
    var formattedPornFreeTime: String {
        let interval = streakState.timeSinceStart
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
    
    var formattedDaysUntilGoal: String {
        return "\(streakState.daysUntilGoal)d"
    }
    
    // MARK: - Initialization
    
    init() {
        // Load from persistence or initialize defaults
        self.streakState = Self.loadStreakState()
        self.pledgeState = Self.loadPledgeState()
        self.relapseState = RelapseState()
        self.checklistState = Self.loadChecklistState()
        self.journalEntries = Self.loadJournalEntries()
        self.quittingReason = Self.loadQuittingReason()
        self.dailyCheckIns = Self.loadDailyCheckIns()
    }
    
    // MARK: - Streak Actions
    
    func showStreakOptions() {
        activeSheet = .streakOptions
    }
    
    func editStreakDate(newDate: Date) {
        streakState.startDate = newDate
        streakState.hasEditedStartDate = true
        saveStreakState()
        activeSheet = nil
    }
    
    func resetStreak() {
        streakState.startDate = Date()
        streakState.relapseCount += 1
        streakState.lastRelapseDate = Date()
        saveStreakState()
        activeSheet = nil
    }
    
    // MARK: - Pledge Actions
    
    func startPledge() {
        let now = Date()
        pledgeState.isActive = true
        pledgeState.startDate = now
        pledgeState.nextCheckInDate = Calendar.current.date(byAdding: .hour, value: 24, to: now)
        savePledgeState()
        activeSheet = nil
        
        // TODO: Schedule local notification for check-in
    }
    
    func completePledge(successful: Bool, feeling: String, notes: String?) {
        let checkIn = DailyCheckIn(
            didSucceed: successful,
            feeling: feeling,
            notes: notes
        )
        dailyCheckIns.append(checkIn)
        saveDailyCheckIns()
        
        pledgeState.isActive = false
        pledgeState.startDate = nil
        pledgeState.nextCheckInDate = nil
        savePledgeState()
        
        activeSheet = nil
    }
    
    // MARK: - Relapse Actions
    
    func startRelapseFlow() {
        activeSheet = .relapseReflection
    }
    
    func continueRelapseFlow() {
        activeSheet = .relapseResult
    }
    
    func showRelapseCheckIn() {
        activeSheet = .relapseCheckIn
    }
    
    func confirmRelapse() {
        activeSheet = .relapseFeeling
    }
    
    func selectRelapseFeeling(_ feeling: RelapseState.Feeling) {
        relapseState.selectedFeeling = feeling
        relapseState.hasRelapsedToday = true
        activeSheet = .relapseCommunityStats
    }
    
    func finishRelapseFlow(shouldReset: Bool) {
        if shouldReset {
            resetStreak()
        }
        relapseState.hasRelapsedToday = false
        relapseState.selectedFeeling = nil
        activeSheet = nil
    }
    
    // MARK: - Journal Actions
    
    func addJournalEntry(title: String, body: String) {
        let entry = JournalEntry(title: title, body: body)
        journalEntries.insert(entry, at: 0)
        saveJournalEntries()
        activeSheet = nil
    }
    
    func updateQuittingReason(_ text: String) {
        quittingReason.text = text
        quittingReason.lastUpdated = Date()
        saveQuittingReason()
        activeSheet = nil
    }
    
    // MARK: - Checklist Actions
    
    func toggleChecklistItem(_ itemId: String) {
        if let index = checklistState.items.firstIndex(where: { $0.id == itemId }) {
            checklistState.items[index].isCompleted.toggle()
            saveChecklistState()
        }
    }
    
    func handleChecklistAction(_ action: ChecklistItem.ActionType) {
        switch action {
        case .enableNotifications:
            // TODO: Request notification permissions
            toggleChecklistItem("notifications")
        case .plantTree:
            // TODO: Navigate to tree planting feature
            toggleChecklistItem("tree")
        case .joinCommunity:
            // TODO: Open Telegram or navigate to Community tab
            toggleChecklistItem("community")
        case .enableBlocker:
            activeSheet = .contentBlocker
        case .createPost:
            // TODO: Navigate to community post creation
            toggleChecklistItem("post")
        }
    }
    
    // MARK: - Panic Button
    
    func showPanicButton() {
        activeSheet = .panicButton
    }
    
    // MARK: - Tier Unlock
    
    func checkForTierUnlock() {
        let previousDays = streakState.currentStreakDays - 1
        let currentTier = StreakTier.tier(for: streakState.currentStreakDays)
        let previousTier = StreakTier.tier(for: previousDays)
        
        if currentTier != previousTier {
            showTierUnlock = true
        }
    }
    
    // MARK: - Persistence
    
    private static func loadStreakState() -> StreakState {
        if let data = PersistanceManager.shared.retrieveFile(.user) as? Data,
           let state = try? JSONDecoder().decode(StreakState.self, from: data) {
            return state
        }
        return StreakState()
    }
    
    private func saveStreakState() {
        if let data = try? JSONEncoder().encode(streakState) {
            PersistanceManager.shared.saveFile(.user, value: data)
        }
    }
    
    private static func loadPledgeState() -> PledgeState {
        if let data = UserDefaults.standard.data(forKey: "pledgeState"),
           let state = try? JSONDecoder().decode(PledgeState.self, from: data) {
            return state
        }
        return PledgeState()
    }
    
    private func savePledgeState() {
        if let data = try? JSONEncoder().encode(pledgeState) {
            UserDefaults.standard.set(data, forKey: "pledgeState")
        }
    }
    
    private static func loadChecklistState() -> ChecklistState {
        if let data = UserDefaults.standard.data(forKey: "checklistState"),
           let state = try? JSONDecoder().decode(ChecklistState.self, from: data) {
            return state
        }
        return ChecklistState()
    }
    
    private func saveChecklistState() {
        if let data = try? JSONEncoder().encode(checklistState) {
            UserDefaults.standard.set(data, forKey: "checklistState")
        }
    }
    
    private static func loadJournalEntries() -> [JournalEntry] {
        if let data = UserDefaults.standard.data(forKey: "journalEntries"),
           let entries = try? JSONDecoder().decode([JournalEntry].self, from: data) {
            return entries
        }
        return []
    }
    
    private func saveJournalEntries() {
        if let data = try? JSONEncoder().encode(journalEntries) {
            UserDefaults.standard.set(data, forKey: "journalEntries")
        }
    }
    
    private static func loadQuittingReason() -> QuittingReason {
        if let data = UserDefaults.standard.data(forKey: "quittingReason"),
           let reason = try? JSONDecoder().decode(QuittingReason.self, from: data) {
            return reason
        }
        return QuittingReason()
    }
    
    private func saveQuittingReason() {
        if let data = try? JSONEncoder().encode(quittingReason) {
            UserDefaults.standard.set(data, forKey: "quittingReason")
        }
    }
    
    private static func loadDailyCheckIns() -> [DailyCheckIn] {
        if let data = UserDefaults.standard.data(forKey: "dailyCheckIns"),
           let checkIns = try? JSONDecoder().decode([DailyCheckIn].self, from: data) {
            return checkIns
        }
        return []
    }
    
    private func saveDailyCheckIns() {
        if let data = try? JSONEncoder().encode(dailyCheckIns) {
            UserDefaults.standard.set(data, forKey: "dailyCheckIns")
        }
    }
}

