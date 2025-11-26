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
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                    
                    Spacer()
                    
                    Text("Relapsed")
                        .font(.headline)
                        .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.25))
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 12)
                .background(
                    Rectangle()
                        .fill(Color.white.opacity(0.05))
                )
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // Main heading
                        Text("You let yourself down, again.")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                            .padding(.top, 24)
                        
                        // Paragraph
                        Text("Relapsing can be tough and make you feel awful, but it's crucial not to be too hard on yourself. Doing so can create a vicious cycle, as explained below.")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 0.71, green: 0.73, blue: 0.8))
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                            .padding(.horizontal, 30)
                        
                        // Section heading
                        Text("Relapsing Cycle of Death")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 30)
                            .padding(.top, 20)
                        
                        // Cycle items
                        VStack(spacing: 16) {
                            CycleItemView(
                                icon: "arrow.clockwise",
                                title: "Jerking Off",
                                description: "In the moment and during orgasm, you feel incredible"
                            )
                            
                            CycleItemView(
                                icon: "xmark.circle",
                                title: "Post Nut-Clarity",
                                description: "Shortly after finishing, the euphoria fades, leaving you with regret, sadness and depression."
                            )
                            
                            CycleItemView(
                                icon: "repeat",
                                title: "Compensation Cycle",
                                description: "You masturbate again to alleviate the low feelings, perpetuating the cycle. If you don't stop, it becomes increasingly difficult to break free."
                            )
                        }
                        .padding(.horizontal, 20)
                        
                        // Motivation container
                        VStack(spacing: 16) {
                            Text("Embrace the challenge of quitting porn as a journey to self-improvement")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                            
                            Text("You got this, the NoGoon team believes in you ❤️")
                                .font(.system(size: 16))
                                .foregroundColor(Color(red: 0.39, green: 0.71, blue: 0.96))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 40)
                        .padding(.bottom, 100)
                    }
                }
                
                Spacer()
            }
            
            // Fixed bottom button
            VStack {
                Spacer()
                Button {
                    viewModel.finishRelapseFlow(shouldReset: true)
                    dismiss()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 20))
                        Text("Reset Counter")
                            .font(.system(size: 16, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        Rectangle()
                            .fill(Color(red: 0.82, green: 0.0, blue: 0.21))
                    )
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

// Cycle item component
struct CycleItemView: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(Color(red: 0.56, green: 0.45, blue: 0.84))
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.71, green: 0.73, blue: 0.8))
                    .lineSpacing(2)
            }
            
            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.12, green: 0.13, blue: 0.26))
        )
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

// MARK: - Urge Support View

struct UrgeSupportView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var pulseScale: CGFloat = 1.0
    @State private var currentQuote: String = ""
    
    let quotes = [
        "Every time you resist, you build strength that lasts a lifetime.",
        "This moment of discomfort is temporary, but your achievement will endure.",
        "You are rewiring your brain with every victory over temptation.",
        "Freedom comes from the choices you make right now.",
        "Remember why you started. Your future self will thank you."
    ]
    
    let emergencyActions = [
        ("figure.walk", "Take a Walk", "Get outside for 10 minutes to break the pattern"),
        ("drop.fill", "Drink Water", "Hydration can help reduce cravings"),
        ("phone.fill", "Call Someone", "Connect with a friend or family member"),
        ("wind", "Deep Breathing", "10 slow breaths to center yourself")
    ]
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                    
                    Spacer()
                    
                    Text("EMERGENCY SUPPORT")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // Pulse alert
                        HStack(spacing: 10) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(Color(red: 0.91, green: 0.12, blue: 0.39))
                            Text("URGE ALERT")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color(red: 0.91, green: 0.12, blue: 0.39))
                        }
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.91, green: 0.12, blue: 0.39).opacity(0.15))
                        )
                        .scaleEffect(pulseScale)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        // Main message
                        VStack(alignment: .leading, spacing: 8) {
                            Text("This feeling is temporary.")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                            Text("Your progress is permanent.")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        
                        // Quote card
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "quote.opening")
                                .font(.system(size: 24))
                                .foregroundColor(Color(red: 0.3, green: 0.71, blue: 0.67))
                            
                            Text(currentQuote)
                                .font(.system(size: 18))
                                .italic()
                                .foregroundColor(.white)
                                .lineSpacing(4)
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 0.12, green: 0.13, blue: 0.26).opacity(0.8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 0.3, green: 0.71, blue: 0.67), lineWidth: 0)
                                        .padding(.leading, -4)
                                        .overlay(
                                            Rectangle()
                                                .fill(Color(red: 0.3, green: 0.71, blue: 0.67))
                                                .frame(width: 4)
                                                .padding(.trailing, 999)
                                        )
                                )
                        )
                        .padding(.horizontal, 20)
                        
                        // Section title
                        Text("Do these immediately:")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0.88, green: 0.88, blue: 0.88))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.top, 8)
                        
                        // Emergency actions grid
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(emergencyActions, id: \.0) { action in
                                EmergencyActionCard(
                                    icon: action.0,
                                    title: action.1,
                                    description: action.2
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Remember section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Remember:")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                            
                            Text("The brain's reward system tricks you into thinking porn will make you feel better. It's a trap that will leave you feeling worse afterward.")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .lineSpacing(4)
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 0.12, green: 0.13, blue: 0.26).opacity(0.6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.clear, lineWidth: 0)
                                        .padding(.leading, -4)
                                        .overlay(
                                            Rectangle()
                                                .fill(Color(red: 1.0, green: 0.6, blue: 0.0))
                                                .frame(width: 4)
                                                .padding(.trailing, 999)
                                        )
                                )
                        )
                        .padding(.horizontal, 20)
                        .padding(.bottom, 120)
                    }
                }
            }
            
            // Fixed bottom buttons
            VStack(spacing: 12) {
                HStack(spacing: 10) {
                    Button {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            viewModel.activeSheet = .meditation
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 20))
                            Text("Meditate")
                                .font(.system(size: 16, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.25, green: 0.32, blue: 0.71))
                        )
                    }
                    
                    Button {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            // Navigate to community chat
                            NotificationCenter.default.post(name: Notification.Name("navigateToCommunity"), object: nil)
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "bubble.left.and.bubble.right.fill")
                                .font(.system(size: 20))
                            Text("Talk in Chat")
                                .font(.system(size: 16, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.27, green: 0.35, blue: 0.39))
                        )
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .onAppear {
            currentQuote = quotes.randomElement() ?? quotes[0]
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                pulseScale = 1.05
            }
        }
    }
}

struct EmergencyActionCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundColor(Color(red: 0.39, green: 0.71, blue: 0.96))
            
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
            
            Text(description)
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.69, green: 0.74, blue: 0.77))
                .lineSpacing(2)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.12, green: 0.13, blue: 0.26).opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(red: 0.39, green: 0.71, blue: 0.96).opacity(0.2), lineWidth: 1)
                )
        )
    }
}
