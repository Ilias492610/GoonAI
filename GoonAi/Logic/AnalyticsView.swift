import SwiftUI

struct AnalyticsView: View {
    @StateObject private var viewModel = AnalyticsViewModel()
    
    var body: some View {
        ZStack {
            // Starry background
            StarryBackgroundView()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Header with mode toggle
                    header
                        .padding(.top, 10)
                    
                    // Content based on selected mode
                    if viewModel.mode == .ring {
                        ringModeContent
                    } else {
                        radarModeContent
                    }
                    
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
            
            // Mode toggle
            HStack(spacing: 0) {
                ForEach(AnalyticsMode.allCases, id: \.self) { mode in
                    Button {
                        viewModel.mode = mode
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    } label: {
                        Text(mode.rawValue)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(viewModel.mode == mode ? .white : .white.opacity(0.6))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(viewModel.mode == mode ? Color.white.opacity(0.2) : Color.clear)
                            )
                    }
                }
            }
            .background(
                Capsule()
                    .fill(.ultraThinMaterial)
            )
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
            
            // Quit date
            QuitDateCard(date: viewModel.quitDateFormatted)
            
            // Level progress
            LevelProgressCard(level: viewModel.currentLevel)
            
            // Streak stats
            StreakStatsRowAnalytics(
                currentStreak: viewModel.currentStreakDays,
                highestStreak: viewModel.highestStreakDays,
                completedActivities: viewModel.completedDailyActivities,
                totalActivities: viewModel.totalDailyActivities
            )
            
            // Benefits list
            BenefitsListView(benefits: viewModel.benefits)
        }
    }
    
    // MARK: - Radar Mode Content
    
    private var radarModeContent: some View {
        VStack(spacing: 20) {
            // Radar chart
            RecoveryRadarCard(
                dimensions: viewModel.dimensionStats,
                selectedDimension: viewModel.selectedDimension
            )
            .padding(.top, 20)
            
            // Quit date
            QuitDateCard(date: viewModel.quitDateFormatted)
            
            // Overall progress chart
            OverallProgressChart(
                progressHistory: viewModel.progressHistory,
                firstLoginDate: viewModel.firstLoginFormatted
            )
            
            // Dimension stats grid
            DimensionStatsGrid(
                dimensions: viewModel.dimensionStats,
                selectedDimension: viewModel.selectedDimension,
                onSelect: { dimension in
                    viewModel.selectDimension(dimension)
                }
            )
        }
    }
}

#Preview {
    AnalyticsView()
}
