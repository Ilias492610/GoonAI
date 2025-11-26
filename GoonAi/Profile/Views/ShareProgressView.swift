//
//  ShareProgressView.swift
//  GoonAi
//
//  Share progress card
//

import SwiftUI

struct ShareProgressView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Spacer()
                    
                    Text("Share Progress")
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
                    alignment: .trailing
                )
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
                
                // Progress Card
                NoGoonProgressCard(viewModel: viewModel)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                // Share Button
                Button(action: {
                    viewModel.shareProgress()
                }) {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 18))
                            Text("Share Progress")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [.cyan, .blue],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .shadow(color: .cyan.opacity(0.4), radius: 15, x: 0, y: 8)
                        )
                    }
                    .padding(.horizontal, 30)
                
                Spacer()
            }
        }
    }
}

// MARK: - NoGoon Progress Card

struct NoGoonProgressCard: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var offset: CGFloat = 1000
    @State private var rotation: Double = 89.9
    @State private var opacity: Double = 0
    
    var body: some View {
        ZStack {
            // Background with gradient
            ZStack {
                Image("Circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 400)
                    .cornerRadius(16)
                Image("recgradient2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 400)
                    .cornerRadius(16)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                // Top part of the card
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("NoGoon Card")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Spacer()
                        Image(systemName: "heart.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.white)
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Days Clean")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.system(size: 12, weight: .medium))
                        
                        Text("\(viewModel.currentStreak)")
                            .foregroundColor(.white)
                            .font(.system(size: 26, weight: .medium))
                    }
                }
                .padding(24)
                
                Spacer()
                
                // Bottom part of the card
                HStack {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.system(size: 12, weight: .medium))
                        Text(viewModel.userProfile.name)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("Best Streak")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.system(size: 12, weight: .medium))
                        Text("\(viewModel.bestStreak)")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                    }
                }
                .padding(24)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.fromHex("3E3C3D"), Color.fromHex("2C2C2C")]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            }
        }
        .frame(width: 280, height: 400)
        .cornerRadius(25)
        .offset(y: offset)
        .rotation3DEffect(
            .degrees(rotation),
            axis: (x: 1.0, y: 0.0, z: 0.0)
        )
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                offset = 0
                rotation = 0
                opacity = 1
            }
        }
    }
}

// MARK: - Color Extension for Hex
extension Color {
    static func fromHex(_ hex: String) -> Color {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 1, 1, 0)
        }

        return Color(.sRGB,
                     red: Double(r) / 255,
                     green: Double(g) / 255,
                     blue: Double(b) / 255,
                     opacity: Double(a) / 255)
    }
}
