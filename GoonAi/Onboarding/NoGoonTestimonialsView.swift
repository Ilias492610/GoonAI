//
//  NoGoonTestimonialsView.swift
//  GoonAi
//
//  Testimonials pages (matching QUITTR testimonial screens)
//

import SwiftUI

struct NoGoonTestimonialsView: View {
    @State private var currentPage = 0
    let onComplete: () -> Void
    
    private let pages: [TestimonialPage] = [
        TestimonialPage(
            title: "QUITTR helps you quit porn 76% faster than willpower alone. 📈",
            testimonials: [
                Testimonial(name: "Connor", username: "@connor", isAnonymous: true, text: "Quitting has allowed me to change my mindset on the little things in life.\n\nI was coming to grips with the fact that life is dark, boring, depressing and then I die. Screw that. Quitting has allowed me to change my mindset on the little things in life."),
                Testimonial(name: "Finch", username: "@finch", isAnonymous: true, text: "I'm finally living up to my potential and it feels incredible.\n\nMy focus and productivity at work have improved dramatically. I'm finally living up to my potential and it feels incredible."),
                Testimonial(name: "Anonymous", username: "@user", isAnonymous: true, text: "Life feels colorful again, and I'm excited about the future.\n\nI'm rediscovering hobbies and interests I had forgotten about. Life feels colorful again, and I'm excited about the future.")
            ],
            showChart: true
        ),
        TestimonialPage(
            title: "QUITTR helps you quit porn 76% faster than willpower alone. 📈",
            testimonials: [
                Testimonial(name: "Anonymous", username: "@user", isAnonymous: true, text: "I'm more present and engaged in conversations.\n\nMy relationships with friends and family have deepened. I'm more present and engaged in conversations, and people have noticed the change."),
                Testimonial(name: "Anonymous", username: "@user", isAnonymous: true, text: "This decision has changed my life for the better in ways I never imagined.\n\nA year later, I can confidently say this decision has changed my life for the better in ways I never imagined. The journey wasn't easy, but it was worth every step.")
            ],
            showChart: false
        ),
        TestimonialPage(
            title: "QUITTR helps you quit porn 76% faster than willpower alone. 📈",
            testimonials: [
                Testimonial(name: "Andrew Huberman, Ph.D.", username: "@hubermanlab", isAnonymous: false, text: "Drastically improve your life\n\nResetting your dopamine balance by taking a break from highly stimulating content can dramatically improve motivation, emotional stability, and everyday pleasure."),
                Testimonial(name: "Steven Bartlett", username: "@steven", isAnonymous: false, text: "There's no good in porn\n\nPornography doesn't have an educational role—it's only an open window for a market that brings more emptiness and addiction that profit to porn."),
                Testimonial(name: "Connor", username: "@connor", isAnonymous: true, text: "Quitting has allowed me to change my mindset on the little things in life.\n\nI was coming to grips with the fact that life is dark, boring, depressing and then I die. Screw that. Quitting has allowed me to change my mindset on the little things in life.")
            ],
            showChart: false
        )
    ]
    
    var body: some View {
        ZStack {
            // Dark gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.1, blue: 0.2),
                    Color(red: 0.1, green: 0.15, blue: 0.3)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Back button and title
                HStack {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        if currentPage > 0 {
                            withAnimation {
                                currentPage -= 1
                            }
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                    
                    Spacer()
                    
                    Text(pages[currentPage].title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44)
                }
                .padding(.horizontal)
                .padding(.top, 60)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        if pages[currentPage].showChart {
                            // Chart image placeholder
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 120))
                                .foregroundColor(.green)
                                .padding(.vertical, 40)
                        }
                        
                        ForEach(pages[currentPage].testimonials) { testimonial in
                            TestimonialCard(testimonial: testimonial)
                        }
                        
                        Spacer().frame(height: 100)
                    }
                    .padding()
                }
                
                // Continue button
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    if currentPage < pages.count - 1 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        onComplete()
                    }
                }) {
                    Text("Continue")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
        }
    }
}

// MARK: - Models

struct TestimonialPage {
    let title: String
    let testimonials: [Testimonial]
    let showChart: Bool
}

struct Testimonial: Identifiable {
    let id = UUID()
    let name: String
    let username: String
    let isAnonymous: Bool
    let text: String
}

// MARK: - Testimonial Card

struct TestimonialCard: View {
    let testimonial: Testimonial
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                // Avatar
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Text(testimonial.isAnonymous ? "QUITTR" : String(testimonial.name.prefix(1)))
                            .font(.headline)
                            .foregroundColor(.white)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(testimonial.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        if !testimonial.isAnonymous {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.cyan)
                        }
                    }
                    
                    Text(testimonial.username)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Spacer()
            }
            
            Text(testimonial.text)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.1))
        )
    }
}

