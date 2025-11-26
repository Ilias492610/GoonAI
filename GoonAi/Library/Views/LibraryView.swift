//
//  LibraryView.swift
//  GoonAi
//
//  Main Library tab view for NoGoon
//

import SwiftUI

struct LibraryView: View {
    @StateObject private var viewModel = LibraryViewModel()
    @State private var showArticles = false
    @State private var showPodcasts = false
    @State private var showLibraryBooks = false
    @State private var showMeditation = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Starry background
                StarryBackgroundView()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        // Header
                        Text("Library")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.top, 10)
                        
                        // Subtitle
                        Text("Explore resources to support your recovery journey")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.horizontal)
                            .padding(.top, -16)
                        
                        // Learning Resources section
                        learningResourcesSection
                        
                        // Featured Content section
                        featuredContentSection
                        
                        // Quick Stats section
                        quickStatsSection
                        
                        // Next lesson card
                        nextLessonCard
                        
                        Spacer(minLength: 100)
                    }
                }
            }
            .navigationDestination(isPresented: $showArticles) {
                ArticlesIndexView(viewModel: viewModel)
            }
            .navigationDestination(isPresented: $showMeditation) {
                MeditationView()
            }
            .navigationDestination(isPresented: $showPodcasts) {
                PodcastsView()
            }
            .navigationDestination(isPresented: $showLibraryBooks) {
                LibraryBooksView()
            }
        }
    }
    
    // MARK: - Learning Resources Section
    
    private var learningResourcesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Learning Resources")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            // 2x2 grid of resource cards styled like app mocks
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                // Articles Card
                Button {
                    showArticles = true
                } label: {
                    ResourceCard(
                        icon: "text.book.closed.fill",
                        title: "Articles",
                        color: Color(red: 200/255, green: 121/255, blue: 65/255)
                    )
                }
                .buttonStyle(.plain)
                
                // Meditate Card
                Button {
                    showMeditation = true
                } label: {
                    ResourceCard(
                        icon: "sun.max.fill",
                        title: "Meditate",
                        color: Color(red: 77/255, green: 58/255, blue: 129/255)
                    )
                }
                .buttonStyle(.plain)
                
                // Library Card
                Button {
                    showLibraryBooks = true
                } label: {
                    ResourceCard(
                        icon: "books.vertical.fill",
                        title: "Library",
                        color: Color(red: 178/255, green: 92/255, blue: 149/255)
                    )
                }
                .buttonStyle(.plain)
                
                // Podcast Card
                Button {
                    showPodcasts = true
                } label: {
                    ResourceCard(
                        icon: "headphones",
                        title: "Podcast",
                        color: Color(red: 53/255, green: 118/255, blue: 196/255)
                    )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Featured Content Section
    
    private var featuredContentSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Featured")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    FeaturedCard(
                        icon: "book.fill",
                        title: "Recovery Articles",
                        subtitle: "12 articles",
                        color: Color(red: 200/255, green: 121/255, blue: 65/255)
                    ) {
                        showArticles = true
                    }
                    
                    FeaturedCard(
                        icon: "headphones",
                        title: "Expert Podcasts",
                        subtitle: "5 episodes",
                        color: Color(red: 53/255, green: 118/255, blue: 196/255)
                    ) {
                        showPodcasts = true
                    }
                    
                    FeaturedCard(
                        icon: "video.fill",
                        title: "Video Library",
                        subtitle: "6 videos",
                        color: Color(red: 178/255, green: 92/255, blue: 149/255)
                    ) {
                        showLibraryBooks = true
                    }
                    
                    FeaturedCard(
                        icon: "leaf.fill",
                        title: "Guided Meditation",
                        subtitle: "Find peace",
                        color: Color(red: 77/255, green: 58/255, blue: 129/255)
                    ) {
                        showMeditation = true
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    // MARK: - Quick Stats Section
    
    private var quickStatsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Progress")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            HStack(spacing: 12) {
                StatCard(
                    value: "\(viewModel.articles.filter { $0.isCompleted }.count)",
                    label: "Completed",
                    icon: "checkmark.circle.fill",
                    color: .green
                )
                
                StatCard(
                    value: "\(viewModel.articles.count - viewModel.articles.filter { $0.isCompleted }.count)",
                    label: "Remaining",
                    icon: "book.fill",
                    color: .orange
                )
                
                StatCard(
                    value: "\(Int((Double(viewModel.articles.filter { $0.isCompleted }.count) / Double(viewModel.articles.count)) * 100))%",
                    label: "Progress",
                    icon: "chart.bar.fill",
                    color: .blue
                )
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
    
}

// MARK: - Featured Card

struct FeaturedCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    Circle()
                        .fill(color.opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .font(.system(size: 22))
                        .foregroundColor(color)
                }
                
                // Text
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
            }
            .padding()
            .frame(width: 240)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(color.opacity(0.3), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Stat Card

struct StatCard: View {
    let value: String
    let label: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
        )
    }
}

// MARK: - Resource Card

