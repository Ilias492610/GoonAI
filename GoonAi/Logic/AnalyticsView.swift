import SwiftUI

struct AnalyticsView: View {
    @StateObject private var viewModel = AnalyticsViewModel()
    
    var body: some View {
        ZStack {
            // Starry background
            StarryBackgroundView()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Header
                    header
                        .padding(.top, 10)
                    
                    // Ring mode content
                    ringModeContent
                    
                    Spacer(minLength: 100)
                }
            }
        }
    }
    
    // MARK: - Header
    
    private var header: some View {
        HStack {
            Text("Analytics")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    // MARK: - Ring Mode Content
    
    private var ringModeContent: some View {
        VStack(spacing: 20) {
            // Recovery ring
            RecoveryRingCard(
                progress: viewModel.recoveryProgress,
                days: viewModel.currentStreakDays
            )
            .padding(.top, 20)
            
            // Streak stats (only current and highest)
            StreakStatsRowAnalytics(
                currentStreak: viewModel.currentStreakDays,
                highestStreak: viewModel.highestStreakDays
            )
            
            // Benefits list with progress bars
            BenefitsListView(benefits: viewModel.benefits)
        }
    }
}

#Preview {
    AnalyticsView()
}
