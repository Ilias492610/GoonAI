import SwiftUI
import StoreKit

struct ReviewScreenView: View {
    let onComplete: () -> Void
    @State private var didRequestReview = false
    
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
            
            VStack(spacing: 20) {
                Spacer()
                
                // Back button
                HStack {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        // Just continue - no back navigation needed
                        onComplete()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 60)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        // Title
                        Text("Give us a rating")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        
                        // Star rating display
                        HStack(spacing: 0) {
                            Image(systemName: "laurel.leading")
                                .font(.system(size: 40))
                                .foregroundColor(.white.opacity(0.8))
                            
                            HStack(spacing: 4) {
                                ForEach(0..<5) { _ in
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 28))
                                        .foregroundColor(.yellow)
                                }
                            }
                            .padding(.horizontal, 20)
                            
                            Image(systemName: "laurel.trailing")
                                .font(.system(size: 40))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.vertical, 20)
                        
                        // Social proof
                        VStack(spacing: 10) {
                            Text("This app was designed for people like you.")
                                .multilineTextAlignment(.center)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            HStack(spacing: -8) {
                                ForEach(0..<3) { index in
                                    Circle()
                                        .fill(Color.gray.opacity(0.5))
                                        .frame(width: 32, height: 32)
                                        .overlay(
                                            Text("Q")
                                                .font(.caption)
                                                .foregroundColor(.white)
                                        )
                                }
                                
                                Text("+ 1,000,000 people")
                                    .foregroundColor(.white.opacity(0.8))
                                    .padding(.leading, 16)
                            }
                        }
                        
                        // Testimonials
                        VStack(spacing: 15) {
                            NoGoonReviewCard(
                                name: "Michael Stevens",
                                username: "@michaels",
                                review: "QUITTR has been a lifesaver for me. The progress tracking and motivational notifications have kept me on track. I haven't watched porn in 3 months and feel more in control of my life."
                            )
                            
                            NoGoonReviewCard(
                                name: "Tony Coleman",
                                username: "@tcoleman23",
                                review: "I was skeptical at first, but QUITTR's panic button feature has helped me resist temptation multiple times. The app's educational content has also opened my eyes to the negative effects of porn. Highly recommend!"
                            )
                            
                            NoGoonReviewCard(
                                name: "David Lee",
                                username: "@davidleeeee",
                                review: "Thanks to QUITTR, I've been able to quit porn and focus on healthier habits. The app's adult content blocker is incredibly effective, and the benefits of quitting have been amazing."
                            )
                        }
                    }
                    .padding()
                    .padding(.bottom, 100)
                }
                
                // Next button
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    onComplete()
                }) {
                    Text("Next")
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
        .onAppear {
            // Request review using modern API
            if !didRequestReview {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: scene)
                        didRequestReview = true
                    }
                }
            }
        }
    }
}

// MARK: - NoGoon Review Card

struct NoGoonReviewCard: View {
    let name: String
    let username: String
    let review: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                // Avatar placeholder
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Text(String(name.prefix(1)))
                            .font(.headline)
                            .foregroundColor(.white)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(username)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Spacer()
                
                // Stars
                HStack(spacing: 2) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                }
            }
            
            Text(review)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white.opacity(0.1))
        )
    }
}
