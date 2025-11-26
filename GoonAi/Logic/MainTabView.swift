import SwiftUI

enum MainTabs: Int, CaseIterable {
    case home, analytics, library, community, profile
    
    var sfSymbol: String {
        switch self {
        case .home: return "house.fill"
        case .analytics: return "chart.bar.fill"
        case .library: return "books.vertical.fill"
        case .community: return "person.3.fill"
        case .profile: return "person.circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .analytics: return "Analytics"
        case .library: return "Library"
        case .community: return "Community"
        case .profile: return "Profile"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: MainTabs = .home
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        ZStack(alignment: .bottom) {
            StarryBackgroundView()
                .ignoresSafeArea()
                .allowsHitTesting(false)
            
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(MainTabs.home)

                AnalyticsView()
                    .tag(MainTabs.analytics)
                
                LibraryView()
                    .tag(MainTabs.library)
                
                CommunityView()
                    .tag(MainTabs.community)
                
                ProfileView()
                    .tag(MainTabs.profile)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(Color.clear)
            .onReceive(NotificationCenter.default.publisher(for: .navigateToAnalytics)) { _ in
                selectTab(.analytics)
            }
         
            customTabBar
        }
    }

    private var customTabBar: some View {
        HStack(spacing: 6) {
            ForEach(MainTabs.allCases, id: \.self) { tab in
                tabButton(tab: tab)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.02, green: 0.03, blue: 0.12).opacity(0.92),
                            Color(red: 0.06, green: 0.08, blue: 0.2)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
    
    private func tabButton(tab: MainTabs) -> some View {
        let isSelected = selectedTab == tab
        let accentColor = Color(red: 0.35, green: 0.92, blue: 0.95)
        return Button(action: { selectTab(tab) }) {
            VStack(spacing: 6) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: isSelected
                                ? [Color.white.opacity(0.25), Color.white.opacity(0.08)]
                                : [Color.white.opacity(0.12), Color.white.opacity(0.03)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 54, height: 38)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(isSelected ? accentColor.opacity(0.85) : Color.white.opacity(0.08), lineWidth: 1)
                        )
                        .shadow(color: isSelected ? accentColor.opacity(0.35) : Color.clear, radius: 12, x: 0, y: 6)
                        .opacity(isSelected ? 1 : 0.55)
                    Image(systemName: tab.sfSymbol)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(isSelected ? accentColor : .white.opacity(0.82))
                }
                
                Text(tab.title)
                    .font(.caption2)
                    .fontWeight(isSelected ? .semibold : .regular)
                    .foregroundColor(isSelected ? accentColor : .white.opacity(0.72))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 2)
        }
        .buttonStyle(.plain)
    }
    
    private func selectTab(_ tab: MainTabs) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        selectedTab = tab
    }
    
    private func selectRecoveryTab() {
        selectTab(.analytics)
    }
}
