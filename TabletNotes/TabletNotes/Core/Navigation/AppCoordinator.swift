import Foundation
import SwiftUI

class AppCoordinator: BaseCoordinator<AppRoute> {
    override func start() -> AnyView {
        // TODO: Return the root view
        AnyView(Text("Root View"))
    }
}

enum AppRoute {
    case dashboard
    case recording
    case transcription
    case settings
    case onboarding
    case authentication
    case subscription
    // Add more routes as needed
} 