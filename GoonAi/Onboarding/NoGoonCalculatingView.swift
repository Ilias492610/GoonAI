//
//  NoGoonCalculatingView.swift
//  GoonAi
//
//  Calculating screen with loading animation (based on CalculateView pattern)
//

import SwiftUI
import CoreHaptics
import Combine

struct NoGoonCalculatingView: View {
    @State private var progress: Double = 0
    @State private var engine: CHHapticEngine?
    let onComplete: () -> Void
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // Match CalAI white background pattern
            Color.white
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    Circle()
                        .stroke(Color(.systemGray6).opacity(0.65), lineWidth: 15)

                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(style: StrokeStyle(lineWidth: 18, lineCap: .round, lineJoin: .round))
                        .foregroundStyle(LinearGradient(Color(hex: "23C8C8"), Color(hex: "#32C730")))
                        .rotationEffect(.degrees(-90))
                        .animation(.linear, value: progress)

                    Text("\(Int(progress * 100))%")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .contentTransition(.numericText())
                }
                .frame(width: 200, height: 200)
                .padding(.bottom, 30)

                Text("Calculating")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text(subtitleForProgress(progress))
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                    .padding(.top, 5)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear(perform: prepareHaptics)
        .onReceive(timer) { _ in
            if progress < 1.0 {
                progress += 0.01
                vibrate()
            } else {
                explode()
            }
        }
    }

    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptics error: \(error.localizedDescription)")
        }
    }

    func vibrate() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(progress))
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(progress))
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Pattern error: \(error.localizedDescription)")
        }
    }

    func explode() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        onComplete()
    }

    func subtitleForProgress(_ progress: Double) -> String {
        switch progress {
        case 0.0..<0.2:
            return "Understanding responses"
        case 0.2..<0.6:
            return "Analyzing patterns"
        case 0.6..<1:
            return "Building custom plan"
        default:
            return "Finalizing"
        }
    }
}

