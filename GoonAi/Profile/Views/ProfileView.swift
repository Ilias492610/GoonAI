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
    @State private var showReferral = false
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
                    
                    // Leaderboard Preview
                    leaderboardSection
                    
                    // Referral CTA
                    referralCard
                    
                    Spacer(minLength: 100)
                }
            }
            .ignoresSafeArea(edges: .top)
            
            // Top buttons overlay
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: { showReferral = true }) {
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
        .sheet(isPresented: $showReferral) {
            ReferralView(viewModel: viewModel)
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
    
    // MARK: - Leaderboard Section
    
    private var leaderboardSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Leaderboard")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: { showLeaderboard = true }) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            .padding(.horizontal, 20)
            
            VStack(spacing: 12) {
                ForEach(viewModel.leaderboard.prefix(3)) { entry in
                    LeaderboardRowView(entry: entry)
                        .padding(.horizontal, 20)
                }
            }
            .padding(.vertical, 16)
            .glassEffect(cornerRadius: 24, opacity: 0.15)
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Referral Card
    
    private var referralCard: some View {
        VStack(spacing: 16) {
            Text("Share NoGoon and get rewards")
                .font(.headline)
                .foregroundColor(.white)
            
            Button(action: { showReferral = true }) {
                HStack(spacing: 8) {
                    Text("30-days Guest Pass")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [.purple, .blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
            }
            
            Button(action: { showReferral = true }) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 18))
                    Text("Share Now")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white.opacity(0.2))
                )
            }
        }
        .padding(20)
        .glassEffect(cornerRadius: 24, opacity: 0.2)
        .padding(.horizontal, 20)
    }
}

