//
//  HomeView.swift
//  GoonAi
//
//  NoGoon Home Screen - Main Feature
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            // Starry background
            StarryBackgroundView()
            
            // Main scrollable content
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Top bar
                    topBar
                        .padding(.top, 10)
                    
                    // Streak orb
                    StreakOrbView(
                        currentTier: viewModel.streakState.currentTier,
                        nextTier: viewModel.streakState.nextTier,
                        currentDays: viewModel.streakState.currentStreakDays,
                        onTap: {
                            viewModel.showStreakOptions()
                        }
                    )
                    .padding(.top, 20)
                    
                    // Stats row
                    StreakStatsRow(
                        relapseCount: viewModel.streakState.relapseCount,
                        pornFreeTime: viewModel.formattedPornFreeTime,
                        daysUntilGoal: viewModel.formattedDaysUntilGoal
                    )
                    .padding(.vertical, 10)
                    
                    // Action buttons row
                    HomeActionRow(
                        pledgeActive: viewModel.pledgeState.isActive,
                        onPledge: {
                            if !viewModel.pledgeState.isActive {
                                viewModel.activeSheet = .pledge
                            }
                        },
                        onMeditate: {
                            // TODO: Navigate to meditation feature
                        },
                        onReset: {
                            viewModel.startRelapseFlow()
                        },
                        onMelius: {
                            // TODO: Navigate to Melius feature
                        }
                    )
                    .padding(.vertical, 10)
                    
                    // Brain Rewiring progress (if user has pledged or has streak)
                    if viewModel.pledgeState.isActive || viewModel.streakState.currentStreakDays > 0 {
                        BrainRewiringCardView(progress: viewModel.brainRewiringProgress)
                            .padding(.top, 10)
                    }
                    
                    // Motivational quote
                    QuoteCardView(quote: viewModel.quoteOfDay)
                        .padding(.top, 10)
                    
                    // Content Blocker card
                    ContentBlockerCardView {
                        viewModel.activeSheet = .contentBlocker
                    }
                    .padding(.top, 10)
                    
                    // Journal card
                    JournalCardView {
                        viewModel.activeSheet = .journalAdd
                    }
                    .padding(.top, 10)
                    
                    // Checklist card
                    ChecklistCardView(
                        items: $viewModel.checklistState.items,
                        onItemAction: viewModel.handleChecklistAction
                    )
                    .padding(.top, 10)
                    
                    // Panic Button
                    PanicButtonView {
                        viewModel.showPanicButton()
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 100) // Space for tab bar
                }
            }
            
            // Pledge check-in pill overlay (if active)
            if viewModel.pledgeState.isActive,
               let hours = viewModel.pledgeState.hoursUntilCheckIn {
                VStack {
                    PledgeCheckInPill(hoursRemaining: hours)
                        .padding(.top, 70)
                    Spacer()
                }
            }
        }
        .sheet(item: $viewModel.activeSheet) { sheetType in
            sheetContent(for: sheetType)
        }
        .alert("Edit Streak Date Warning", isPresented: $viewModel.showStreakWarning) {
            Button("Cancel", role: .cancel) {
                viewModel.showStreakWarning = false
            }
            Button("Continue", role: .destructive) {
                // Handle date editing
                viewModel.showStreakWarning = false
            }
        } message: {
            Text("Editing your streak date will exclude you from leaderboards. Your progress will still be tracked, but you won't appear in community rankings.")
        }
        .fullScreenCover(isPresented: $viewModel.showTierUnlock) {
            TierUnlockView(
                tier: viewModel.streakState.currentTier,
                days: viewModel.streakState.currentStreakDays
            ) {
                viewModel.showTierUnlock = false
            }
        }
    }
    
    // MARK: - Top Bar
    
    private var topBar: some View {
        HStack {
            // NoGoon logo/wordmark (left)
            Text("NOGOON")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .tracking(2)
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    // MARK: - Sheet Content
    
    @ViewBuilder
    private func sheetContent(for type: HomeSheetType) -> some View {
        switch type {
        case .streakOptions:
            StreakOptionsView(viewModel: viewModel)
        case .pledge:
            PledgeView(viewModel: viewModel)
        case .pledgeConfirmation:
            PledgeConfirmationView(viewModel: viewModel)
        case .relapseReflection:
            RelapseReflectionView(viewModel: viewModel)
        case .relapseResult:
            RelapseResultView(viewModel: viewModel)
        case .relapseCheckIn:
            RelapseCheckInView(viewModel: viewModel)
        case .relapseFeeling:
            RelapseFeelingView(viewModel: viewModel)
        case .relapseCommunityStats:
            RelapseCommunityStatsView(viewModel: viewModel)
        case .journalAdd:
            AddNoteView(viewModel: viewModel)
        case .quittingReason:
            QuittingReasonView(viewModel: viewModel)
        case .dailyCheckIn:
            DailyCheckInView(viewModel: viewModel)
        case .contentBlocker:
            ContentBlockerView()
        case .panicButton:
            PanicButtonFullView(viewModel: viewModel)
        }
    }
}

#Preview {
    HomeView()
}
