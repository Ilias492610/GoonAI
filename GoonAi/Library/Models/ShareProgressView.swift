import SwiftUI

struct ShareProgressView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            StarryBackgroundView()
                .ignoresSafeArea()

            VStack(spacing: 24) {
                header
                summary
                shareButton
                Spacer()
            }
            .padding()
        }
    }

    private var header: some View {
        HStack {
            Spacer()
            Text("Share Progress")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Spacer()
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.4))
                    .clipShape(Circle())
            }
        }
    }

    private var summary: some View {
        VStack(spacing: 8) {
            Text("Your Progress")
                .font(.headline)
                .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 6) {
                Text("Current Streak: \(viewModel.currentStreak)")
                Text("Best Streak: \(viewModel.bestStreak)")
                Text("Current Level: \(viewModel.currentLevel)")
            }
            .font(.body)
            .foregroundColor(.white.opacity(0.9))
            .padding()
            .background(Color.black.opacity(0.3))
            .cornerRadius(12)
        }
        .frame(maxWidth: .infinity)
    }

    private var shareButton: some View {
        Button {
            viewModel.shareReferral()
        } label: {
            Text("Share")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}

struct ShareProgressView_Previews: PreviewProvider {
    class MockViewModel: ProfileViewModel {
        override init() {
            super.init()
            currentStreak = 5
            bestStreak = 10
            currentLevel = 3
        }

        override func shareReferral() {
            // mock share action
        }
    }

    static var previews: some View {
        ShareProgressView(viewModel: MockViewModel())
    }
}

// Dummy ProfileViewModel and StarryBackgroundView for preview compilation

class ProfileViewModel: ObservableObject {
    @Published var currentStreak: Int = 0
    @Published var bestStreak: Int = 0
    @Published var currentLevel: Int = 0

    func shareReferral() {
        // Placeholder share implementation
    }
}

struct StarryBackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.black, Color.blue]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
