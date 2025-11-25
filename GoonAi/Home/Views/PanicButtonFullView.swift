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
                    Spacer()
                    
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
                }
                .padding()
                
                // NoGoon logo
                Text("NOGOON")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .tracking(2)
                    .padding(.top, 20)
                
                Text("Panic Button")
                    .font(.title3)
                    .foregroundColor(.red)
                    .padding(.top, 8)
                
                Spacer()
                
                // Camera/video placeholder
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 300)
                    
                    VStack(spacing: 12) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white.opacity(0.5))
                        
                        Text("Camera placeholder")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                        
                        Text("TODO: Integrate live camera feed")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.3))
                    }
                }
                .padding(.horizontal, 30)
                
                // Message overlay
                VStack(spacing: 16) {
                    Text("WHAT'S YOUR EXCUSE THIS TIME?")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                    Text("Side effects of Relapsing:")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.top, 30)
                
                Spacer()
                
                // Action buttons
                VStack(spacing: 12) {
                    Button {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            viewModel.startRelapseFlow()
                        }
                    } label: {
                        HStack {
                            Image(systemName: "hand.thumbsdown.fill")
                            Text("I Relapsed")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.5))
                        )
                    }
                    
                    Button {
                        dismiss()
                        // TODO: Navigate to support/meditation content
                    } label: {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                            Text("I'm thinking of relapsing")
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

