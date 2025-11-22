import SwiftUI

struct MenuView: View {
    var body: some View {
        List {
            Section("Account") {
                Label("Profile", systemImage: "person.circle")
                Label("Settings", systemImage: "gear")
            }
            Section("About") {
                Label("Version 1.0", systemImage: "info.circle")
            }
        }
        .navigationTitle("Menu")
    }
}

#Preview {
    NavigationStack { MenuView() }
}
