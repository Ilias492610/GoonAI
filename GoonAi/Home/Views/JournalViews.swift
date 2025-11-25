//
//  JournalViews.swift
//  GoonAi
//
//  Journal and note views
//

import SwiftUI

// MARK: - Add Note View

struct AddNoteView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var noteBody: String = ""
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.cyan)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        Capsule()
                            .fill(.ultraThinMaterial)
                    )
                    
                    Spacer()
                    
                    Button("Save") {
                        if !title.isEmpty || !noteBody.isEmpty {
                            viewModel.addJournalEntry(title: title, body: noteBody)
                        }
                        dismiss()
                    }
                    .foregroundColor(.cyan)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        Capsule()
                            .fill(.ultraThinMaterial)
                    )
                    .disabled(title.isEmpty && noteBody.isEmpty)
                    .opacity(title.isEmpty && noteBody.isEmpty ? 0.5 : 1.0)
                }
                .padding()
                
                // Title
                Text("Add Note")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                
                // Text editor card
                VStack(alignment: .leading, spacing: 0) {
                    TextField("Title", text: $title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .tint(.white)
                    
                    Divider()
                        .background(Color.white.opacity(0.2))
                        .padding(.horizontal)
                    
                    TextEditor(text: $noteBody)
                        .font(.body)
                        .foregroundColor(.white)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .frame(minHeight: 200)
                        .padding()
                        .tint(.white)
                }
                .glassEffect(cornerRadius: 20, opacity: 0.2)
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
}

// MARK: - Quitting Reason View

struct QuittingReasonView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var reasonText: String = ""
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.cyan)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        Capsule()
                            .fill(.ultraThinMaterial)
                    )
                    
                    Spacer()
                    
                    Button("Save") {
                        viewModel.updateQuittingReason(reasonText)
                        dismiss()
                    }
                    .foregroundColor(.cyan)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        Capsule()
                            .fill(.ultraThinMaterial)
                    )
                    .disabled(reasonText.isEmpty)
                    .opacity(reasonText.isEmpty ? 0.5 : 1.0)
                }
                .padding()
                
                // Title
                Text("Quitting Reason")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                
                // Text editor card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Why are you committed to the No-Nut journey? How is it affecting you, how do you feel when you relapse? (required)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.horizontal)
                        .padding(.top)
                    
                    TextEditor(text: $reasonText)
                        .font(.body)
                        .foregroundColor(.white)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .frame(minHeight: 250)
                        .padding()
                        .tint(.white)
                }
                .glassEffect(cornerRadius: 20, opacity: 0.2)
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .onAppear {
            reasonText = viewModel.quittingReason.text
        }
    }
}

