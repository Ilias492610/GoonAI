//
//  HomeActionButton.swift
//  GoonAi
//
//  Action button component (Pledge, Meditate, Reset)
//

import SwiftUI

struct HomeActionButton: View {
    let title: String
    let iconName: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(isActive ? 0.25 : 0.12),
                                    Color.white.opacity(isActive ? 0.15 : 0.08)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 70, height: 70)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(isActive ? 0.4 : 0.2), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                    
                    Image(systemName: iconName)
                        .font(.system(size: 28))
                        .foregroundColor(.white.opacity(isActive ? 1.0 : 0.7))
                }
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .buttonStyle(.plain)
    }
}

struct HomeActionRow: View {
    let pledgeActive: Bool
    let onPledge: () -> Void
    let onMeditate: () -> Void
    let onReset: () -> Void
    
    var body: some View {
        HStack(spacing: 30) {
            HomeActionButton(
                title: pledgeActive ? "Pledged" : "Pledge",
                iconName: "hand.raised.fill",
                isActive: pledgeActive,
                action: onPledge
            )
            
            HomeActionButton(
                title: "Meditate",
                iconName: "figure.mind.and.body",
                isActive: false,
                action: onMeditate
            )
            
            HomeActionButton(
                title: "Reset",
                iconName: "arrow.counterclockwise.circle.fill",
                isActive: false,
                action: onReset
            )
        }
        .padding(.horizontal)
    }
}

