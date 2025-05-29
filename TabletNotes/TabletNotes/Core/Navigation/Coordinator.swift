import Foundation
import SwiftUI

protocol Coordinator: AnyObject {
    associatedtype Route
    var navigationPath: [Route] { get set }
    func start() -> AnyView
    func navigate(to route: Route)
    func pop()
}

class BaseCoordinator<Route>: Coordinator {
    var navigationPath: [Route] = []
    
    func start() -> AnyView {
        // Override in subclass
        AnyView(EmptyView())
    }
    
    func navigate(to route: Route) {
        navigationPath.append(route)
    }
    
    func pop() {
        _ = navigationPath.popLast()
    }
} 