//
//  LibraryViewModel.swift
//  GoonAi
//
//  Library view model for NoGoon
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

@MainActor
class LibraryViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var articles: [Article] = []
    @Published var audioTracks: [AudioTrack] = AudioTrack.tracks
    @Published var chatMessages: [ChatMessage] = []
    @Published var currentAudioTrack: AudioTrack?
    @Published var isPlaying: Bool = false
    @Published var playbackTime: TimeInterval = 0
    
    // MARK: - Private Properties
    
    private var audioPlayer: AVAudioPlayer?
    private var playbackTimer: Timer?
    
    // MARK: - Computed Properties
    
    func completionPercentage(for category: ArticleCategory) -> Int {
        let categoryArticles = articles.filter { $0.category == category }
        guard !categoryArticles.isEmpty else { return 0 }
        let completed = categoryArticles.filter { $0.isCompleted }.count
        return Int((Double(completed) / Double(categoryArticles.count)) * 100)
    }
    
    func articles(for category: ArticleCategory) -> [Article] {
        articles.filter { $0.category == category }.sorted { $0.index < $1.index }
    }
    
    var nextLesson: Article? {
        articles.first { !$0.isCompleted }
    }
    
    var lessonProgress: String {
        let completed = articles.filter { $0.isCompleted }.count
        let total = articles.count
        return "\(completed)/\(total)"
    }
    
    // MARK: - Initialization
    
    init() {
        loadArticles()
        loadChatHistory()
    }
    
    // MARK: - Data Loading
    
    private func loadArticles() {
        // TODO: Load from Supabase or local storage
        // For now, use sample articles
        articles = Article.sampleArticles
        
        // Load completion status from persistence
        if let savedArticles = UserDefaults.standard.data(forKey: "libraryArticles"),
           let decoded = try? JSONDecoder().decode([Article].self, from: savedArticles) {
            articles = decoded
        }
    }
    
    private func loadChatHistory() {
        // Chat is ephemeral - cleared each session
        chatMessages = []
    }
    
    // MARK: - Article Actions
    
    func toggleArticleCompletion(_ articleId: String) {
        if let index = articles.firstIndex(where: { $0.id == articleId }) {
            articles[index].isCompleted.toggle()
            saveArticles()
        }
    }
    
    func markArticleComplete(_ articleId: String) {
        if let index = articles.firstIndex(where: { $0.id == articleId }) {
            articles[index].isCompleted = true
            saveArticles()
        }
    }
    
    private func saveArticles() {
        if let encoded = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(encoded, forKey: "libraryArticles")
        }
    }
    
    // MARK: - Audio Actions
    
    func playAudio(_ track: AudioTrack) {
        // Stop any currently playing audio
        stopAudio()
        
        currentAudioTrack = track
        
        // Try to load and play the audio file
        guard let url = Bundle.main.url(forResource: track.filename.replacingOccurrences(of: ".mp3", with: ""), withExtension: "mp3") else {
            print("⚠️ Audio file not found: \(track.filename)")
            print("📝 Add \(track.filename) to your Xcode project to enable playback")
            // Fall back to simulation if file doesn't exist
            simulatePlayback()
            return
        }
        
        do {
            // Configure audio session for playback
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            // Initialize and configure the audio player
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            isPlaying = true
            playbackTime = 0
            
            // Start timer to update playback time
            startPlaybackTimer()
            
            print("✅ Now playing: \(track.title)")
        } catch {
            print("❌ Error playing audio: \(error.localizedDescription)")
            // Fall back to simulation if playback fails
            simulatePlayback()
        }
    }
    
    func togglePlayback() {
        guard let player = audioPlayer else {
            isPlaying.toggle()
            return
        }
        
        if isPlaying {
            player.pause()
            isPlaying = false
            playbackTimer?.invalidate()
            playbackTimer = nil
        } else {
            player.play()
            isPlaying = true
            startPlaybackTimer()
        }
    }
    
    func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
        playbackTimer?.invalidate()
        playbackTimer = nil
        isPlaying = false
        currentAudioTrack = nil
        playbackTime = 0
        
        // Deactivate audio session
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
    
    func restartAudio() {
        guard let player = audioPlayer else {
            playbackTime = 0
            return
        }
        
        player.currentTime = 0
        playbackTime = 0
        
        if !isPlaying {
            player.play()
            isPlaying = true
            startPlaybackTimer()
        }
    }
    
    private func startPlaybackTimer() {
        playbackTimer?.invalidate()
        playbackTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            Task { @MainActor in
                if let player = self.audioPlayer {
                    self.playbackTime = player.currentTime
                }
            }
        }
    }
    
    private func simulatePlayback() {
        // Fallback simulation when audio files aren't available
        isPlaying = true
        playbackTime = 0
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self, self.isPlaying else {
                timer.invalidate()
                return
            }
            
            Task { @MainActor in
                self.playbackTime += 1
                
                if let track = self.currentAudioTrack, self.playbackTime >= track.duration {
                    self.stopAudio()
                    timer.invalidate()
                }
            }
        }
    }
    
    // MARK: - Chat Actions
    
    func sendMessage(_ text: String) {
        guard !text.isEmpty else { return }
        
        // Add user message
        let userMessage = ChatMessage(text: text, isUser: true)
        chatMessages.append(userMessage)
        
        // TODO: Send to AI backend and get response
        // For now, simulate AI response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let aiResponse = self.generateAIResponse(for: text)
            let aiMessage = ChatMessage(text: aiResponse, isUser: false)
            self.chatMessages.append(aiMessage)
        }
    }
    
    private func generateAIResponse(for userMessage: String) -> String {
        // Simple mock responses
        let responses = [
            "I'm here to support you on your recovery journey. What's on your mind?",
            "That's a great question. Recovery is a process, and every step forward matters.",
            "Remember, setbacks are part of the journey. What matters is how you respond to them.",
            "I'm proud of you for reaching out. It takes courage to seek help.",
            "Let's explore that together. Can you tell me more about what you're experiencing?"
        ]
        return responses.randomElement() ?? responses[0]
    }
    
    func clearChat() {
        chatMessages = []
    }
}

