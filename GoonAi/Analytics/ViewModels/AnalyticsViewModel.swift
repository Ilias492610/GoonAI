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
    
    @Published var mode: AnalyticsMode = .ring
    @Published var recoveryProgress: Double = 0.0
    @Published var currentStreakDays: Int = 0
    @Published var highestStreakDays: Int = 0
    @Published var completedDailyActivities: Int = 0
    @Published var totalDailyActivities: Int = 6
    @Published var targetQuitDate: Date
    @Published var firstLoginDate: Date
    @Published var selectedDimension: DimensionType?
    
    // Dimension stats
    @Published var dimensionStats: [DimensionStat] = []
    
    // Progress history
    @Published var progressHistory: [ProgressPoint] = []
    
    // Benefits
    let benefits = Benefit.defaultBenefits
    
    // MARK: - Computed Properties
    
    var recoveryPercentage: Int {
        Int(recoveryProgress * 100)
    }
    
    var currentLevel: RecoveryLevel {
        RecoveryLevel.current(for: currentStreakDays)
    }
    
    var quitDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: targetQuitDate)
    }
    
    var firstLoginFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter.string(from: firstLoginDate)
    }
    
    // MARK: - Initialization
    
    init() {
        // Load from persistence or calculate from streak data
        self.firstLoginDate = Date().addingTimeInterval(-7 * 24 * 60 * 60) // 7 days ago
        self.targetQuitDate = Calendar.current.date(byAdding: .day, value: 90, to: Date()) ?? Date()
        
        loadAnalytics()
        generateMockProgressHistory()
    }
    
    // MARK: - Data Loading
    
    private func loadAnalytics() {
        // TODO: Load from Home streak state or persistence
        // For now, use mock data
        currentStreakDays = 0
        highestStreakDays = 0
        completedDailyActivities = 0
        recoveryProgress = Double(currentStreakDays) / 90.0 // 90 days = 100%
        
        // Initialize dimension stats
        dimensionStats = DimensionType.allCases.map { type in
            DimensionStat(type: type, value: 0.0)
        }
        
        // TODO: Calculate dimension values based on completed activities
    }
    
    private func generateMockProgressHistory() {
        // Generate sample progress data for the chart
        let calendar = Calendar.current
        var points: [ProgressPoint] = []
        
        for dayOffset in 0...30 {
            if let date = calendar.date(byAdding: .day, value: -30 + dayOffset, to: Date()) {
                // Simulate gradual progress increase
                let progress = Double(dayOffset) / 30.0 * 0.3 // Max 30% in mock data
                points.append(ProgressPoint(date: date, value: progress))
            }
        }
        
        progressHistory = points
    }
    
    // MARK: - Actions
    
    func toggleMode() {
        mode = mode == .ring ? .radar : .ring
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func selectDimension(_ dimension: DimensionType) {
        if selectedDimension == dimension {
            selectedDimension = nil
        } else {
            selectedDimension = dimension
        }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func syncWithHomeStreak(days: Int, relapseCount: Int) {
        // Call this from HomeViewModel to keep analytics in sync
        currentStreakDays = days
        highestStreakDays = max(highestStreakDays, days)
        recoveryProgress = Double(days) / 90.0
        
        // Update dimension stats based on streak
        updateDimensionStats()
    }
    
    private func updateDimensionStats() {
        // Simple algorithm: longer streak = higher stats
        let baseProgress = min(1.0, Double(currentStreakDays) / 90.0)
        
        dimensionStats = DimensionType.allCases.map { type in
            // Add some variation per dimension
            let variance = Double.random(in: -0.1...0.1)
            let value = max(0.0, min(1.0, baseProgress + variance))
            return DimensionStat(type: type, value: value)
        }
    }
}

