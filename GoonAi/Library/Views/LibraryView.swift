//
//  LibraryView.swift
//  GoonAi
//
//  Main Library tab view for NoGoon
//

import SwiftUI

struct LibraryView: View {
    @StateObject private var viewModel = LibraryViewModel()
    @State private var showMindfulnessPlayer: AudioTrack?
    @State private var showArticles = false
    @State private var showMelius = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Starry background
                StarryBackgroundView()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Header
                        Text("Library")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.top, 10)
                        
                        // Winter Arc card
                        WinterArcCard()
                        
                        // Mindfulness section
                        mindfulnessSection
                        
                        // Next lesson card
                        nextLessonCard
                        
                        // Melius card
                        meliusCard
                        
                        // Life Tree card
                        lifeTreeCard
                        
                        Spacer(minLength: 100)
                    }
                }
            }
            .sheet(item: $showMindfulnessPlayer) { track in
                MindfulnessPlayerView(track: track, viewModel: viewModel)
            }
            .navigationDestination(isPresented: $showArticles) {
                ArticlesIndexView(viewModel: viewModel)
            }
            .navigationDestination(isPresented: $showMelius) {
                MeliusChatView(viewModel: viewModel)
            }
        }
    }
    
    // MARK: - Mindfulness Section
    
    private var mindfulnessSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Mindfulness")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.horizontal)
            
            // 2x2 grid of audio cards
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(viewModel.audioTracks) { track in
                    MindfulnessAudioCard(track: track) {
                        showMindfulnessPlayer = track
                        viewModel.playAudio(track)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Next Lesson Card
    
    private var nextLessonCard: some View {
        Button {
            showArticles = true
        } label: {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your next lesson")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.7))
                    
                    if let nextLesson = viewModel.nextLesson {
                        Text("\(viewModel.lessonProgress) • \(nextLesson.title)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .lineLimit(2)
                    } else {
                        Text("All lessons completed! 🎉")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                Image(systemName: "book.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Circle().fill(Color.white.opacity(0.2)))
            }
            .padding()
            .glassEffect()
            .padding(.horizontal)
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Melius Card
    
    private var meliusCard: some View {
        Button {
            showMelius = true
        } label: {
            HStack(spacing: 16) {
                Image(systemName: "message.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Circle().fill(Color.purple.opacity(0.3)))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Melius")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("AI-powered therapy and support")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
            }
            .padding()
            .glassEffect()
            .padding(.horizontal)
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Life Tree Card
    
    private var lifeTreeCard: some View {
        Button {
            // TODO: Navigate to Life Tree view
        } label: {
            HStack(spacing: 16) {
                Image(systemName: "leaf.fill")
                    .font(.title)
                    .foregroundColor(.green)
                    .frame(width: 60, height: 60)
                    .background(Circle().fill(Color.green.opacity(0.2)))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Life Tree")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Visualize your recovery progress")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
            }
            .padding()
            .glassEffect()
            .padding(.horizontal)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Winter Arc Card

struct WinterArcCard: View {
    var body: some View {
        Button {
            // TODO: Navigate to Winter Arc tracking
        } label: {
            HStack(spacing: 16) {
                Image(systemName: "figure.strengthtraining.traditional")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.3))
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Winter Arc")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Track your daily habits")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
            }
            .padding()
            .glassEffect()
            .padding(.horizontal)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LibraryView()
}

