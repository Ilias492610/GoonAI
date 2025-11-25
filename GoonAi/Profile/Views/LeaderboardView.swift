//
//  LeaderboardView.swift
//  GoonAi
//
//  Full leaderboard view
//

import SwiftUI

struct LeaderboardView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button(action: { dismiss() }) {
                        GlassBackButton(action: { dismiss() })
                    }
                    
                    Spacer()
                    
                    Text("Leaderboard")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.refreshLeaderboard()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(viewModel.leaderboard) { entry in
                            LeaderboardRowView(entry: entry)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 100)
                }
            }
        }
    }
}

