import Foundation

@propertyWrapper
struct Injected<T> {
    private var service: T?
    
    public var wrappedValue: T {
        mutating get {
            if service == nil {
                service = DIContainer.shared.resolve(T.self)
            }
            return service!
        }
        set { service = newValue }
    }
    
    init() {}
} 