//
//  ReferralView.swift
//  GoonAi
//
//  Referral / Guest Pass modal
//

import SwiftUI

struct ReferralView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            // Blurred background
            Color.black.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    dismiss()
                }
            
            VStack(spacing: 0) {
                Spacer()
                
                VStack(spacing: 30) {
                    // Close button
                    HStack {
                        Spacer()
                        
                        Button(action: { dismiss() }) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: 44, height: 44)
                                
                                Image(systemName: "xmark")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    
                    // Title
                    Text("Refer Your Friends")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    // Circle avatars (mock)
                    ZStack {
                        // Center circle with logo
                        Circle()
                            .stroke(Color.white, lineWidth: 3)
                            .frame(width: 120, height: 120)
                            .overlay(
                                Text("NOGOON")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            )
                        
                        // Surrounding avatars
                        ForEach(0..<6) { index in
                            Circle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.white.opacity(0.6))
                                )
                                .offset(
                                    x: cos(Double(index) * .pi / 3) * 110,
                                    y: sin(Double(index) * .pi / 3) * 110
                                )
                        }
                    }
                    .frame(height: 280)
                    
                    // Subtitle
                    VStack(spacing: 8) {
                        Text("Empower Your Friends")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Text("& quit porn together")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    
                    // Promo code card
                    HStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Your personal promo code")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text(viewModel.referralData.promoCode)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.copyPromoCode()
                        }) {
                            Image(systemName: "doc.on.doc")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.white.opacity(0.15))
                    )
                    .padding(.horizontal, 30)
                    
                    // Share button
                    Button(action: {
                        viewModel.shareReferral()
                    }) {
                        Text("Share")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .fill(Color.white)
                            )
                    }
                    .padding(.horizontal, 30)
                    
                    // How to earn section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 6) {
                            Text("How to earn")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Image(systemName: "dollarsign.circle.fill")
                                .foregroundColor(.white)
                        }
                        
                        HStack(alignment: .top, spacing: 12) {
                            Text("*")
                                .font(.title)
                                .foregroundColor(.white)
                            
                            Text("Share your promo code to your friends")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        HStack(alignment: .top, spacing: 12) {
                            Text("*")
                                .font(.title)
                                .foregroundColor(.white)
                            
                            Text("Earn $10 per friend that signs up with your code")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.white.opacity(0.1))
                    )
                    .padding(.horizontal, 30)
                    
                    Spacer(minLength: 40)
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.1, green: 0.15, blue: 0.3),
                                    Color(red: 0.05, green: 0.1, blue: 0.2)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )
            }
        }
    }
}

