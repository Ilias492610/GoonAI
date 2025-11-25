//
//  DailyCheckInView.swift
//  GoonAi
//
//  Daily check-in after pledge completion
//

import SwiftUI

struct DailyCheckInView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var successfulPledge = true
    @State private var selectedFeeling = "Controlled"
    @State private var additionalNotes = ""
    
    let feelings = ["Controlled", "Confident", "Struggling", "Tempted", "Strong"]
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
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
                    
                    Spacer()
                    
                    Text("How was your day?")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button {
                        // Info
                    } label: {
                        Image(systemName: "questionmark.circle")
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
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Check-in card
                        VStack(spacing: 16) {
                            // Successful Pledge toggle
                            HStack {
                                Text("Successful Pledge")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Toggle("", isOn: $successfulPledge)
                                    .labelsHidden()
                            }
                            
                            Divider()
                                .background(Color.white.opacity(0.2))
                            
                            // Feeling picker
                            HStack {
                                Text("How did you feel?")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Menu {
                                    ForEach(feelings, id: \.self) { feeling in
                                        Button(feeling) {
                                            selectedFeeling = feeling
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(selectedFeeling)
                                            .foregroundColor(.cyan)
                                        Image(systemName: "chevron.up.chevron.down")
                                            .font(.caption)
                                            .foregroundColor(.cyan)
                                    }
                                }
                            }
                            
                            Divider()
                                .background(Color.white.opacity(0.2))
                            
                            // Additional notes
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Additional notes")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                                
                                TextEditor(text: $additionalNotes)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .scrollContentBackground(.hidden)
                                    .background(Color.clear)
                                    .frame(height: 100)
                                    .tint(.white)
                            }
                        }
                        .padding()
                        .glassEffect(cornerRadius: 20, opacity: 0.25)
                        .padding(.horizontal, 20)
                        .padding(.top, 30)
                        
                        Spacer(minLength: 200)
                    }
                }
                
                // Submit button
                Button {
                    viewModel.completePledge(
                        successful: successfulPledge,
                        feeling: selectedFeeling,
                        notes: additionalNotes.isEmpty ? nil : additionalNotes
                    )
                    dismiss()
                } label: {
                    Text("Submit")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                        )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
    }
}

