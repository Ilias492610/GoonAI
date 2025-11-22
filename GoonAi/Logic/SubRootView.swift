import SwiftUI
#if canImport(SuperwallKit)
import SuperwallKit
#endif

struct SubRootView: View {

    var body: some View {
        Group {
#if canImport(SuperwallKit)
            if Superwall.shared.subscriptionStatus.isActive {
                MainTabView()
            } else if Constants.isOnboarded {
                PaywallView(onComplete: {})
            } else {
                Root()
            }
#else
            // Fallback when SuperwallKit is not available
            if Constants.isOnboarded {
                PaywallView(onComplete: {})
            } else {
                Root()
            }
#endif
        }
    }
}
