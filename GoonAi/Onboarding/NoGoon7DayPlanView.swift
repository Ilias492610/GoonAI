//
//  NoGoon7DayPlanView.swift
//  GoonAi
//
//  7-day plan overview screen
//

import SwiftUI

struct NoGoon7DayPlanView: View {
    let onComplete: () -> Void
    
    private let dayCards: [DayCard] = [
        DayCard(emoji: "💪", day: 5, title: "Feel Better in Your Body", subtitle: "Move, eat clean, and recharge — your energy and clarity return fast."),
        DayCard(emoji: "🌍", day: 6, title: "You're Not Alone", subtitle: "Connect with others on the same path. Share wins, get support."),
        DayCard(emoji: "🕹️", day: 7, title: "Take Back Your Time", subtitle: "Replace old habits with real goals and meaningful action."),
    ]
    
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
            
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Top info card
                        VStack(spacing: 15) {
                            Text("🧠 Your focus starts coming back fast.")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text("The fog begins to lift, and motivation slowly returns. Stay grounded: better sleep, energy, and clarity are right around the corner.")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.purple, Color.blue],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                        .padding(.horizontal)
                        .padding(.top, 60)
                        
                        // Day cards
                        ForEach(dayCards) { card in
                            DayCardView(card: card)
                        }
                        
                        // Week end card
                        VStack(spacing: 15) {
                            HStack {
                                Text("📊")
                                    .font(.system(size: 30))
                                Text("End of Week One – Stats & Momentum")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            
                            Text("Your urges are still there but easier to manage. Energy, confidence, and real motivation start replacing the old habits. Your brain's reward system is stabilizing, this is the first real taste of freedom.")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.purple, Color.blue],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                        .padding(.horizontal)
                        
                        // No commitment badge
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("No commitment, cancel anytime")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(.top, 30)
                        
                        Spacer().frame(height: 120)
                    }
                }
                
                // Bottom button
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    onComplete()
                }) {
                    HStack {
                        Text("START MY JOURNEY TODAY")
                        Text("🙌")
                    }
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [Color.purple, Color.blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(30)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
        }
    }
}

// MARK: - Day Card Model

struct DayCard: Identifiable {
    let id = UUID()
    let emoji: String
    let day: Int
    let title: String
    let subtitle: String
}

// MARK: - Day Card View

struct DayCardView: View {
    let card: DayCard
    
    var body: some View {
        HStack(spacing: 20) {
            Text(card.emoji)
                .font(.system(size: 50))
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Day \(card.day) – \(card.title)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(card.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white.opacity(0.1))
        )
        .padding(.horizontal)
    }
}

