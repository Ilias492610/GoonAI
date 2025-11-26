//
//  ScreenTimeManager.swift
//  GoonAi
//
//  Centralized helper for requesting Screen Time permission and
//  enabling the default porn-site restrictions the app relies on.
//

import Foundation
import FamilyControls
import ManagedSettings
import Combine

@MainActor
final class ScreenTimeManager: ObservableObject {
    static let shared = ScreenTimeManager()
    
    @Published private(set) var authorizationStatus: FamilyControls.AuthorizationStatus = .notDetermined
    @Published private(set) var isBlockingActive: Bool = false
    
    private let store = ManagedSettingsStore()
    private init() {
        Task { await refreshStatus() }
    }
    
    func refreshStatus() async {
        let status = FamilyControls.AuthorizationCenter.shared.authorizationStatus
        await MainActor.run {
            authorizationStatus = status
        }
        evaluateBlockingState()
    }
    
    func requestAuthorizationIfNeeded() async throws {
        let status = FamilyControls.AuthorizationCenter.shared.authorizationStatus
        guard status != .approved else { return }
        try await FamilyControls.AuthorizationCenter.shared.requestAuthorization(for: .individual)
        await refreshStatus()
    }
    
    func enableDefaultRestrictions() async throws {
        try await requestAuthorizationIfNeeded()
        applyPornShield()
    }
    
    func disableRestrictions() {
        store.shield.webDomains = nil
        store.shield.applicationCategories = nil
        store.shield.applications = nil
        evaluateBlockingState()
    }
    
    // MARK: - Private Helpers
    
    private func applyPornShield() {
        let domains = [
            "pornhub.com",
            "www.pornhub.com",
            "m.pornhub.com",
            "xnxx.com",
            "xvideos.com"
        ]
        if #available(iOS 17.0, *) {
            let domainTokens: Set<WebDomainToken> = Set(domains.compactMap { WebDomain(domain: $0).token })
            store.shield.webDomains = domainTokens
        } else {
            // On iOS 16, shielding specific web domains isn't available. Consider shielding categories or apps instead.
        }
        evaluateBlockingState()
    }
    
    private func evaluateBlockingState() {
        if #available(iOS 17.0, *) {
            let hasDomains = (store.shield.webDomains?.isEmpty == false)
            isBlockingActive = hasDomains
        } else {
            isBlockingActive = false
        }
    }
}

