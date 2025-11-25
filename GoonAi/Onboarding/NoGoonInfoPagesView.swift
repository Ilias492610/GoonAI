//
//  NoGoonInfoPagesView.swift
//  GoonAi
//
//  Info pages about QUITTR features (matching starry blue gradient pages)
//

import SwiftUI

struct NoGoonInfoPagesView: View {
    @State private var currentPage = 0
    let onComplete: () -> Void
    
    private let pages: [InfoPage] = [
        InfoPage(
            image: "person.fill.viewfinder",
            title: "Welcome to QUITTR",
            subtitle: "With over 1,000,000 users, QUITTR is class-leading and based on years of research and user-interaction",
            showBadges: true
        ),
        InfoPage(
            image: "brain.head.profile",
            title: "Rewire your brain",
            subtitle: "Science-backed exercises help you rewire your brain, rebuild your dopamine receptors, and avoid setbacks.",
            showBadges: true
        ),
        InfoPage(
            image: "shield.lefthalf.filled.badge.checkmark",
            title: "Avoid setbacks",
            subtitle: "QUITTR learns your habits and temptation triggers, providing you with 24/7 protection.",
            showBadges: true
        ),
        InfoPage(
            image: "figure.arms.open",
            title: "Conquer yourself",
            subtitle: "Know yourself to conquer yourself. Understand your strengths and weaknesses, earn medals, and track your progress.",
            showBadges: true
        ),
        InfoPage(
            image: "figure.wave",
            title: "Level up your life",
            subtitle: "Rebooting has immense psychological and physical benefits. Grow stronger, healthier, and happier.",
            showBadges: true
        ),
        InfoPage(
            image: "figure.mind.and.body",
            title: "Stay motivated",
            subtitle: "Quitting porn can be challenging. Your daily checkup keeps you motivated as you become your best self.",
            showBadges: true
        )
    ]
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.6, blue: 0.8),
                    Color(red: 0.1, green: 0.3, blue: 0.6)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            StarryBackgroundView()
            
            VStack {
                // Logo
                Text("QUITTR")
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                    .tracking(2)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                
                Spacer()
                
                TabView(selection: $currentPage) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                        VStack(spacing: 30) {
                            Image(systemName: page.image)
                                .font(.system(size: 80))
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.bottom, 20)
                            
                            Text(page.title)
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text(page.subtitle)
                                .font(.body)
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                            
                            if page.showBadges {
                                HStack(spacing: 40) {
                                    Text("Forbes")
                                        .font(.system(size: 24, weight: .bold, design: .serif))
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text("TECH\nTIMES")
                                        .font(.system(size: 14, weight: .bold))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text("LA WEEKLY")
                                        .font(.system(size: 16, weight: .black))
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                .padding(.top, 40)
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 600)
                
                // Page indicator
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.white : Color.white.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom, 20)
                
                // Next button
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    if currentPage < pages.count - 1 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        onComplete()
                    }
                }) {
                    HStack {
                        Text("Next")
                            .font(.headline)
                            .fontWeight(.bold)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.black)
                    .frame(width: 150)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(40)
                }
                .padding(.bottom, 40)
            }
        }
    }
}

// MARK: - Info Page Model

struct InfoPage {
    let image: String
    let title: String
    let subtitle: String
    let showBadges: Bool
}

