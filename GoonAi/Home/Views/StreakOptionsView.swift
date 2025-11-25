//
//  StreakOptionsView.swift
//  GoonAi
//
//  Streak options overlay
//

import SwiftUI

struct StreakOptionsView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Semi-transparent background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    dismiss()
                }
            
            // Options card
            VStack(spacing: 0) {
                Text("Streak Options")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.top, 24)
                    .padding(.bottom, 30)
                
                // Edit Start Date button
                Button {
                    dismiss()
                    viewModel.showStreakWarning = true
                } label: {
                    Text("Edit Start Date")
                        .font(.headline)
                        .foregroundColor(.cyan)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.white.opacity(0.15))
                        )
                }
                .padding(.horizontal, 20)
                
                // Reset Streak button
                Button {
                    viewModel.resetStreak()
                    dismiss()
                } label: {
                    Text("Reset Streak")
                        .font(.headline)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.white.opacity(0.15))
                        )
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
            .frame(width: 320)
            .glassEffect(cornerRadius: 25, opacity: 0.3)
        }
    }
}

