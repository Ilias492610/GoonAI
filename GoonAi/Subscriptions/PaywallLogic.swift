import SwiftUI
#if canImport(SuperwallKit)
import SuperwallKit
#endif

#if !canImport(SuperwallKit)
// Fallback protocol and types to mirror the real API shape just enough to compile
protocol SuperwallDelegate {}

struct SuperwallEventInfo {
    let event: Event
    enum Event {
        case transactionComplete(transaction: Transaction?, product: Product, transactionType: TransactionType, paywallInfo: PaywallInfo)
        case defaultEvent
        var description: String { "default" }
    }
    init() { self.event = .defaultEvent }
}

// Minimal placeholder types used by the app code
struct Transaction { var sk2Transaction: SK2Transaction? }
struct SK2Transaction { var productID: String }
struct Product {
    var productIdentifier: String
    var price: Double
    var currencyCode: String?
    var localizedPrice: String
    var period: String
}

enum TransactionType: String { case purchase, restore, trial }
struct PaywallInfo { var name: String }

struct SuperwallShim3 {
    static func register(placement: String) {}
}
#endif

class ViewController: UIViewController, SuperwallDelegate {
    @AppStorage("age") private var userAge: Int = 0
    func pressedButton() {
        if userAge < 18 {
#if canImport(SuperwallKit)
            Superwall.shared.register(placement: "under18")
#else
            SuperwallShim3.register(placement: "under18")
#endif
        } else if userAge <= 22 {
#if canImport(SuperwallKit)
            Superwall.shared.register(placement: "age18to22")
#else
            SuperwallShim3.register(placement: "age18to22")
#endif
        } else if userAge <= 28 {
#if canImport(SuperwallKit)
            Superwall.shared.register(placement: "age23to28")
#else
            SuperwallShim3.register(placement: "age23to28")
#endif
        } else if userAge <= 40 {
#if canImport(SuperwallKit)
            Superwall.shared.register(placement: "age29to40")
#else
            SuperwallShim3.register(placement: "age29to40")
#endif
        } else if userAge > 40 {
#if canImport(SuperwallKit)
            Superwall.shared.register(placement: "over40")
#else
            SuperwallShim3.register(placement: "over40")
#endif
        }
    }

    func fiftyOff() {
#if canImport(SuperwallKit)
        Superwall.shared.register(placement: "fiftyOff")
#else
        SuperwallShim3.register(placement: "fiftyOff")
#endif
    }
    
    func free_trial() {
#if canImport(SuperwallKit)
        Superwall.shared.register(placement: "free_trial")
#else
        SuperwallShim3.register(placement: "free_trial")
#endif
    }

    func handleSuperwallEvent(withInfo eventInfo: SuperwallEventInfo) {
        
        guard case let .transactionComplete(transaction, product, transactionType, paywallInfo) = eventInfo.event else {
            print("Default event: \(eventInfo.event.description)")
            
            return
        }

        print("TRANSACTION CONFIRMED")
        
        guard let sk2Transaction = transaction?.sk2Transaction else { return }
        
        let productDetails: [String: Double] = [
            "monthly": 14.99,
            "yearly": 29.99,
            "monthly_3d": 12.99,
            "yearly_3d": 49.99,
            "yearly_3d_trial": 19.99,
            "monthly_999": 9.99,
            "yearly_49": 19.99,
            "weekly": 4.99,
            "yearly_quittr": 39.99,
            "yearly_99": 49.99,
        ]

        AnalyticsManager.shared.trackEvent(eventName: "paywall_purchase_successful", properties: ["paywall_variant": paywallInfo.name,
                                                                                                  "transaction_type": transactionType.rawValue,
                                                                                                  "product_id": product.productIdentifier,
                                                                                                  "raw_price": product.price,
                                                                                                  "currency": product.currencyCode ?? "",
                                                                                                  "price": product.localizedPrice,
                                                                                                  "duration": product.period
                                                                                                 ])

        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        if let revenue = productDetails[sk2Transaction.productID] {
            print("\(revenue), currency: 'USD'")
//            event?.setRevenue(revenue, currency: "USD")
//            Adjust.trackEvent(event)
        } else {
            print("Unhandled productID: \(sk2Transaction.productID)")
        }
        
        handleSuccess()
    }
    
    func handleSuccess() {
        PersistanceManager.shared.saveFile(.firstLogin, value: true)
        PersistanceManager.shared.saveFile(.communitySheet, value: true)
        let view = MainTabView()
        NavigationManager.shared.presentView(view)
    }
}

