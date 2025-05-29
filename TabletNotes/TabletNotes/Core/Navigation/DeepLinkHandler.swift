import Foundation

enum DeepLinkType {
    case sermon(id: String)
    case note(id: String)
    case subscription
    // Add more as needed
}

final class DeepLinkHandler {
    static func handle(_ url: URL) -> DeepLinkType? {
        // TODO: Parse URL and return appropriate DeepLinkType
        return nil
    }
} 