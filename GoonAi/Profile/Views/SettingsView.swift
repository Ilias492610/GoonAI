//
//  SettingsView.swift
//  GoonAi
//
//  Settings screen with navigation to sub-screens
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @ObservedObject var viewModel: ProfileViewModel
    
    @State private var showEditProfile = false
    @State private var showNotifications = false
    @State private var showSupport = false
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Spacer()
                    
                    Text("Settings")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .overlay(
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    },
                    alignment: .leading
                )
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 4) {
                        SettingsRow(icon: "person.circle.fill", iconColor: .cyan, title: "Profile") {
                            showEditProfile = true
                        }
                        
                        Divider().background(Color.white.opacity(0.2))
                        
                        SettingsRow(icon: "bell.fill", iconColor: .red, title: "Notifications") {
                            showNotifications = true
                        }
                        
                        Divider().background(Color.white.opacity(0.2))
                        
                        SettingsRow(icon: "questionmark.circle.fill", iconColor: .purple, title: "Support") {
                            showSupport = true
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
        }
        .sheet(isPresented: $showEditProfile) {
            EditProfileView(viewModel: viewModel)
        }
        .sheet(isPresented: $showNotifications) {
            NotificationsView(viewModel: viewModel)
        }
        .sheet(isPresented: $showSupport) {
            SupportView(viewModel: viewModel)
        }
    }
}

// MARK: - Notifications View

struct NotificationsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Spacer()
                    
                    Text("Notifications")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .overlay(
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    },
                    alignment: .leading
                )
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Push Notifications Section
                        Text("Push Notifications")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        VStack(spacing: 4) {
                            SettingsToggleRow(title: "Enable notifications", isOn: $viewModel.notificationsEnabled)
                            
                            Divider().background(Color.white.opacity(0.2))
                            
                            SettingsToggleRow(title: "Featured Posts", isOn: $viewModel.featuredPostsEnabled)
                            
                            Divider().background(Color.white.opacity(0.2))
                            
                            SettingsToggleRow(title: "All Posts", isOn: $viewModel.allPostsEnabled)
                        }
                        
                        // In-App Notifications Section
                        Text("In-App Notifications")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        Button(action: {
                            viewModel.clearAllNotifications()
                        }) {
                            HStack {
                                Image(systemName: "trash.fill")
                                    .font(.system(size: 18))
                                Text("Clear All Notifications")
                                    .font(.headline)
                            }
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(Color.red.opacity(0.5), lineWidth: 2)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .fill(Color.red.opacity(0.1))
                                    )
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
        }
    }
}

// MARK: - Support View

struct SupportView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Spacer()
                    
                    Text("Support")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .overlay(
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    },
                    alignment: .leading
                )
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                VStack(spacing: 4) {
                    Button(action: {
                        if let url = URL(string: "mailto:info@nogooon.com?subject=Bug%20Report") {
                            openURL(url)
                        }
                    }) {
                        HStack {
                            Text("Report a bug")
                                .font(.body)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.vertical, 16)
                    }
                    
                    Divider().background(Color.white.opacity(0.2))
                    
                    Button(action: {
                        if let url = URL(string: "https://goonaiapp.com/#faq") {
                            openURL(url)
                        }
                    }) {
                        HStack {
                            Text("FAQ")
                                .font(.body)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.vertical, 16)
                    }
                    
                    Divider().background(Color.white.opacity(0.2))
                    
                    Button(action: {
                        if let url = URL(string: "mailto:info@nogooon.com?subject=Contact%20Us") {
                            openURL(url)
                        }
                    }) {
                        HStack {
                            Text("Contact us")
                                .font(.body)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.vertical, 16)
                    }
                    
                    Divider().background(Color.white.opacity(0.2))
                    
                    Button(action: {
                        if let url = URL(string: "mailto:info@nogooon.com?subject=Feedback") {
                            openURL(url)
                        }
                    }) {
                        HStack {
                            Text("Give Feedback")
                                .font(.body)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.vertical, 16)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
            }
        }
    }
}

// MARK: - Feedback View

