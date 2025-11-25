//
//  RelapseViews.swift
//  GoonAi
//
//  Relapse flow views
//

import SwiftUI

// MARK: - Relapse Reflection

struct RelapseReflectionView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Circle().fill(.ultraThinMaterial))
                    }
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                VStack(spacing: 30) {
                    Text("REFLECT AND BREATHE")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                        .tracking(2)
                    
                    Text("You're building a legacy with every choice you make.")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                    Text("This is a step toward the person you want to become.")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                
                Button {
                    viewModel.continueRelapseFlow()
                } label: {
                    Text("Finish Reflecting")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                        )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
    }
}

// MARK: - Relapse Result

struct RelapseResultView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            ScrollView {
                VStack(spacing: 30) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title3)
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Circle().fill(.ultraThinMaterial))
                        }
                        Spacer()
                    }
                    .padding()
                    
                    Text("Relapsed")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .padding(.top, 40)
                    
                    VStack(spacing: 16) {
                        Text("Don't worry about it")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Slip-ups happen and can make you feel bad, but it's crucial not to be too hard on yourself. You're getting closer to freedom.")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    .padding(.top, 20)
                    
                    // Journal button
                    Button {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            viewModel.activeSheet = .journalAdd
                        }
                    } label: {
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text("Journal Feelings")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .glassEffect()
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 30)
                    
                    // Motivational text
                    Text("Embrace the challenge of overcoming addiction; it makes you stronger and more resilient. Each setback is a learning opportunity, shaping you into a better version of yourself.")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.top, 30)
                    
                    Spacer(minLength: 50)
                    
                    // Reset counter button
                    Button {
                        viewModel.finishRelapseFlow(shouldReset: true)
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Reset Counter")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.red)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

// MARK: - Relapse Check-In

struct RelapseCheckInView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                Spacer()
                
                VStack(spacing: 30) {
                    Text("👀")
                        .font(.system(size: 60))
                    
                    Text("Did you relapse? Let the community know by checking in.")
                        .font(.title3)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    Text("22,853")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("are still going strong")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Text("No, still going strong")
                            Text("💪")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.blue)
                        )
                    }
                    
                    Button {
                        viewModel.confirmRelapse()
                    } label: {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                            Text("Yes, I relapsed")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.red)
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
    }
}

// MARK: - Relapse Feeling Selection

struct RelapseFeelingView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 40) {
                Spacer()
                
                Text("And how are you feeling?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                VStack(spacing: 20) {
                    FeelingButton(
                        emoji: "😊",
                        gradient: [Color.green, Color.cyan]
                    ) {
                        viewModel.selectRelapseFeeling(.happy)
                    }
                    
                    FeelingButton(
                        emoji: "😐",
                        gradient: [Color.yellow, Color.orange]
                    ) {
                        viewModel.selectRelapseFeeling(.neutral)
                    }
                    
                    FeelingButton(
                        emoji: "😔",
                        gradient: [Color.pink, Color.red]
                    ) {
                        viewModel.selectRelapseFeeling(.sad)
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
        }
    }
}

struct FeelingButton: View {
    let emoji: String
    let gradient: [Color]
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(emoji)
                .font(.system(size: 60))
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: gradient,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
        }
    }
}

// MARK: - Community Stats

struct RelapseCommunityStatsView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 30) {
                Spacer()
                
                Text("NoGoon believes in you, never give up. 👑")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                VStack(spacing: 16) {
                    StatRow(emoji: "😊", count: "21196 others")
                    StatRow(emoji: "😐", count: "886 others")
                    StatRow(emoji: "😔", count: "2918 others")
                }
                .padding(.horizontal, 40)
                
                Text("This is hard but believe in yourself. You're not alone.")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                
                VStack(spacing: 12) {
                    Button {
                        // Reflect action
                    } label: {
                        HStack {
                            Image(systemName: "sparkles")
                            Text("Reflect")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.blue)
                        )
                    }
                    
                    Button {
                        viewModel.finishRelapseFlow(shouldReset: false)
                        dismiss()
                    } label: {
                        Text("Finish")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
    }
}

struct StatRow: View {
    let emoji: String
    let count: String
    
    var body: some View {
        HStack {
            Text(emoji)
                .font(.largeTitle)
            Text(count)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

