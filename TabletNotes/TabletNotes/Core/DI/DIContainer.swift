import Foundation

final class DIContainer {
    static let shared = DIContainer()
    private var services: [String: Any] = [:]
    
    private init() {}
    
    func register<T>(_ type: T.Type, service: T) {
        let key = String(describing: type)
        services[key] = service
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        return services[key] as? T
    }
} 