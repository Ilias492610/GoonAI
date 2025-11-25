//
//  NoGoonBreakCycleView.swift
//  GoonAi
//
//  Break the cycle overview screen with 3 phone mockups
//

import SwiftUI

struct NoGoonBreakCycleView: View {
    let onComplete: () -> Void
    
    var body: some View {
        ZStack {
            // Dark gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.1, blue: 0.2),
                    Color(red: 0.1, green: 0.15, blue: 0.3)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            StarryBackgroundView()
            
            VStack(spacing: 40) {
                Spacer()
                
                // QUITTR logo
                Text("QUITTR")
                    .font(.system(size: 24, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .tracking(3)
                
                // Title
                Text("Break the cycle today")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                // 3 Phone mockups
                HStack(spacing: -50) {
                    // Left phone - Analytics
                    PhoneMockup(title: "Analytics", color: .purple)
                        .scaleEffect(0.7)
                        .rotationEffect(.degrees(-15))
                        .offset(y: 30)
                    
                    // Center phone - Home
                    PhoneMockup(title: "Home", color: .blue)
                        .scaleEffect(0.85)
                        .zIndex(1)
                    
                    // Right phone - Library
                    PhoneMockup(title: "Library", color: .green)
                        .scaleEffect(0.7)
                        .rotationEffect(.degrees(15))
                        .offset(y: 30)
                }
                .frame(height: 500)
                
                Spacer()
                
                // Continue button (fixed styling)
                VStack(spacing: 0) {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        onComplete()
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.white)
                            .cornerRadius(30)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

// MARK: - Phone Mockup

struct PhoneMockup: View {
    let title: String
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .fill(color.opacity(0.3))
            .frame(width: 180, height: 380)
            .overlay(
                VStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 60)
                    
                    Spacer()
                    
                    // Mock content
                    Circle()
                        .fill(color.opacity(0.5))
                        .frame(width: 120, height: 120)
                    
                    Spacer()
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.white.opacity(0.3), lineWidth: 2)
            )
    }
}