struct FeedbackView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    @State private var feedbackText = ""
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button(action: { dismiss() }) {
                        GlassBackButton(action: { dismiss() })
                    }
                    
                    Spacer()
                    
                    Text("Feedback")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                VStack(spacing: 24) {
                    // Text Editor
                    TextEditor(text: $feedbackText)
                        .frame(height: 300)
                        .padding(16)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(16)
                        .foregroundColor(.white)
                        .scrollContentBackground(.hidden)
                        .overlay(
                            Group {
                                if feedbackText.isEmpty {
                                    Text("Please give us some good feedback so we can make NoGoon better for everyone...")
                                        .foregroundColor(.white.opacity(0.5))
                                        .padding(.top, 24)
                                        .padding(.leading, 20)
                                        .allowsHitTesting(false)
                                }
                            },
                            alignment: .topLeading
                        )
                    
                    // Info text
                    Text("Useful and informative feedback will get a chance to win up to $100.")
                        .font(.subheadline)
                        .foregroundColor(.cyan)
                        .multilineTextAlignment(.center)
                    
                    // Submit Button
                    Button(action: {
                        viewModel.submitFeedback(feedbackText)
                        dismiss()
                    }) {
                        Text("Submit Feedback")
                            .font(.headline)
                            .foregroundColor(.white.opacity(feedbackText.isEmpty ? 0.5 : 1.0))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .fill(Color.white.opacity(feedbackText.isEmpty ? 0.1 : 0.2))
                            )
                    }
                    .disabled(feedbackText.isEmpty)
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)
                
                Spacer()
            }
        }
    }
}

// MARK: - Contact Us View

struct ContactUsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        GlassBackButton(action: { dismiss() })
                    }
                    
                    Spacer()
                    
                    Text("Contact Us")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
                
                Text("support@nogoon.app")
                    .font(.title3)
                    .foregroundColor(.cyan)
                
                Spacer()
            }
        }
    }
}

// MARK: - Earn View

struct EarnView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button(action: { dismiss() }) {
                        GlassBackButton(action: { dismiss() })
                    }
                    
                    Spacer()
                    
                    Text("Earn")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                VStack(spacing: 4) {
                    earnRow(title: "Make content for us")
                    Divider().background(Color.white.opacity(0.2))
                    
                    earnRow(title: "Become an affiliate")
                    Divider().background(Color.white.opacity(0.2))
                    
                    earnRow(title: "Refer Friends")
                    Divider().background(Color.white.opacity(0.2))
                    
                    earnRow(title: "Join our team")
                    Divider().background(Color.white.opacity(0.2))
                    
                    earnRow(title: "Other deals")
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
            }
        }
    }
    
    private func earnRow(title: String) -> some View {
        Button(action: {
            // TODO: Navigate to specific earn flow
        }) {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.vertical, 16)
        }
    }
}

// MARK: - Subscription View

struct SubscriptionView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button(action: { dismiss() }) {
                        GlassBackButton(action: { dismiss() })
                    }
                    
                    Spacer()
                    
                    Text("Subscription")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 20) {
                    // Current subscription
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Subscription")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                        
                        HStack {
                            Text("Monthly $9.99")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("Paid via Apple Pay")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                    .padding(.top, 20)
                    
                    Divider().background(Color.white.opacity(0.2))
                    
                    // Upgrade to Lifetime
                    Button(action: {
                        // TODO: Navigate to lifetime purchase
                    }) {
                        HStack(spacing: 16) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.green)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Upgrade to Lifetime")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text("Enjoy NoGoon forever without a subscription")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.6))
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.vertical, 12)
                    }
                    
                    Divider().background(Color.white.opacity(0.2))
                    
                    // Unsubscribe
                    Button(action: {
                        // TODO: Navigate to unsubscribe flow
                    }) {
                        HStack(spacing: 16) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.red)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Unsubscribe Account")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text("Cancel your NoGoon subscription")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.6))
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.vertical, 12)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
}

// MARK: - More View

struct MoreView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button(action: { dismiss() }) {
                        GlassBackButton(action: { dismiss() })
                    }
                    
                    Spacer()
                    
                    Text("More")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 4) {
                        SettingsToggleRow(title: "Faster Splash Screen", isOn: $viewModel.fasterSplashScreen)
                        
                        Divider().background(Color.white.opacity(0.2))
                        
                        SettingsToggleRow(title: "No Nut November Dev", isOn: $viewModel.noNutNovemberDev)
                        
                        Divider().background(Color.white.opacity(0.2))
                        
                        moreRow(title: "Rate NoGoon") {
                            viewModel.rateApp()
                        }
                        
                        Divider().background(Color.white.opacity(0.2))
                        
                        moreRow(title: "Join our team") {
                            viewModel.openURL("https://nogoon.app/careers")
                        }
                        
                        Divider().background(Color.white.opacity(0.2))
                        
                        moreRow(title: "Suggest a change or feature") {
                            // TODO: Open feature request
                        }
                        
                        Divider().background(Color.white.opacity(0.2))
                        
                        moreRow(title: "Terms of use") {
                            viewModel.openURL("https://nogoon.app/terms")
                        }
                        
                        Divider().background(Color.white.opacity(0.2))
                        
                        moreRow(title: "Subscription details") {
                            // TODO: Show subscription details
                        }
                        
                        Divider().background(Color.white.opacity(0.2))
                        
                        moreRow(title: "Privacy policy") {
                            viewModel.openURL("https://nogoon.app/privacy")
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
        }
    }
    
    private func moreRow(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.vertical, 16)
        }
    }
}

