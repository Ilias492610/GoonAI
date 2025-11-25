//
//  PaywallView.swift
//  Cal AI
//
//  Created by Alex Slater on 19/8/25.
//

import SwiftUI
#if canImport(SuperwallKit)
import SuperwallKit
#endif

struct PaywallView: View {
    @AppStorage("name") private var userName: String = ""
    @AppStorage("age") private var userAge: Int = 0
    let onComplete: () -> Void
    
    var body: some View {
        ZStack {
            // Dark gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.05, green: 0.1, blue: 0.2),
                    Color(red: 0.1, green: 0.15, blue: 0.3)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        // QUITTR Logo
                        Text("QUITTR")
                            .font(.system(size: 28, weight: .heavy, design: .rounded))
                            .foregroundColor(.white)
                            .tracking(3)
                            .padding(.top, 60)
                        
                        // Success check
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60)
                            .foregroundColor(.green)
                        
                        // Title
                        Text("\(userName.isEmpty ? "Your" : "\(userName), your") custom plan is ready.")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                        
                        // Subtitle
                        Text("You will quit porn by:")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.8))
                        
                        // Date pill
                        Text(quitDate())
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(
                                Capsule().fill(Color.white.opacity(0.2))
                            )
                            .foregroundColor(.white)
                        
                        // Discount/Price section
                        DiscountView()
                        
                        // Benefits grid
                        VStack(spacing: 20) {
                            Text("Your personalized recovery plan includes:")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top, 20)
                            
                            PaywallBenefitRow(icon: "calendar.badge.checkmark", title: "90-day reboot program", subtitle: "Structured daily guidance")
                            PaywallBenefitRow(icon: "brain.head.profile", title: "Dopamine reset", subtitle: "Rewire your reward system")
                            PaywallBenefitRow(icon: "figure.mind.and.body", title: "Mindfulness tools", subtitle: "Meditation & breathing exercises")
                            PaywallBenefitRow(icon: "chart.line.uptrend.xyaxis", title: "Progress tracking", subtitle: "See your growth daily")
                            PaywallBenefitRow(icon: "person.3.fill", title: "Community support", subtitle: "Connect with others")
                            PaywallBenefitRow(icon: "shield.checkered", title: "Accountability", subtitle: "Daily pledges & check-ins")
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer().frame(height: 120)
                    }
                    .padding(.bottom, 40)
                }
                .onAppear {
                    // Save onboarded status when view appears
                    PersistanceManager.shared.saveFile(.onboarded, value: true)
                    scheduleNotification()
                }
                
                // Bottom button
                Button {
                    // TESTING: Bypass paywall - Comment out this block and uncomment the code below to restore paywall logic
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    let view = MainTabView()
                    NavigationManager.shared.presentView(view)
                    
                    // TODO: Uncomment below and remove the testing code above to restore original paywall behavior
                    /*
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    PersistanceManager.shared.saveFile(.onboarded, value: true)
                    scheduleNotification()
                    onComplete()
                    */
                } label: {
                    Text("Let's get started!")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
        }
    }
    
    private func quitDate() -> String {
        let calendar = Calendar.current
        let futureDate = calendar.date(byAdding: .day, value: 90, to: Date()) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: futureDate)
    }
    
    private func scheduleNotification() {
        PersistanceManager.shared.saveFile(.sentDiscountNoti, value: true)
        let content = UNMutableNotificationContent()
        content.title = "\(userName.isEmpty ? "Don't give up" : "\(userName), we didn't give up on you.")"
        content.body = "🎁⏳ Limited time offer: Get 80% off QUITTR Premium and break free from porn addiction."
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 300, repeats: false) // 5 minutes
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
}

// MARK: - Benefit Row

struct PaywallBenefitRow: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.cyan)
                .frame(width: 40, height: 40)
                .background(
                    Circle().fill(Color.white.opacity(0.1))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.05))
        )
    }
}

