//
//  RecoveryRingView.swift
//  GoonAi
//
//  Recovery ring chart component
//

import SwiftUI

struct RecoveryRingView: View {
    let progress: Double
    let days: Int
    
    @State private var animateProgress = false
    
    var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(
                    Color.white.opacity(0.1),
                    lineWidth: 20
                )
                .frame(width: 220, height: 220)
            
            // Progress ring
            Circle()
                .trim(from: 0, to: animateProgress ? progress : 0)
                .stroke(
                    LinearGradient(
                        colors: [Color.cyan, Color.green],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .frame(width: 220, height: 220)
                .rotationEffect(.degrees(-90))
            
            // Progress indicator dot
            if progress > 0 {
                Circle()
                    .fill(Color.green)
                    .frame(width: 24, height: 24)
                    .offset(y: -110)
                    .rotationEffect(.degrees(360 * progress))
            }
            
            // Center content
            VStack(spacing: 8) {
                Text("Recovery")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.7))
                
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 56, weight: .bold))
                    .foregroundColor(.white)
                
                Text("\(days) Days Streak")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.5)) {
                animateProgress = true
            }
        }
    }
}

struct RecoveryRingCard: View {
    let progress: Double
    let days: Int
    
    var body: some View {
        VStack {
            RecoveryRingView(progress: progress, days: days)
                .padding(.vertical, 40)
        }
        .frame(maxWidth: .infinity)
        .glassEffect()
        .padding(.horizontal)
    }
}

