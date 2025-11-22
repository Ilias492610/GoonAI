//
//  GoonAiApp.swift
//  GoonAi
//
//  Created by Alex Slater on 19/8/25.
//  Migrated for GoonAi by ilias hamdaoui on 20/11/2025.
//

import SwiftUI
import UIKit
#if canImport(SuperwallKit)
import SuperwallKit
#endif

#if !canImport(SuperwallKit)
enum SuperwallShim {
    static func configure(apiKey: String) {}
    static func register(placement: String) {}
}
#endif

// MARK: - Quick Action Types
enum QuickAction: String {
    case sendFeedback = "com.goonai.sendFeedback"
    case annualPlan   = "com.goonai.annualPlan"
}

// MARK: - Notification for routing quick actions to SwiftUI (warm app)
extension Notification.Name {
    static let didTriggerQuickAction = Notification.Name("didTriggerQuickAction")
}

// MARK: - AppDelegate (handles Superwall + Quick Actions)
final class AppDelegate: NSObject, UIApplicationDelegate {
    static var pendingQuickAction: QuickAction?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
#if canImport(SuperwallKit)
        Superwall.configure(apiKey: "superwall-key-here")
#else
        SuperwallShim.configure(apiKey: "superwall-key-here")
#endif
        updateQuickActions(for: application)
        return true
    }

    func application(
        _ application: UIApplication,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        let handled = handle(shortcutItem: shortcutItem)
        completionHandler(handled)
    }

    @discardableResult
    private func handle(shortcutItem: UIApplicationShortcutItem) -> Bool {
        guard let action = QuickAction(rawValue: shortcutItem.type) else { return false }

        AppDelegate.pendingQuickAction = action

        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: .didTriggerQuickAction,
                object: nil,
                userInfo: ["action": action]
            )
        }
        return true
    }

    private func updateQuickActions(for application: UIApplication) {
        var items: [UIApplicationShortcutItem] = []

        let feedbackItem = UIApplicationShortcutItem(
            type: QuickAction.sendFeedback.rawValue,
            localizedTitle: "Deleting? Tell us why.",
            localizedSubtitle: "Send feedback before you delete",
            icon: UIApplicationShortcutIcon(systemImageName: "square.and.pencil")
        )
        items.append(feedbackItem)

        let annualPlanItem = UIApplicationShortcutItem(
            type: QuickAction.annualPlan.rawValue,
            localizedTitle: "🚨 TRY FOR FREE",
            localizedSubtitle: "Get unlimited access to the GoonAi app",
            icon: UIApplicationShortcutIcon(systemImageName: "gift")
        )
        items.append(annualPlanItem)

        application.shortcutItems = items
    }
}

// MARK: - SwiftUI App
@main
struct GoonAiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.openURL) private var openURL
    @Environment(\.scenePhase) private var scenePhase
    private let websiteURL = URL(string: "https://forms.gle/2yh1WAr8aNqxkL3P8")!

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .onReceive(NotificationCenter.default.publisher(for: .didTriggerQuickAction)) { note in
                    if let action = (note.userInfo?["action"] as? QuickAction) ?? AppDelegate.pendingQuickAction {
                        AppDelegate.pendingQuickAction = nil
                        handleQuickAction(action)
                    }
                }
                .onAppear { consumePendingQuickActionIfAny() }
        }
        .onChange(of: scenePhase) { if $0 == .active { consumePendingQuickActionIfAny() } }
    }

    @MainActor private func consumePendingQuickActionIfAny() {
        if let action = AppDelegate.pendingQuickAction {
            AppDelegate.pendingQuickAction = nil
            handleQuickAction(action)
        }
    }

    @MainActor
    private func handleQuickAction(_ action: QuickAction) {
        switch action {
        case .sendFeedback:
            openURL(websiteURL)
        case .annualPlan:
            // Note: prefer Superwall events if that aligns with your rules engine.
            print("Quick Action: Annual Plan tapped")
#if canImport(SuperwallKit)
            Superwall.shared.register(placement: "free_trial")
#else
            SuperwallShim.register(placement: "free_trial")
#endif
        }
    }
}

