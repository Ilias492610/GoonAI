import SwiftUI

 struct SplashScreenView: View {
    @State private var isActive = false
    @State private var showMedal = false
    @State private var offset: CGFloat = 200
    @State private var rotation: Double = 30
    @State private var opacity: Double = 0
    
    var body: some View {
        if isActive {
            SubRootView()
        } else {
            ZStack {
                // Gradient background (matching QUITTR)
                LinearGradient(
                    colors: [
                        Color(red: 0.2, green: 0.6, blue: 0.8),
                        Color(red: 0.1, green: 0.3, blue: 0.6)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                StarryBackgroundView()
                
                VStack(spacing: 24) {
                    Spacer()
                    
                    // NoGoon Logo Text
                    Text("NOGOON")
                        .font(.system(size: 42, weight: .heavy, design: .rounded))
                        .tracking(4)
                        .foregroundColor(.white)
                    
                    VStack(spacing: 16) {
                        FadingTextView(topLine: "Embrace this pause.", bottomLine: "Reflect before you relapse.")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                .offset(y: offset)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeOut(duration: 0.8)) {
                        offset = 0
                        opacity = 1
                    }
                }
                .rotation3DEffect(
                    .degrees(rotation),
                    axis: (x: 1.0, y: 0.0, z: 0.0),
                    perspective: 0.3
                )
                .onAppear {
                    withAnimation(.easeOut(duration: 0.8).delay(0.4)) {
                        rotation = 0
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                        withAnimation {
                            showMedal.toggle()
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.2) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct FadingTextView: View {
    let topLine: String
    let bottomLine: String
    @State private var topLineProgress: CGFloat = 0
    @State private var bottomLineProgress: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 4) {
            Text(LocalizedStringKey(topLine))
                .modifier(FadingTextModifier(progress: topLineProgress))
                .multilineTextAlignment(.center)
            Text(LocalizedStringKey(bottomLine))
                .modifier(FadingTextModifier(progress: bottomLineProgress))
                .multilineTextAlignment(.center)
        }
        .onAppear {
            withAnimation(.snappy(duration: 2.5)) {
                topLineProgress = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.75) {
                withAnimation(.snappy(duration: 2.5)) {
                    bottomLineProgress = 1
                }
            }
        }
    }
}

struct FadingTextModifier: AnimatableModifier {
    var progress: CGFloat
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .mask(
                GeometryReader { geometry in
                    Rectangle()
                        .size(width: geometry.size.width * progress, height: geometry.size.height)
                }
            )
    }
}
