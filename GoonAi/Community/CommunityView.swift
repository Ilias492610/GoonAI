//
//  CommunityView.swift
//  GoonAi
//
//  Community tab - Discord CTA
//

import SwiftUI

struct CommunityView: View {
    @StateObject private var viewModel = CommunityViewModel()
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Motivational Text
                VStack(spacing: 16) {
                    Text("You're Not Alone")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Join the NoGoon community and grow with others. Connect, share, and stay accountable.")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                // Discord CTA Card
                VStack(spacing: 24) {
                    // Discord Icon
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 0.7, green: 0.5, blue: 1.0), Color(red: 0.5, green: 0.3, blue: 0.9)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 80, height: 80)
                            .shadow(color: Color(red: 0.6, green: 0.4, blue: 1.0).opacity(0.5), radius: 20, x: 0, y: 10)
                        
                        Image(systemName: "message.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    
                    VStack(spacing: 8) {
                        Text("Join Our Community")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Tap to join the NoGoon Discord")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    
                    // Join Button
                    Button(action: {
                        viewModel.openDiscord()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.system(size: 20))
                            Text("Join Community")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [Color(red: 0.7, green: 0.5, blue: 1.0), Color(red: 0.5, green: 0.3, blue: 0.9)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .shadow(color: Color(red: 0.6, green: 0.4, blue: 1.0).opacity(0.4), radius: 15, x: 0, y: 8)
                        )
                    }
                }
                .padding(32)
                .glassEffect(cornerRadius: 30, opacity: 0.2)
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}

