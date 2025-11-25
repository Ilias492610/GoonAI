//
//  NoGoonEducationView.swift
//  GoonAi
//
//  Education slides about porn effects (matching QUITTR red/blue pages)
//

import SwiftUI

struct NoGoonEducationView: View {
    @State private var currentPage = 0
    let onComplete: () -> Void
    
    private let pages: [(image: String, title: String, subtitle: String, color: Color)] = [
        ("brain.head.profile", "Porn is a drug", "Using porn releases a chemical in the brain called dopamine. This chemical makes you feel good- it's why you feel pleasure when you watch porn.", Color(hex: "#D90429")),
        ("heart.slash.fill", "Porn destroys relationships", "Porn reduces your hunger for a real relationship and replaces it with the hunger for more porn.", Color(hex: "#D90429")),
        ("bolt.slash.fill", "Porn shatters sex drive", "More than 50% of porn addicts have reported a loss of interest in real sex, and an overall decrease in their sex drive.", Color(hex: "#D90429")),
        ("face.smiling.inverse", "Feeling unhappy?", "An elevated dopamine level means you need more dopamine to feel good. This is why so many heavy porn users report feeling depressed, unmotivated, and anti-social.", Color(hex: "#D90429")),
        ("leaf.fill", "Path to Recovery", "Recovery is possible. By abstaining from porn, your brain can reset its dopamine sensitivity, leading to healthier relationships and improved well-being.", Color(hex: "#023e8a"))
    ]
    
    var body: some View {
        ZStack {
            pages[currentPage].color
                .ignoresSafeArea()
            
            StarryBackgroundView()
                .opacity(0.3)
            
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
                            
                            Text(page.title)
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text(page.subtitle)
                                .font(.body)
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 500)
                
                Spacer()
                
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

