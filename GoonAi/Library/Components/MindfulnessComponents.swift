//
//  MindfulnessComponents.swift
//  GoonAi
//
//  Mindfulness audio components
//

import SwiftUI

// MARK: - Mindfulness Audio Card

struct MindfulnessAudioCard: View {
    let track: AudioTrack
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottomLeading) {
                // Background image placeholder
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: gradientColors(for: track.title),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 160)
                
                // Overlay
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Text(track.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 8) {
                        Image(systemName: "play.fill")
                            .font(.caption)
                        Text("Start")
                            .font(.subheadline)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(.ultraThinMaterial)
                    )
                }
                .padding()
            }
        }
        .buttonStyle(.plain)
    }
    
    private func gradientColors(for title: String) -> [Color] {
        switch title {
        case "Ocean Waves":
            return [Color.cyan, Color.blue]
        case "Rain & Thunder":
            return [Color.purple, Color.indigo]
        case "Forest Sounds":
            return [Color.green, Color.teal]
        case "Deep Ocean":
            return [Color.blue, Color.indigo]
        default:
            return [Color.blue, Color.purple]
        }
    }
}

// MARK: - Mindfulness Player View

struct MindfulnessPlayerView: View {
    let track: AudioTrack
    @ObservedObject var viewModel: LibraryViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Full-screen background with track colors
            LinearGradient(
                colors: gradientColors(for: track.title),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Title and timer
                VStack(spacing: 16) {
                    Text(track.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(formattedTime)
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                // Controls
                HStack(spacing: 40) {
                    // Record/restart button
                    Button {
                        viewModel.playbackTime = 0
                    } label: {
                        Circle()
                            .fill(Color.black.opacity(0.3))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "arrow.counterclockwise")
                                    .font(.title3)
                                    .foregroundColor(.white)
                            )
                    }
                    
                    // Play/pause button
                    Button {
                        viewModel.togglePlayback()
                    } label: {
                        Circle()
                            .fill(Color.black.opacity(0.3))
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            )
                    }
                    
                    // Close button
                    Button {
                        viewModel.stopAudio()
                        dismiss()
                    } label: {
                        Circle()
                            .fill(Color.black.opacity(0.3))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "xmark")
                                    .font(.title3)
                                    .foregroundColor(.white)
                            )
                    }
                }
                .padding(.bottom, 120)
            }
        }
    }
    
    private var formattedTime: String {
        let minutes = Int(viewModel.playbackTime) / 60
        let seconds = Int(viewModel.playbackTime) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private func gradientColors(for title: String) -> [Color] {
        switch title {
        case "Ocean Waves":
            return [Color.cyan, Color.blue, Color.teal]
        case "Rain & Thunder":
            return [Color.purple, Color.indigo, Color.blue]
        case "Forest Sounds":
            return [Color.green, Color.teal, Color.mint]
        case "Deep Ocean":
            return [Color.blue, Color.indigo, Color.black]
        default:
            return [Color.blue, Color.purple]
        }
    }
}

