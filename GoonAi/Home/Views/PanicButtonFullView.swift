//
//  PanicButtonFullView.swift
//  GoonAi
//
//  Full-screen panic button experience
//

import SwiftUI

struct PanicButtonFullView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
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
                    
                    Text("PANIC BUTTON")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // Main heading
                        Text("STOP WHAT YOU'RE DOING AND BREATHE")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                            .padding(.top, 20)
                        
                        // Side effects section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Side effects of relapsing:")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                            
                            VStack(spacing: 16) {
                                SideEffectRow(
                                    icon: "arrow.up.arrow.down",
                                    title: "ERECTILE DYSFUNCTION",
                                    description: "Inability to get hard in bed."
                                )
                                
                                SideEffectRow(
                                    icon: "exclamationmark.circle",
                                    title: "DESENSITIZATION",
                                    description: "Needing more extreme content for arousal."
                                )
                                
                                SideEffectRow(
                                    icon: "heart.slash",
                                    title: "RELATIONSHIP ISSUES",
                                    description: "Decreased intimacy and trust."
                                )
                            }
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(Color(red: 0.12, green: 0.13, blue: 0.26).opacity(0.5))
                            )
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 20)
                    }
                    .padding(.bottom, 180)
                }
                
                Spacer()
            }
            
            // Fixed bottom buttons
            VStack(spacing: 12) {
                Button {
                    dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        viewModel.startRelapseFlow()
                    }
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 20))
                        Text("I Relapsed")
                            .font(.system(size: 16, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
                    )
                }
                
                Button {
                    dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        viewModel.activeSheet = .urgeSupport
                    }
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 20))
                        Text("I'm thinking of relapsing")
                            .font(.system(size: 16, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 0.48, green: 0.03, blue: 0.16))
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

// Side effect row component
struct SideEffectRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.gray)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.3, green: 0.71, blue: 0.67))
            }
            
            Spacer()
        }
    }
}
