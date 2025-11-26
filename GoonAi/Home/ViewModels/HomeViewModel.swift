//
//  HomeViewModel.swift
//  GoonAi
//
//  Created for NoGoon Home Feature
//

import Foundation
import SwiftUI
import Combine
import UserNotifications
import UIKit

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
            "The only person you are destined to become is the person you decide to be.",
            "Strength doesn't come from what you can do. It comes from overcoming the things you once thought you couldn't.",
            "Every battle you fight makes you stronger for the next one. Keep pushing forward.",
            "Your future self is counting on the decisions you make today. Make them count.",
            "Discipline is choosing between what you want now and what you want most."
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
        activeSheet = .relapseResult
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
    
    func deleteJournalEntry(_ entry: JournalEntry) {
        journalEntries.removeAll { $0.id == entry.id }
        saveJournalEntries()
    }
    
    func updateQuittingReason(_ text: String) {
        quittingReason.text = text
        quittingReason.lastUpdated = Date()
        saveQuittingReason()
        activeSheet = nil
    }
    
    // MARK: - Checklist Actions
    
    func handleChecklistAction(_ item: ChecklistItem) {
        guard let index = checklistState.items.firstIndex(where: { $0.id == item.id }) else { return }
        var updatedItem = checklistState.items[index]
        
        if updatedItem.hasLaunched {
            checklistState.items.remove(at: index)
            saveChecklistState()
            return
        }
        
        launchDestination(for: updatedItem)
        updatedItem.hasLaunched = true
        checklistState.items[index] = updatedItem
        saveChecklistState()
    }
    
    private func launchDestination(for item: ChecklistItem) {
        switch item.actionType {
        case .enableNotifications:
            requestNotificationPermission()
        case .joinCommunity:
            open(urlString: "https://t.me/NoGoonCommunity")
        case .enableBlocker:
            activeSheet = .contentBlocker
        case .plantTree, .createPost:
            break
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
            if !granted {
                self?.open(urlString: UIApplication.openSettingsURLString)
            }
        }
    }
    
    private func open(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
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
            return ChecklistState(items: state.items)
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

