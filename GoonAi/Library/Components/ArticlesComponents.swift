//
//  ArticlesComponents.swift
//  GoonAi
//
//  Articles list and detail views
//

import SwiftUI

// MARK: - Articles Index View

struct ArticlesIndexView: View {
    @ObservedObject var viewModel: LibraryViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedArticle: Article?
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Header
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
                        
                        Text("Articles")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Color.clear.frame(width: 44, height: 44)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Categories
                    ForEach(ArticleCategory.allCases) { category in
                        ArticleCategorySection(
                            category: category,
                            articles: viewModel.articles(for: category),
                            completionPercentage: viewModel.completionPercentage(for: category),
                            onArticleTap: { article in
                                selectedArticle = article
                            }
                        )
                    }
                    
                    Spacer(minLength: 100)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(item: $selectedArticle) { article in
            ArticleDetailView(article: article, viewModel: viewModel)
        }
    }
}

// MARK: - Article Category Section

struct ArticleCategorySection: View {
    let category: ArticleCategory
    let articles: [Article]
    let completionPercentage: Int
    let onArticleTap: (Article) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(category.rawValue)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(completionPercentage)% Complete")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(articles) { article in
                        ArticleCard(article: article, category: category) {
                            onArticleTap(article)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - Article Card

struct ArticleCard: View {
    let article: Article
    let category: ArticleCategory
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                // Number badge
                Circle()
                    .fill(category.color)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Text("\(article.index)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    )
                
                Spacer()
                
                Text(article.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if article.isCompleted {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Completed")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
            }
            .padding()
            .frame(width: 180, height: 200)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(category.color.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(category.color.opacity(0.5), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Article Detail View

struct ArticleDetailView: View {
    let article: Article
    @ObservedObject var viewModel: LibraryViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Header
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
                        
                        if !article.isCompleted {
                            Button {
                                viewModel.markArticleComplete(article.id)
                            } label: {
                                Text("Mark complete?")
                                    .font(.caption)
                                    .foregroundColor(.cyan)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Capsule().fill(.ultraThinMaterial))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Number badge
                    Circle()
                        .fill(article.category.color)
                        .frame(width: 70, height: 70)
                        .overlay(
                            Text("\(article.index)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        )
                        .padding(.top, 20)
                    
                    // Title
                    Text(article.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                    // Body
                    Text(article.body)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                        .lineSpacing(8)
                        .padding()
                        .glassEffect()
                        .padding(.horizontal)
                    
                    // Mark complete button
                    if !article.isCompleted {
                        Button {
                            viewModel.markArticleComplete(article.id)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                dismiss()
                            }
                        } label: {
                            HStack {
                                Text("Mark as complete")
                                Image(systemName: "checkmark")
                            }
                            .font(.headline)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                            )
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    } else {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("Completed")
                                .font(.headline)
                                .foregroundColor(.green)
                        }
                        .padding(.top, 20)
                    }
                    
                    Spacer(minLength: 100)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

