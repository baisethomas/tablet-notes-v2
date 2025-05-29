import Foundation

protocol SubscriptionRepositoryProtocol {
    func fetchSubscription(by id: String) -> SubscriptionPlan?
    func saveSubscription(_ subscription: SubscriptionPlan)
    func deleteSubscription(by id: String)
}

class SubscriptionRepository: SubscriptionRepositoryProtocol {
    func fetchSubscription(by id: String) -> SubscriptionPlan? {
        // TODO: Implement fetch logic
        return nil
    }
    
    func saveSubscription(_ subscription: SubscriptionPlan) {
        // TODO: Implement save logic
    }
    
    func deleteSubscription(by id: String) {
        // TODO: Implement delete logic
    }
} 