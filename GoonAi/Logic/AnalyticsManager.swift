import SwiftUI
#if canImport(Mixpanel)
import Mixpanel
#endif
#if canImport(SuperwallKit)
import SuperwallKit
#endif

#if !canImport(Mixpanel)
protocol MixpanelType {}
struct MixpanelShim {
    static func identify(distinctId: String) {}
    static func peopleSet(_ properties: [String: MixpanelType]) {}
    static func registerSuperProperties(_ properties: [String: MixpanelType]) {}
    static func track(event: String, properties: [String: MixpanelType]?) {}
}
#endif

#if !canImport(SuperwallKit)
struct SuperwallShim2 {
    static func identify(userId: String) {}
    static func setUserAttributes(_ attributes: [String: Any]) {}
}
#endif

class AnalyticsManager {

    typealias Properties = [String: Any]
    typealias Event = String

    static let shared = AnalyticsManager()

    func identify(name: String?, userId: String, email: String) {
        let attributes: [String: Any] = [
            "name": name ?? "",
            "email": email
        ]

        // Mixpanel
#if canImport(Mixpanel)
        Mixpanel.mainInstance().identify(distinctId: userId)
        Mixpanel.mainInstance().people.set(properties: attributes as? [String: MixpanelType] ?? [:])
#else
        MixpanelShim.identify(distinctId: userId)
        MixpanelShim.peopleSet(attributes as? [String: MixpanelType] ?? [:])
#endif

        // Superwall
#if canImport(SuperwallKit)
        Superwall.shared.identify(userId: userId)
        Superwall.shared.setUserAttributes(attributes)
#else
        SuperwallShim2.identify(userId: userId)
        SuperwallShim2.setUserAttributes(attributes)
#endif
    }

    func updateUserAttributes(attributes: [String: Any]) {
#if canImport(Mixpanel)
        Mixpanel.mainInstance().people.set(properties: attributes as? [String: MixpanelType] ?? [:])
        Mixpanel.mainInstance().registerSuperProperties(attributes as? [String: MixpanelType] ?? [:])
#else
        MixpanelShim.peopleSet(attributes as? [String: MixpanelType] ?? [:])
        MixpanelShim.registerSuperProperties(attributes as? [String: MixpanelType] ?? [:])
#endif
#if canImport(SuperwallKit)
        Superwall.shared.setUserAttributes(attributes)
#else
        SuperwallShim2.setUserAttributes(attributes)
#endif
    }

    func trackEvent(eventName: Event, properties: Properties? = nil) {
        trackMixpanel(eventName, properties: properties)
    }

    private func trackMixpanel(_ event: String, properties: Properties? = nil) {
#if canImport(Mixpanel)
        Mixpanel.mainInstance().track(event: event, properties: properties as? [String: MixpanelType])
#else
        MixpanelShim.track(event: event, properties: properties as? [String: MixpanelType])
#endif
    }
}
