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
            // Starry background - covers entire screen including safe areas
            StarryBackgroundView()
            
            // Main scrollable content
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Top bar
                    topBar
                        .padding(.top, 10)
                    
                    if viewModel.pledgeState.isActive,
                       let hours = viewModel.pledgeState.hoursUntilCheckIn {
                        PledgeCheckInPill(hoursRemaining: hours)
                            .padding(.horizontal)
                            .transition(.opacity)
                    }
                    
                    // Streak orb
                    StreakOrbView(
                        currentTier: viewModel.streakState.currentTier,
                        nextTier: viewModel.streakState.nextTier,
                        currentDays: viewModel.streakState.currentStreakDays,
                        onTap: {
                            // Orb is non-interactive
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
                            viewModel.activeSheet = .meditation
                        },
                        onReset: {
                            viewModel.startRelapseFlow()
                        }
                    )
                    .padding(.vertical, 10)
                    
                    // Brain Rewiring progress (if user has pledged or has streak)
                    if viewModel.pledgeState.isActive || viewModel.streakState.currentStreakDays > 0 {
                        BrainRewiringCardView(progress: viewModel.brainRewiringProgress) {
                            NotificationCenter.default.post(name: .navigateToAnalytics, object: nil)
                        }
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
                    JournalCardView(entries: viewModel.journalEntries, onAddNew: {
                        viewModel.activeSheet = .journalAdd
                    }, onDelete: { entry in
                        viewModel.deleteJournalEntry(entry)
                    })
                    .padding(.top, 10)
                    
                    // Checklist card
                    ChecklistCardView(
                        items: $viewModel.checklistState.items,
                        onItemAction: viewModel.handleChecklistAction
                    )
                    .padding(.top, 10)
                    
                    // Why I'm Quitting card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Why I'm Quitting")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text(viewModel.quittingReason.text.isEmpty ? "Tap edit to write your deepest why." : viewModel.quittingReason.text)
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                            .lineLimit(4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Updated \(viewModel.quittingReason.lastUpdated.formatted(date: .abbreviated, time: .shortened))")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.6))
                        
                        Button {
                            viewModel.activeSheet = .quittingReason
                        } label: {
                            HStack {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.title3)
                                Text("Edit Reason")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.purple.opacity(0.6))
                            )
                        }
                    }
                    .padding()
                    .glassEffect()
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                }
                .padding(.bottom, 220)
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
        .overlay(alignment: .bottom) {
            PanicButtonView {
                viewModel.showPanicButton()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 96)
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
        case .urgeSupport:
            UrgeSupportView(viewModel: viewModel)
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
        case .meditation:
            MeditationView()
        }
    }
}

#Preview {
    HomeView()
}

