//
//  MeliusChatView.swift
//  GoonAi
//
//  Melius AI chat interface
//

import SwiftUI

struct MeliusChatView: View {
    @ObservedObject var viewModel: LibraryViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var messageText = ""
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Header
                header
                
                if viewModel.chatMessages.isEmpty {
                    // Empty state
                    emptyState
                } else {
                    // Chat messages
                    chatMessages
                }
                
                // Input bar
                inputBar
            }
        }
        .navigationBarHidden(true)
        .onDisappear {
            viewModel.clearChat()
        }
    }
    
    // MARK: - Header
    
    private var header: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Circle().fill(.ultraThinMaterial))
                }
                
                Spacer()
                
                VStack(spacing: 2) {
                    Text("Melius")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("Powered by AI")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding()
        }
    }
    
    // MARK: - Empty State
    
    private var emptyState: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Illustration placeholder
            ZStack {
                Circle()
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 200, height: 200)
                
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 80))
                    .foregroundColor(.purple)
            }
            
            VStack(spacing: 12) {
                Text("Talk to Melius")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Chat messages are cleared each time you leave this view to ensure your privacy.")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
        }
    }
    
    // MARK: - Chat Messages
    
    private var chatMessages: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.chatMessages) { message in
                        ChatBubble(message: message)
                            .id(message.id)
                    }
                }
                .padding()
                .padding(.bottom, 20)
            }
            .onChange(of: viewModel.chatMessages.count) { _ in
                if let lastMessage = viewModel.chatMessages.last {
                    withAnimation {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
        }
    }
    
    // MARK: - Input Bar
    
    private var inputBar: some View {
        HStack(spacing: 12) {
            TextField("Say something", text: $messageText)
                .font(.body)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    Capsule()
                        .fill(.ultraThinMaterial)
                )
                .focused($isInputFocused)
            
            Button {
                sendMessage()
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.title)
                    .foregroundColor(messageText.isEmpty ? .white.opacity(0.3) : .cyan)
            }
            .disabled(messageText.isEmpty)
        }
        .padding()
        .background(.ultraThinMaterial)
    }
    
    // MARK: - Actions
    
    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        viewModel.sendMessage(messageText)
        messageText = ""
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

// MARK: - Chat Bubble

struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
            }
            
            Text(message.text)
                .font(.body)
                .foregroundColor(message.isUser ? .primary : .white)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(message.isUser ? Color.white : Color.purple.opacity(0.3))
                )
                .frame(maxWidth: 280, alignment: message.isUser ? .trailing : .leading)
            
            if !message.isUser {
                Spacer()
            }
        }
    }
}

