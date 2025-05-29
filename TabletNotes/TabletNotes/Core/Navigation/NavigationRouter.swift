import Foundation
import SwiftUI

final class NavigationRouter: ObservableObject {
    @Published var currentRoute: AppRoute? = nil
    
    func navigate(to route: AppRoute) {
        currentRoute = route
    }
    
    func reset() {
        currentRoute = nil
    }
} 