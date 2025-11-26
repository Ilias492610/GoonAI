//
//  ContentBlockerView.swift
//  GoonAi
//
//  Content blocker settings screen
//

import SwiftUI
import UIKit
import FamilyControls

struct ContentBlockerView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var screenTimeManager = ScreenTimeManager.shared
    @State private var contentRestrictionsEnabled = false
    @State private var isProcessing = false
    @State private var alertMessage: String?
    @State private var isSyncingToggle = false
    
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
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Enable Content Restrictions")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(statusDescription)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.7))
                                    }
                                    Spacer()
                                    Toggle("", isOn: $contentRestrictionsEnabled)
                                        .labelsHidden()
                                        .disabled(isProcessing)
                                        .tint(Color.green)
                                }
                                if isProcessing {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                        .tint(.white)
                                }
                                if let alertMessage {
                                    Text(alertMessage)
                                        .font(.caption2)
                                        .foregroundColor(.yellow)
                                }
                            }
                            .padding()
                            .glassEffect()
                            .padding(.horizontal, 20)
                            .onChange(of: contentRestrictionsEnabled) { newValue in
                                guard !isSyncingToggle else { return }
                                Task { await toggleContentRestrictions(newValue) }
                            }
                            .onReceive(screenTimeManager.$isBlockingActive) { isActive in
                                isSyncingToggle = true
                                withAnimation {
                                    contentRestrictionsEnabled = isActive
                                }
                                DispatchQueue.main.async {
                                    isSyncingToggle = false
                                }
                            }
                        }
                        .padding(.top, 20)
                        
                        VStack(spacing: 12) {
                            Label("Safari, Chrome & in-app browsers stay clean", systemImage: "globe")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                            Label("Adult content domains are blocked", systemImage: "shield.lefthalf.filled")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 100)
                    }
                }
            }
        }
        .task {
            await screenTimeManager.refreshStatus()
            isSyncingToggle = true
            contentRestrictionsEnabled = screenTimeManager.isBlockingActive
            isSyncingToggle = false
        }
        .alert("Screen Time", isPresented: Binding(get: { alertMessage != nil }, set: { if !$0 { alertMessage = nil } })) {
            Button("OK", role: .cancel, action: { alertMessage = nil })
        } message: {
            if let alertMessage {
                Text(alertMessage)
            }
        }
    }
    
    // MARK: - Helper Functions
    
    private var statusDescription: String {
        switch screenTimeManager.authorizationStatus {
        case .approved:
            return screenTimeManager.isBlockingActive ? "Porn domains are currently blocked." : "Tap the switch to begin blocking popular porn sites."
        case .denied:
            return "Screen Time permission denied. Open Settings to allow access."
        case .notDetermined:
            return "We'll ask for Screen Time access when you enable the switch."
        @unknown default:
            return "Screen Time status unavailable on this device."
        }
    }

    private func toggleContentRestrictions(_ isOn: Bool) async {
        guard !isProcessing else { return }
        await MainActor.run { isProcessing = true }
        defer { Task { @MainActor in isProcessing = false } }
        do {
            if isOn {
                try await screenTimeManager.enableDefaultRestrictions()
            } else {
                screenTimeManager.disableRestrictions()
            }
        } catch {
            await MainActor.run {
                contentRestrictionsEnabled = false
                alertMessage = "We couldn't get Screen Time permission. Please enable Screen Time for NoGoon in Settings and try again."
            }
        }
    }
}

