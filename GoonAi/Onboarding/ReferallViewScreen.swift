import SwiftUI
import AppTrackingTransparency

struct ReferralCodeView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("referallCode") private var text: String = ""
    let onComplete: () -> Void

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

            VStack(alignment: .leading) {
                // Back button
                HStack {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        // Just skip - no actual back needed
                        save()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                    Spacer()
                }
                .padding(.top, 60)

                Text("Do you have a referral code?")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.bottom, 6)

                Text("You can skip this step.")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.bottom, 15)
                    .fontWeight(.semibold)

                Spacer()

                TextField("Referral Code", text: $text)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 35)
                            .fill(Color.white.opacity(0.15))
                            .overlay(
                                RoundedRectangle(cornerRadius: 35)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                    )
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.medium)
                    .tint(.white)

                Spacer()

                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    save()
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
            }
            .padding()
            .onTapGesture {
                endEditing(force: true)
            }
            .onAppear {
                requestAppTrackingPermission()
            }
        }
    }

    // MARK: - Helpers
    func save() {
        if !text.isEmpty {
            let analyticsProperties = ["Code": text]
            AnalyticsManager.shared.trackEvent(eventName: "Referrals", properties: analyticsProperties)
            AnalyticsManager.shared.updateUserAttributes(attributes: analyticsProperties)
        }
        onComplete()
    }

    func requestAppTrackingPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Permission granted, you can now access the IDFA.
                    print("Tracking authorized")
                case .denied:
                    // Permission denied.
                    print("Tracking denied")
                case .notDetermined:
                    // Permission hasn't been requested yet.
                    print("Tracking status not determined")
                case .restricted:
                    // Permission restricted.
                    print("Tracking restricted")
                @unknown default:
                    print("Unknown tracking status")
                }
            }
        } else {
            // Fallback for earlier iOS versions
            print("iOS version does not support App Tracking Transparency.")
        }
    }
}

extension View {
    func endEditing(force: Bool) {
        #if os(iOS)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.forEach { $0.endEditing(true) }
        #endif
    }
}
