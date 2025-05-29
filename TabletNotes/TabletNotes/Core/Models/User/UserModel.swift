import Foundation

struct UserModel: Identifiable, Codable {
    var id: String = UUID().uuidString
    // Add more user properties as needed
} 