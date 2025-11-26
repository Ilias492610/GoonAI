//
//  ProfileView.swift
//  GoonAi
//
//  Main Profile screen
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showEditProfile = false
    @State private var showSettings = false
    @State private var showShareSheet = false
    @State private var showAchievements = false
    @State private var showLeaderboard = false
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Header
                    profileHeader
                        .padding(.top, 60)
                    
                    // Achievement Badges Row
                    achievementBadgesRow
                    
                    // Stats Card
                    ProfileStatsCard(
                        bestStreak: viewModel.bestStreak,
                        tilSober: viewModel.tilSober,
                        currentStreak: viewModel.currentStreak,
                        currentLevel: viewModel.currentLevel
                    )
                    .padding(.horizontal, 20)
                    
                    // Leaderboard Preview (Coming Soon)
                    leaderboardComingSoonSection
                    
                    Spacer(minLength: 100)
                }
            }
            .ignoresSafeArea(edges: .top)
            
            // Top buttons overlay
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: { showShareSheet = true }) {
                        ZStack {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 44, height: 44)
                            
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Button(action: { showSettings = true }) {
                        ZStack {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 44, height: 44)
                            
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)
                
                Spacer()
            }
        }
        .sheet(isPresented: $showEditProfile) {
            EditProfileView(viewModel: viewModel)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(viewModel: viewModel)
        }
        .sheet(isPresented: $showShareSheet) {
            ShareProgressView(viewModel: viewModel)
        }
        .sheet(isPresented: $showAchievements) {
            AchievementsView(viewModel: viewModel)
        }
        .sheet(isPresented: $showLeaderboard) {
            LeaderboardView(viewModel: viewModel)
        }
    }
    
    // MARK: - Profile Header
    
    private var profileHeader: some View {
        VStack(spacing: 16) {
            // Avatar
            Circle()
                .fill(Color.white.opacity(0.2))
                .frame(width: 100, height: 100)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.white.opacity(0.6))
                )
            
            // Name
            Text(viewModel.userProfile.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // Edit Profile Button
            Button(action: { showEditProfile = true }) {
                HStack(spacing: 6) {
                    Image(systemName: "pencil")
                        .font(.system(size: 14))
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                .foregroundColor(.white.opacity(0.9))
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        .background(Capsule().fill(Color.white.opacity(0.1)))
                )
            }
        }
    }
    
    // MARK: - Achievement Badges Row
    
    private var achievementBadgesRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(viewModel.achievements.prefix(9)) { achievement in
                    Button(action: { showAchievements = true }) {
                        AchievementBadgeView(achievement: achievement)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Leaderboard Coming Soon Section
    
    private var leaderboardComingSoonSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Leaderboard")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            ZStack {
                // Blurred background content
                VStack(spacing: 12) {
                    ForEach(viewModel.leaderboard.prefix(3)) { entry in
                        LeaderboardRowView(entry: entry)
                            .padding(.horizontal, 20)
                    }
                }
                .padding(.vertical, 16)
                .blur(radius: 8)
                
                // Coming Soon overlay
                VStack(spacing: 12) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.cyan)
                    
                    Text("Available Soon")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Leaderboard coming in the next update")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
                .padding(30)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.black.opacity(0.6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(Color.cyan.opacity(0.3), lineWidth: 2)
                        )
                )
            }
            .glassEffect(cornerRadius: 24, opacity: 0.15)
            .padding(.horizontal, 20)
        }
    }
}

