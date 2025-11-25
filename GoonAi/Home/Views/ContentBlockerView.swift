//
//  ContentBlockerView.swift
//  GoonAi
//
//  Content blocker settings screen
//

import SwiftUI

struct ContentBlockerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var contentRestrictionsEnabled = false
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .fill(.ultraThinMaterial)
                            )
                    }
                    
                    Spacer()
                    
                    Text("Content Blocker")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Placeholder for balance
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Icon illustration
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.orange, Color.red],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 200, height: 200)
                            
                            VStack(spacing: 8) {
                                Image(systemName: "shield.lefthalf.filled")
                                    .font(.system(size: 60))
                                    .foregroundColor(.white)
                                
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 40)
                        
                        // Title and description
                        VStack(spacing: 12) {
                            Text("Content Blocker")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("NoGoon protects you by managing content restrictions and disabling private browsing.")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                        }
                        
                        // Settings
                        VStack(spacing: 16) {
                            // Enable Content Restrictions toggle
                            HStack {
                                Text("Enable Content Restrictions")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Toggle("", isOn: $contentRestrictionsEnabled)
                                    .labelsHidden()
                            }
                            .padding()
                            .glassEffect()
                            .padding(.horizontal, 20)
                            
                            // Block on desktop
                            Button {
                                // TODO: Navigate to desktop blocking setup
                            } label: {
                                HStack {
                                    Text("Block content on desktop")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding()
                                .glassEffect()
                                .padding(.horizontal, 20)
                            }
                        }
                        .padding(.top, 20)
                        
                        // Block Apps button
                        Button {
                            // TODO: Navigate to app blocking
                        } label: {
                            HStack {
                                Text("Block Apps")
                                Image(systemName: "plus")
                            }
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
                        .padding(.top, 20)
                        .padding(.bottom, 100)
                    }
                }
            }
        }
    }
}

