import Foundation

final class ServiceProvider {
    static func registerServices() {
        let container = DIContainer.shared
        // Register repositories
        container.register(UserRepositoryProtocol.self, service: UserRepository())
        container.register(SermonRepositoryProtocol.self, service: SermonRepository())
        container.register(NoteRepositoryProtocol.self, service: NoteRepository())
        container.register(SubscriptionRepositoryProtocol.self, service: SubscriptionRepository())
        // Register other services as needed
    }
} 