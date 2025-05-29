import Foundation

public class UserAccountManager {
    static let shared = UserAccountManager()
    
    // Stub: Returns true if the user is a paid user, false otherwise
    // In production, this would check the user's subscription status from the backend or local storage
    func isPaidUser() -> Bool {
        // TODO: Implement real subscription check
        return false
    }
} 