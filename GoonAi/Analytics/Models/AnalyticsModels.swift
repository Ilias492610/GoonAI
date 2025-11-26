//
//  AnalyticsModels.swift
//  GoonAi
//
//  Analytics models for NoGoon
//

import Foundation
import SwiftUI

// MARK: - Benefit Model

struct Benefit: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let description: String
    var progress: Double // 0.0 to 1.0
    
    static func createBenefitsWithProgress(forDay day: Int) -> [Benefit] {
        // Seed random generator with day number for consistent results per day
        var generator = SeededRandomNumberGenerator(seed: UInt64(day))
        
        return [
            Benefit(
                emoji: "💬",
                title: "Improved confidence",
                description: "Confidence grows, especially in social and personal interactions.",
                progress: calculateProgress(forDay: day, generator: &generator)
            ),
            Benefit(
                emoji: "🌟",
                title: "Increased Self-Esteem",
                description: "Improving control boosts your self-image and self-esteem.",
                progress: calculateProgress(forDay: day, generator: &generator)
            ),
            Benefit(
                emoji: "🧘",
                title: "Mental Clarity",
                description: "Clear thinking and focus returns after quitting.",
                progress: calculateProgress(forDay: day, generator: &generator)
            ),
            Benefit(
                emoji: "🔥",
                title: "Increased Sex Drive",
                description: "Healthier sex drive and performance after 30-45 days.",
                progress: calculateProgress(forDay: day, generator: &generator)
            ),
            Benefit(
                emoji: "🧠",
                title: "Healthier Thoughts",
                description: "Less anxiety; healthier views on sex and relationships develop over time.",
                progress: calculateProgress(forDay: day, generator: &generator)
            ),
            Benefit(
                emoji: "⏰",
                title: "More Time & Productivity",
                description: "More energy and focus for meaningful, productive daily activities.",
                progress: calculateProgress(forDay: day, generator: &generator)
            ),
            Benefit(
                emoji: "😴",
                title: "Better Sleep",
                description: "Improved sleep quality often seen within a few days.",
                progress: calculateProgress(forDay: day, generator: &generator)
            )
        ]
    }
    
    private static func calculateProgress(forDay day: Int, generator: inout SeededRandomNumberGenerator) -> Double {
        // Base progress increases with days (max 90 days = 100%)
        let baseProgress = min(1.0, Double(day) / 90.0)
        
        // Add random variation (-10% to +10%)
        let randomVariation = Double.random(in: -0.1...0.1, using: &generator)
        
        // Ensure result is between 0 and 1
        return max(0.0, min(1.0, baseProgress + randomVariation))
    }
}

// MARK: - Seeded Random Number Generator

struct SeededRandomNumberGenerator: RandomNumberGenerator {
    private var state: UInt64
    
    init(seed: UInt64) {
        state = seed
    }
    
    mutating func next() -> UInt64 {
        state = state &+ 0x9e3779b97f4a7c15
        var z = state
        z = (z ^ (z >> 30)) &* 0xbf58476d1ce4e5b9
        z = (z ^ (z >> 27)) &* 0x94d049bb133111eb
        return z ^ (z >> 31)
    }
}

