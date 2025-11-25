//
//  PledgeViews.swift
//  GoonAi
//
//  Pledge flow views
//

import SwiftUI

// MARK: - Pledge View

struct PledgeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showConfirmation = false
    
    var body: some View {
        ZStack {
            // Background
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .fill(.ultraThinMaterial)
                                )
                    }
                    
                    Spacer()
                    
                    Text("Pledge")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button {
                        // Info button
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .fill(.ultraThinMaterial)
                            )
                    }
                }
                .padding()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Hand icon
                        Image(systemName: "hand.raised.fill")
                            .font(.system(size: 100))
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.top, 40)
                        
                        // Title
                        Text("Pledge Sobriety Today")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        // Description
                        Text("Make a commitment to yourself not to masturbate for today. You'll receive a notification in 24 hours to check in and see how you did.")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                        
                        // Info cards
                        VStack(spacing: 16) {
                            PledgeInfoCard(
                                icon: "checkmark.circle.fill",
                                title: "Achievable Goal",
                                description: "When pledging, you agree to not relapse for the day only."
                            )
                            
                            PledgeInfoCard(
                                icon: "sparkles",
                                title: "Take it Easy",
                                description: "Just live the day as normal and after pledging, don't change your mind"
                            )
                            
                            PledgeInfoCard(
                                icon: "crown.fill",
                                title: "Success is Inevitable",
                                description: "Stay strong, the first few days/weeks will be tough but after that it'll get easier."
                            )
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer(minLength: 100)
                    }
                }
                
                // Bottom button
                Button {
                    showConfirmation = true
                } label: {
                    Text("Pledge Now")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(Color.white)
                        )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .alert("Pledge to not fap today?", isPresented: $showConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Pledge") {
                viewModel.startPledge()
                dismiss()
            }
        } message: {
            Text("You'll receive a notification in 24 hours to check in and see how you did.")
        }
    }
}

struct PledgeInfoCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassEffect()
    }
}

// MARK: - Pledge Confirmation (Alternative inline version)

struct PledgeConfirmationView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Pledge to not fap today?")
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text("You'll receive a notification in 24 hours to check in and see how you did.")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 12) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.2))
                    )
                    .foregroundColor(.white)
                    
                    Button("Pledge") {
                        viewModel.startPledge()
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                    )
                    .foregroundColor(.primary)
                }
            }
            .padding(24)
            .glassEffect(cornerRadius: 20)
            .padding(.horizontal, 40)
        }
    }
}

