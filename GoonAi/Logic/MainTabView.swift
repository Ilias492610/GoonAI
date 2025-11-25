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
         
            customTabBar
        }
    }

    private var customTabBar: some View {
        HStack(spacing: 8) {
            ForEach(MainTabs.allCases, id: \.self) { tab in
                tabButton(tab: tab)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    
    private func tabButton(tab: MainTabs) -> some View {
        Button(action: { selectTab(tab) }) {
            VStack(spacing: 6) {
                Image(systemName: tab.sfSymbol)
                    .font(.system(size: 22))
                    .foregroundColor(selectedTab == tab ? .cyan : .white.opacity(0.6))
                
                Text(tab.title)
                    .font(.caption2)
                    .fontWeight(selectedTab == tab ? .semibold : .regular)
                    .foregroundColor(selectedTab == tab ? .cyan : .white.opacity(0.6))
            }
            .frame(maxWidth: .infinity)
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
