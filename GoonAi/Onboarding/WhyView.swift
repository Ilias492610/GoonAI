import SwiftUI

struct WhyView: View {
    @State private var currentPage = 0
    let onComplete: () -> Void
    let pages: [(icon: String, title: String, subtitle: String)] = [
        ("brain.head.profile", "Porn is a drug", "Using porn releases dopamine in the brain. This chemical makes you feel good—it's why you feel pleasure when you watch porn."),
        ("heart.slash.fill", "Porn destroys relationships", "Porn reduces your hunger for a real relationship and replaces it with the hunger for more porn."),
        ("bolt.slash.fill", "Porn shatters sex drive", "More than 50% of porn users report a loss of interest in real sex, and an overall decrease in their sex drive."),
        ("face.dashed.fill", "Feeling unhappy?", "An elevated dopamine level means you need more dopamine to feel good. This is why so many heavy porn users report feeling depressed, unmotivated, and anti-social."),
        ("leaf.fill", "Path to Recovery", "Recovery is possible. By abstaining from porn, your brain can reset its dopamine sensitivity, leading to healthier relationships and improved well-being."),
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
            
            VStack {
                Text("QUITTR")
                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .tracking(3)
                    .padding(.top, 60)
                
                Spacer()
                
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        VStack(spacing: 30) {
                            Image(systemName: pages[index].icon)
                                .font(.system(size: 80))
                                .foregroundColor(.white)
                                .padding(.bottom, 20)
                            
                            Text(pages[index].title)
                                .font(.system(size: 28, weight: .bold))
                                .padding(.bottom, 10)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text(pages[index].subtitle)
                                .font(.system(size: 17))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white.opacity(0.9))
                                .frame(width: 335)
                        }
                        .padding()
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 500)
                
                Spacer()
                
                PageIndicator(color: .white, currentPage: $currentPage, pageCount: pages.count)
                    .padding(.top, 20)
                
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    if currentPage == pages.count - 1 {
                        onComplete()
                    } else {
                        withAnimation {
                            currentPage += 1
                        }
                    }
                }) {
                    HStack {
                        Text("Next")
                        Image(systemName: "chevron.right")
                    }
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

struct PageIndicator: View {
    let color: Color
    @Binding var currentPage: Int
    let pageCount: Int
    
    var body: some View {
        HStack(spacing: 6.5) {
            ForEach(0..<pageCount, id: \.self) { page in
                Circle()
                    .fill(page == currentPage ? Color.white : Color(.systemGray2))
                    .frame(width: 8, height: 8)
            }
        }
    }
}
