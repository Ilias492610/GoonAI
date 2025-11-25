//
//  ProfileViewModel.swift
//  GoonAi
//
//  ViewModel for Profile feature
//

import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var userProfile: UserProfile
    @Published var achievements: [Achievement]
    @Published var leaderboard: [LeaderboardEntry]
    @Published var referralData: ReferralData
    @Published var bestStreak: Int
    @Published var tilSober: Int
    @Published var currentStreak: Int
    @Published var currentLevel: Int
    
    // Notification settings
    @Published var notificationsEnabled: Bool = true
    @Published var featuredPostsEnabled: Bool = false
    @Published var allPostsEnabled: Bool = false
    
    // More settings
    @Published var fasterSplashScreen: Bool = false
    @Published var noNutNovemberDev: Bool = false
    
    // MARK: - Init
    
    init() {
        // Load from persistence or use defaults
        self.userProfile = UserProfile.placeholder
        self.achievements = Achievement.allAchievements
        self.leaderboard = LeaderboardEntry.mockLeaderboard
        self.referralData = ReferralData.placeholder
        
        // Mock stats (TODO: sync with HomeViewModel)
        self.bestStreak = 0
        self.tilSober = 90
        self.currentStreak = 0
        self.currentLevel = 1
        
        loadSettings()
    }
    
    // MARK: - Profile Management
    
    func updateProfile(_ updatedProfile: UserProfile) {
        self.userProfile = updatedProfile
        saveProfile()
    }
    
    func updateName(_ newName: String) {
        userProfile.name = newName
        saveProfile()
    }
    
    func updateAge(_ newAge: Int) {
        userProfile.age = newAge
        saveProfile()
    }
    
    func updateGender(_ newGender: String) {
        userProfile.gender = newGender
        saveProfile()
    }
    
    func updateOrientation(_ newOrientation: String) {
        userProfile.orientation = newOrientation
        saveProfile()
    }
    
    func updateEthnicity(_ newEthnicity: String) {
        userProfile.ethnicity = newEthnicity
        saveProfile()
    }
    
    func updateReligiousContent(_ newContent: String) {
        userProfile.religiousContent = newContent
        saveProfile()
    }
    
    func updateRegion(_ newRegion: String) {
        userProfile.region = newRegion
        saveProfile()
    }
    
    private func saveProfile() {
        // TODO: Save to backend (Supabase/Firebase)
        if let encoded = try? JSONEncoder().encode(userProfile) {
            UserDefaults.standard.set(encoded, forKey: "userProfile")
        }
    }
    
    private func loadProfile() {
        if let data = UserDefaults.standard.data(forKey: "userProfile"),
           let decoded = try? JSONDecoder().decode(UserProfile.self, from: data) {
            self.userProfile = decoded
        }
    }
    
    // MARK: - Achievements
    
    func unlockAchievement(for daysClean: Int) {
        for index in achievements.indices {
            if daysClean >= achievements[index].daysRequired && !achievements[index].isUnlocked {
                achievements[index].isUnlocked = true
                achievements[index].unlockedDate = Date()
            }
        }
    }
    
    // MARK: - Leaderboard
    
    func refreshLeaderboard() {
        // TODO: Fetch from backend
        print("Refreshing leaderboard...")
    }
    
    // MARK: - Referral
    
    func copyPromoCode() {
        UIPasteboard.general.string = referralData.promoCode
    }
    
    func shareReferral() {
        let shareText = "Join me on NoGoon! Use my code: \(referralData.promoCode) for a 30-day Guest Pass"
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
    
    // MARK: - Settings
    
    func toggleNotifications() {
        notificationsEnabled.toggle()
        saveSettings()
        // TODO: Update notification permissions
    }
    
    func toggleFeaturedPosts() {
        featuredPostsEnabled.toggle()
        saveSettings()
    }
    
    func toggleAllPosts() {
        allPostsEnabled.toggle()
        saveSettings()
    }
    
    func clearAllNotifications() {
        // TODO: Clear in-app notification center
        print("Clearing all notifications...")
    }
    
    func toggleFasterSplashScreen() {
        fasterSplashScreen.toggle()
        saveSettings()
    }
    
    func toggleNoNutNovemberDev() {
        noNutNovemberDev.toggle()
        saveSettings()
    }
    
    private func saveSettings() {
        UserDefaults.standard.set(notificationsEnabled, forKey: "notificationsEnabled")
        UserDefaults.standard.set(featuredPostsEnabled, forKey: "featuredPostsEnabled")
        UserDefaults.standard.set(allPostsEnabled, forKey: "allPostsEnabled")
        UserDefaults.standard.set(fasterSplashScreen, forKey: "fasterSplashScreen")
        UserDefaults.standard.set(noNutNovemberDev, forKey: "noNutNovemberDev")
    }
    
    private func loadSettings() {
        notificationsEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")
        featuredPostsEnabled = UserDefaults.standard.bool(forKey: "featuredPostsEnabled")
        allPostsEnabled = UserDefaults.standard.bool(forKey: "allPostsEnabled")
        fasterSplashScreen = UserDefaults.standard.bool(forKey: "fasterSplashScreen")
        noNutNovemberDev = UserDefaults.standard.bool(forKey: "noNutNovemberDev")
    }
    
    // MARK: - Actions
    
    func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
    func rateApp() {
        // TODO: Open App Store rating
        print("Opening App Store for rating...")
    }
    
    func submitFeedback(_ feedback: String) {
        // TODO: Submit to backend
        print("Submitting feedback: \(feedback)")
    }
    
    func deleteProfile() {
        // TODO: Show confirmation alert + delete from backend
        print("Deleting profile...")
    }
    
    func logout() {
        // TODO: Clear session + navigate to onboarding
        print("Logging out...")
    }
}