struct ResourceCard: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(color)
                .frame(height: 90)
            
            // Icon in top right
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(12)
            
            // Title in bottom left
            Text(title)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(16)
        }
        .shadow(color: color.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Placeholder Views for Navigation

struct PodcastsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    // Header with back button
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
                        
                        Text("Podcasts")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Color.clear.frame(width: 44, height: 44)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Podcasts Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Podcasts")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            ForEach(PodcastResource.samplePodcasts) { podcast in
                                PodcastCard(podcast: podcast) {
                                    if let url = URL(string: podcast.url) {
                                        openURL(url)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Thank You Message
                    VStack(spacing: 8) {
                        Text("Many of these podcasts were recommended by our amazing community.")
                            .font(.body)
                            .foregroundColor(Color(red: 180/255, green: 185/255, blue: 205/255))
                            .multilineTextAlignment(.center)
                        
                        Text("Thank you all for your contributions and support! 💙")
                            .font(.body)
                            .foregroundColor(Color(red: 180/255, green: 185/255, blue: 205/255))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 100)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Podcast Card

struct PodcastCard: View {
    let podcast: PodcastResource
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // Podcast icon
                Circle()
                    .fill(Color(red: 88/255, green: 101/255, blue: 242/255).opacity(0.1))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "mic.fill")
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 88/255, green: 101/255, blue: 242/255))
                    )
                
                // Podcast content
                VStack(alignment: .leading, spacing: 4) {
                    Text(podcast.title)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Text(podcast.host)
                            .font(.subheadline)
                            .foregroundColor(Color(red: 180/255, green: 185/255, blue: 205/255))
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .font(.system(size: 12))
                            Text(podcast.duration)
                                .font(.subheadline)
                        }
                        .foregroundColor(Color(red: 180/255, green: 185/255, blue: 205/255))
                    }
                    
                    Text(podcast.description)
                        .font(.caption)
                        .foregroundColor(Color(red: 180/255, green: 185/255, blue: 205/255))
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 4)
                    
                    // Category badge
                    Text(podcast.category)
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 88/255, green: 101/255, blue: 242/255))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(red: 88/255, green: 101/255, blue: 242/255).opacity(0.1))
                        )
                }
                
                // Play icon
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(Color(red: 88/255, green: 101/255, blue: 242/255))
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(red: 21/255, green: 27/255, blue: 69/255))
                    .shadow(color: Color.black.opacity(0.25), radius: 3.84, x: 0, y: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

struct LibraryBooksView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    // Header with back button
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
                        
                        Text("Resources")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Color.clear.frame(width: 44, height: 44)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Videos Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Videos")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(VideoResource.sampleVideos) { video in
                                    VideoCard(video: video) {
                                        if let url = URL(string: video.url) {
                                            openURL(url)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Scientific Articles Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Scientific Articles")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            ForEach(ScientificArticle.sampleArticles) { article in
                                ScientificArticleCard(article: article) {
                                    if let url = URL(string: article.url) {
                                        openURL(url)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Books Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Books")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(BookResource.sampleBooks) { book in
                                    BookCard(book: book) {
                                        if let url = URL(string: book.url) {
                                            openURL(url)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Thank You Message
                    VStack(spacing: 8) {
                        Text("Many of these resources were recommended by our amazing community.")
                            .font(.body)
                            .foregroundColor(Color(red: 180/255, green: 185/255, blue: 205/255))
                            .multilineTextAlignment(.center)
                        
                        Text("Thank you all for your contributions and support! 💙")
                            .font(.body)
                            .foregroundColor(Color(red: 180/255, green: 185/255, blue: 205/255))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 100)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Video Card

struct VideoCard: View {
    let video: VideoResource
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                // Thumbnail with duration badge
                ZStack(alignment: .bottomTrailing) {
                    AsyncImage(url: URL(string: video.thumbnail)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                    }
                    .frame(width: 280, height: 160)
                    .clipped()
                    
                    // Duration badge
                    Text(video.duration)
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.black.opacity(0.7))
                        )
                        .padding(8)
                }
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(video.title)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(2)
                    
                    Text(video.channel)
                        .font(.subheadline)
                        .foregroundColor(Color(red: 180/255, green: 185/255, blue: 205/255))
                    
                    // Category badge
                    Text(video.category)
                        .font(.system(size: 9))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 88/255, green: 101/255, blue: 242/255))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(red: 88/255, green: 101/255, blue: 242/255).opacity(0.1))
                        )
                }
                .padding(12)
            }
            .frame(width: 280)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(red: 21/255, green: 27/255, blue: 69/255))
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Scientific Article Card

struct ScientificArticleCard: View {
    let article: ScientificArticle
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(article.title)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Text(article.source)
                            .font(.subheadline)
                            .foregroundColor(Color(red: 180/255, green: 185/255, blue: 205/255))
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .font(.system(size: 12))
                            Text(article.readTime)
                                .font(.subheadline)
                        }
                        .foregroundColor(Color(red: 180/255, green: 185/255, blue: 205/255))
                    }
                    
                    // Category badge
                    Text(article.category)
                        .font(.system(size: 9))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 88/255, green: 101/255, blue: 242/255))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(red: 88/255, green: 101/255, blue: 242/255).opacity(0.1))
                        )
                }
                
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(red: 180/255, green: 185/255, blue: 205/255))
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(red: 21/255, green: 27/255, blue: 69/255))
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Book Card

struct BookCard: View {
    let book: BookResource
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                Text(book.title)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                Text(book.author)
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 180/255, green: 185/255, blue: 205/255))
                
                // Category badge
                Text(book.category)
                    .font(.system(size: 9))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 88/255, green: 101/255, blue: 242/255))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(red: 88/255, green: 101/255, blue: 242/255).opacity(0.1))
                    )
            }
            .padding(12)
            .frame(width: 140)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(red: 21/255, green: 27/255, blue: 69/255))
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LibraryView()
}
