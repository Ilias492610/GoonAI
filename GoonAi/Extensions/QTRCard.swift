import SwiftUI

struct QTRCard: View {
    @AppStorage("name") private var name: String = ""
    @State private var offset: CGFloat = 1000
    @State private var rotation: Double = 89.9
      @State private var opacity: Double = 0
    
    private var freeSinceDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return formatter.string(from: Date())
    }
    
    var body: some View {
        ZStack {
                  // Background with gradient image
            ZStack {
                Image("Circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 400)
                    .cornerRadius(16)
                Image("recgradient2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 400)
                    .cornerRadius(16)
            }
                  
                  VStack(alignment: .leading, spacing: 0) {
                      // Top part of the card
                      VStack(alignment: .leading, spacing: 16) {
                          HStack {
                              // NGN Logo
                              ZStack {
                                  Circle()
                                      .stroke(Color.white, lineWidth: 2)
                                      .frame(width: 44, height: 44)
                                  Text("NGN")
                                      .font(.system(size: 10, weight: .bold))
                                      .foregroundColor(.white)
                              }
                              Spacer()
                              Image(systemName: "person.crop.circle.badge")
                                  .renderingMode(.template)
                                  .resizable()
                                  .scaledToFit()
                                  .foregroundColor(Color.white)
                                  .frame(width: 24, height: 24)
                          }
                          .padding(.horizontal)
                          
                          Spacer()
                          
                          VStack(alignment: .leading, spacing: 4) {
                              Text(LocalizedStringKey("Active Streak"))
                                  .foregroundColor(.white.opacity(0.8))
                                  .font(.custom("DMSans-Medium", size: 12))
                              
                              Text("0 days")
                                  .foregroundColor(.white)
                                  .font(.custom("DMSans-Medium", size: 26))
                          }
                      }
                      .padding(24)
                      
                      Spacer()
                      
                      // Bottom part of the card
                      HStack {
                          VStack(alignment: .leading) {
                              Text(LocalizedStringKey("Free since"))
                                  .foregroundColor(.white.opacity(0.8))
                                  .font(.custom("DMSans-Medium", size: 12))
                              Text(freeSinceDate)
                                  .foregroundColor(.white)
                                  .font(.custom("DMSans-Medium", size: 16))
                          }
                          
                              Spacer()
                      }
                      .padding(24)
                      .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "3E3C3D"), Color(hex: "2C2C2C")]), startPoint: .leading, endPoint: .trailing))
                  }
              }
              .frame(width: 280, height: 400)
              .cornerRadius(25)
              .offset(y: offset)
                    .rotation3DEffect(
                        .degrees(rotation),
                        axis: (x: 1.0, y: 0.0, z: 0.0)
                    )
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeOut(duration: 0.8)) {
                            offset = 0
                            rotation = 0 // Rotate to 0 degrees during the animation
                            opacity = 1
                        }
                    }
    }
}
