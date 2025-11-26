//
//  MeditationView.swift
//  GoonAi
//
//  Meditation screen for mindfulness practice
//

import SwiftUI

struct MeditationView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isSessionActive = false
    @State private var timeRemaining = 300 // 5 minutes in seconds
    @State private var selectedDuration = 5 // minutes
    @State private var timer: Timer?
    
    let durations = [1, 3, 5, 10, 15] // minutes
    
    var body: some View {
        ZStack {
            // Starry background
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button {
                        stopSession()
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
                    
                    Text("Meditate")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Placeholder for balance
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Breathing animation circle
                        ZStack {
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [
                                            Color.purple.opacity(0.6),
                                            Color.blue.opacity(0.4),
                                            Color.clear
                                        ],
                                        center: .center,
                                        startRadius: 50,
                                        endRadius: 150
                                    )
                                )
                                .frame(width: 250, height: 250)
                                .scaleEffect(isSessionActive ? 1.2 : 1.0)
                                .animation(
                                    isSessionActive ?
                                    .easeInOut(duration: 4.0).repeatForever(autoreverses: true) :
                                    .default,
                                    value: isSessionActive
                                )
                            
                            Circle()
                                .stroke(Color.white.opacity(0.3), lineWidth: 2)
                                .frame(width: 250, height: 250)
                        }
                        .padding(.top, 40)
                        
                        // Timer display
                        VStack(spacing: 12) {
                            Text(timeString)
                                .font(.system(size: 60, weight: .light, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text(isSessionActive ? "Breathe..." : "Find your calm")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(.vertical, 20)
                        
                        // Duration selector (only show when not active)
                        if !isSessionActive {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Select Duration")
                                    .font(.headline)
                                    .foregroundColor(.white.opacity(0.8))
                                
                                HStack(spacing: 12) {
                                    ForEach(durations, id: \.self) { duration in
                                        Button {
                                            selectedDuration = duration
                                            timeRemaining = duration * 60
                                        } label: {
                                            Text("\(duration)m")
                                                .font(.headline)
                                                .foregroundColor(selectedDuration == duration ? .black : .white)
                                                .frame(width: 60, height: 44)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(selectedDuration == duration ? Color.white : Color.white.opacity(0.2))
                                                )
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        // Start/Stop button
                        Button {
                            if isSessionActive {
                                stopSession()
                            } else {
                                startSession()
                            }
                        } label: {
                            HStack {
                                Image(systemName: isSessionActive ? "pause.fill" : "play.fill")
                                Text(isSessionActive ? "Pause" : "Start Session")
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
                        
                        // Instructions
                        VStack(alignment: .leading, spacing: 16) {
                            Text("How to Meditate")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            VStack(alignment: .leading, spacing: 12) {
                                InstructionRow(
                                    icon: "1.circle.fill",
                                    text: "Find a quiet, comfortable place to sit"
                                )
                                InstructionRow(
                                    icon: "2.circle.fill",
                                    text: "Close your eyes and focus on your breath"
                                )
                                InstructionRow(
                                    icon: "3.circle.fill",
                                    text: "Breathe in for 4 counts, hold for 4, exhale for 4"
                                )
                                InstructionRow(
                                    icon: "4.circle.fill",
                                    text: "Let thoughts pass without judgment"
                                )
                            }
                        }
                        .padding()
                        .glassEffect()
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 100)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onDisappear {
            stopSession()
        }
    }
    
    // MARK: - Computed Properties
    
    private var timeString: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // MARK: - Session Control
    
    private func startSession() {
        isSessionActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopSession()
                // Session completed
            }
        }
    }
    
    private func stopSession() {
        isSessionActive = false
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Instruction Row

struct InstructionRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 30)
            
            Text(text)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
        }
    }
}

#Preview {
    MeditationView()
}
