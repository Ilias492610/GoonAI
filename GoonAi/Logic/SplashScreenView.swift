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
                // Gradient background
                LinearGradient(
                    gradient: Gradient(colors: [Color.cyan.opacity(0.3), Color.blue.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    Spacer()
                    
                    // NoGoon Logo Text
                    Text("NOGOON")
                        .font(.system(size: 52, weight: .heavy, design: .rounded))
                        .tracking(6)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        .padding(.bottom, -15)
                    
                    FadingTextView(topLine: "Break free.", bottomLine: "Reclaim your life.")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white.opacity(0.9))
                    
                    VStack {
                        if showMedal {
                            Image(systemName: "heart.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundStyle(.white.opacity(0.8))
                        }
                    }
                    .frame(width: 80, height: 80)
                    
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
