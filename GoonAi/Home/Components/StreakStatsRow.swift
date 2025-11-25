//
//  StreakStatsRow.swift
//  GoonAi
//
//  Stats row showing Relapses, Porn Free For, Til Sober
//

import SwiftUI

struct StreakStatsRow: View {
    let relapseCount: Int
    let pornFreeTime: String
    let daysUntilGoal: String
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color.white.opacity(0.2))
                .padding(.horizontal, 30)
            
            HStack(spacing: 0) {
                StatColumn(title: "Relapses", value: "\(relapseCount)")
                
                Divider()
                    .background(Color.white.opacity(0.2))
                    .frame(height: 50)
                
                StatColumn(title: "Porn Free For:", value: pornFreeTime)
                
                Divider()
                    .background(Color.white.opacity(0.2))
                    .frame(height: 50)
                
                StatColumn(title: "Til Sober:", value: daysUntilGoal)
            }
            .frame(height: 70)
            
            Divider()
                .background(Color.white.opacity(0.2))
                .padding(.horizontal, 30)
        }
    }
}

struct StatColumn: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
    }
}

