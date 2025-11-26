//
//  AnalyticsViewModel.swift
//  GoonAi
//
//  Analytics view model for NoGoon
//

import Foundation
import SwiftUI
import Combine

@MainActor
class AnalyticsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var recoveryProgress: Double = 0.0
    @Published var currentStreakDays: Int = 0
    @Published var highestStreakDays: Int = 0
    @Published var targetQuitDate: Date
    @Published var firstLoginDate: Date
    
    // Benefits with progress
    @Published var benefits: [Benefit] = []
    
    // MARK: - Computed Properties
    
    var recoveryPercentage: Int {
        Int(recoveryProgress * 100)
    }
    
    // MARK: - Initialization
    
    init() {
        // Load from persistence or calculate from streak data
        self.firstLoginDate = Date().addingTimeInterval(-7 * 24 * 60 * 60) // 7 days ago
        self.targetQuitDate = Calendar.current.date(byAdding: .day, value: 90, to: Date()) ?? Date()
        
        loadAnalytics()
    }
    
    // MARK: - Data Loading
    
    private func loadAnalytics() {
        // TODO: Load from Home streak state or persistence
        // For now, use mock data
        currentStreakDays = 0
        highestStreakDays = 0
        recoveryProgress = Double(currentStreakDays) / 90.0 // 90 days = 100%
        
        // Initialize benefits with random progress based on days
        benefits = Benefit.createBenefitsWithProgress(forDay: currentStreakDays)
    }
    
    // MARK: - Actions
    
    func syncWithHomeStreak(days: Int, relapseCount: Int) {
        // Call this from HomeViewModel to keep analytics in sync
        currentStreakDays = days
        highestStreakDays = max(highestStreakDays, days)
        recoveryProgress = Double(days) / 90.0
        
        // Update benefits progress based on new day count
        benefits = Benefit.createBenefitsWithProgress(forDay: days)
    }
}

